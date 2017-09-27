import winrm
import sys

args = sys.argv
s = winrm.Session(args[1], auth=('administrator', 'p@ssw0rd'))
r = s.run_cmd(args[2])

print r.std_out
