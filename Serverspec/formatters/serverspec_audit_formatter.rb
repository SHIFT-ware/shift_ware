require 'rspec/core/formatters/documentation_formatter'
require 'specinfra'
require 'serverspec/version'
require 'serverspec/type/base'
require 'serverspec/type/command'
require 'fileutils'

class ServerspecAuditFormatter < RSpec::Core::Formatters::DocumentationFormatter
  RSpec::Core::Formatters.register self, :example_group_started, :example_passed, :example_pending, :example_failed

  def initialize(output)
    super
    @seq = 0
  end

  def example_group_started(notification)
    @seq = 0 if @group_level == 0
    super
  end

  def example_passed(notification)
    save_evidence(notification.example)
    super
  end

  def example_pending(notification)
    save_evidence(notification.example)
    super
  end

  def example_failed(notification)
    save_evidence(notification.example, notification.exception)
    super
  end

  def save_evidence(example, exception=nil)
    # 以下のように、トップレベルに結果ディレクトリ名として使う名称を指定する前提
    # describe "テストケース1" do
    #   describe command('hostname') do
    #     its(:stdout) { should ... }
    #   end
    # end
    #name = example.example_group.top_level_description
    path = example.example_group.file_path.gsub("./spec/","")

    # 出力先ディレクトリを {ホスト名}/{テスト名}/{連番} で作成
    host = ENV['TARGET_HOST'] || Specinfra.configuration.host
    @seq += 1
#    d = "log/#{host}/#{name}/#{@seq}"
    d = "log/#{host}/#{path}"
    if @seq == nil || @seq == 1
      FileUtils.mkdir_p(d)
      File.write(d + '/Serverspec_Debug.log', host + "\n")
    end

    # 実行内容をファイル出力
    Dir.chdir(d) do
      File.open('Serverspec_Debug.log', 'a') do |file|
        # 実行コマンド
        file.puts "[" + @seq.to_s + "]"
        file.puts "***Command***"
        file.puts example.metadata[:command]
        file.puts "\n"
        # 標準出力
        file.puts "***Stdout***"
        if example.metadata[:stdout]
          file.puts example.metadata[:stdout]
          file.puts "\n"
        end
      end
      # RSpecのエラーメッセージ
      if exception
        File.open('Serverspec_Debug.log', 'a') do |file|
          file.puts "***Exception***"
          file.puts exception.message
          file.puts "\n"
        end
      end
      # 標準エラー出力と終了ステータス（commandリソースのみ）
      resource = example.metadata[:described_class]
      if resource.kind_of? Serverspec::Type::Command
        File.open('Serverspec_Debug.log', 'a') do |file|
          file.puts "***StdErr***"
          unless resource.stderr.to_s.empty?
            file.puts resource.stderr
          end
          file.puts "***ExitStatus***"
          file.puts resource.exit_status
          file.puts "\n"
        end
      end
      File.open('Serverspec_Debug.log', 'a') do |file|
        file.puts "\n"
        file.puts "\n"
      end
      ## 実行コマンド
      #File.write('command.txt', example.metadata[:command])
      ## 標準出力
      #File.write('stdout.txt', example.metadata[:stdout]) if example.metadata[:stdout]
      ## RSpecのエラーメッセージ
      #File.open('exception.txt', 'w') {|f| f.puts exception.message } if exception
      ## 標準エラー出力と終了ステータス（commandリソースのみ）
      #resource = example.metadata[:described_class]
      #if resource.kind_of? Serverspec::Type::Command
      #  File.write('stderr.txt', resource.stderr) unless resource.stderr.to_s.empty?
      #  File.write('exit_status.txt', resource.exit_status)
      #end
    end
  end
end
