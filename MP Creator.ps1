#Simple Management Pack Creator v0.1
#Written entirely by Arkam Mazrui
#arkam.mazrui@nserc-crsng.gc.ca
#arkam.mazrui@gmail.comv

cd $PSScriptRoot;
[xml]$default = Get-Content "Default.MP.xml";

function get-non-empty-input($msg) {
    $in = '';
    do {
        Write-Host -ForegroundColor Yellow "Do not enter a blank value.";
        $in = Read-Host $msg;
    } while ($in -eq '')
    return [string]$in;
}

function title {
    Write-Host "#############################################";
    Write-Host "#                                           #";
    Write-Host "#        Simple Management Pack Creator     #";
    Write-Host "#                    By                     #";
    Write-Host "#               Arkam Mazrui                #";
    Write-Host "#       arkam.mazrui@nserc-crsng.gc.ca      #";
    Write-Host "#          arkam.mazrui@gmail.com           #";
    Write-Host "#                                           #";
    Write-Host "#############################################";
}

title;
$mp_name = get-non-empty-input "Enter the Management Pack display name";
$mp_id = (get-non-empty-input "Enter the Management Pack ID (File name; do not include '.xml')").replace(' ','.');
$description = get-non-empty-input "Enter the description for the Management Pack";

$default.ManagementPack.Manifest.Name = $mp_name;
$default.ManagementPack.Manifest.Identity.Id = $mp_id;
$default.ManagementPack.LanguagePacks.LanguagePack | %{
    $_.DisplayStrings.DisplayString.ElementId = $mp_id;
    $_.DisplayStrings.DisplayString.Name = $mp_name;
    $_.DisplayStrings.DisplayString.Description = $description;
}

$filename = "$mp_id.xml";
$default.OuterXml | Out-File $filename;
