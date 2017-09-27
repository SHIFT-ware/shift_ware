$selectorset = @{}
$selectorset.Add('Transport', 'HTTPS')
$selectorset.Add('Address', '*')
Remove-WSManInstance -ResourceURI 'winrm/config/Listener'-SelectorSet $selectorset
