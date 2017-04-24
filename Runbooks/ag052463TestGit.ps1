$Content = (Invoke-WebRequest -Uri  "https://raw.githubusercontent.com/cerner-ebi/data-integration-deployment/master/Runbooks/test.json" -UseBasicParsing).content 
$json = ConvertFrom-Json -InputObject $Content
$json.CodeFolder = "https://raw.githubusercontent.com/cerner-ebi/data-integration-deployment/master/Runbooks/"
echo $json