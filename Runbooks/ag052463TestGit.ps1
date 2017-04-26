    
    $CredentialAssetName =  'ag052463'    
        
    #Get the credential with the above name from the Automation Asset store 
    $Cred = Get-AutomationPSCredential -Name $CredentialAssetName 
    if(!$Cred) { 
        Throw "Could not find an Automation Credential Asset named '${CredentialAssetName}'. Make sure you have created one in this Automation Account." 
    } 

    #Connect to your Azure Account        
    Add-AzureRmAccount -Credential $Cred

    Get-AzureRmSubscription -SubscriptionName "CernerCorpDataIntDev" | Select-AzureRmSubscription

    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
    $client = New-Object System.Net.WebClient
    $client.Headers.Add("Authorization","token f1d79eabf3312792c763d2eeda5795282b7db872")
    $client.Headers.Add("Accept","application/vnd.github.v3.raw")


    $stream = $client.OpenRead("https://github.cerner.com/api/v3/repos/Data-And-Integration/data-integration/contents/projects/CMS/appdata.json?ref=development")
    $reader = New-Object System.IO.StreamReader($stream)
    $stringcontent = $reader.ReadToEnd()
    $stringcontent
    $Appprops = ConvertFrom-Json ($stringcontent)
    $content = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($Appprops.content))
    $stream.close()

    if(!$Appprops){
        Throw "Could not find the file named '${CredentialAssetName}'. Make sure you have created one in this GitHub location"
    }

    #Start Deploying Linked Services
    $stream = $client.OpenRead("https://github.cerner.com/api/v3/repos/Data-And-Integration/data-integration/contents/projects/CMS/DataFactory/Linked_Services?ref=development")
    $reader = New-Object System.IO.StreamReader($stream)
    $stringcontent = $reader.ReadToEnd()
    $linked_services = ConvertFrom-Json ($stringcontent)
    $stream.close()

    foreach ($ls in $linked_services)
        {
        #Get the content of file within the linked Services
        $stream = $client.OpenRead("https://github.cerner.com/api/v3/repos/Data-And-Integration/data-integration/contents/projects/CMS/DataFactory/Linked_Services/{0}?ref=development" -f $ls.name)
        $reader = New-Object System.IO.StreamReader($stream)
        $stringcontent = $reader.ReadToEnd()
        $file =  ConvertFrom-Json ($stringcontent)
        $content = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($file.content))
        $content
        $filel = New-Item $file.name -type file -value $content
        echo("pspath--------------------------------------------------------------------------->")
        $filel.PSPath
        
        
        #Extract name of the file
            $filename = $file.name.Split(".")
            $filename[0]
            if(!($filename[1].Equals("json")))
            {
                    Throw "Invalid file format. Please make sure the file format is json"
            }

            #Create a new linked service instance
            #New-AzureRmDataFactoryLinkedService -ResourceGroupName $Appprops.ResourceGrpName -DataFactoryName $Appprops.DataFactoryName -Name $filename[0] -File $filel.PSPath -Force | Format-List
            echo ("filel--------------------------->$filel")		
            Remove-Item $filel.PSPath
            echo "Deployed Linked Service: $filename[0]"
            $stream.close()
    }
