Install-Module -Name Az.ResourceGraph;
$kqlQuery='
resources
| project name, location, id, type, kind, properties, subnet=properties.subnet.id, NICs=properties.networkInterfaces, pep_services=properties.privateLinkServiceConnections
| mv-expand pep_services
| extend TotalNICs=array_length(properties.networkInterfaces), custom_rules=array_length(properties.securityRules)
| project location, name, id, type, kind, pep_service=pep_services.properties.privateLinkServiceId, VM=properties.virtualMachine, TotalNICs, custom_rules
| sort by id asc
';

$batchSize = 1000
$skipResult = 0 

[System.Collections.Generic.List[string]]$kqlResult 

while ($true) {

    if ($skipResult -gt 0) {
        $graphResult = Search-AzGraph -Query $kqlQuery   -first $batchSize -SkipToken $graphResult.SkipToken
    } 
    else {
        $graphResult = Search-AzGraph -Query $kqlQuery   -first $batchSize 
    }

    $kqlResult += $graphResult.data

    if ($graphResult.data.Count -lt $batchSize) {
        break;
    }
    $skipResult += $skipResult + $batchSize
}

$kqlResult | Export-csv -path SiteSurvey.csv 


