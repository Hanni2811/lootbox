$root = $PSScriptRoot
$rarities = 'common','rare','epic','legendary','mythic'
$list = foreach ($r in $rarities) {
    Get-ChildItem "$root\emotes\$r" -Filter *.gif -ErrorAction SilentlyContinue | Sort-Object Name | ForEach-Object {
        [pscustomobject]@{ id = $_.BaseName; name = $_.BaseName; rarity = $r; file = "emotes/$r/$($_.Name)" }
    }
}
ConvertTo-Json -InputObject @($list) -Depth 3 | Set-Content "$root\emotes.json" -Encoding UTF8
Write-Host "$(@($list).Count) Emotes eingetragen."
Pause