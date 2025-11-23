$content = Get-Content 'OrcaV2.lua' -Raw
$lines = $content -split "`n"
$line167 = $lines[166]

$start = 228235
$length = 400

if ($start -lt $line167.Length) {
    $actualLength = [Math]::Min($length, $line167.Length - $start)
    Write-Host "=== Extraction position $start (length $actualLength) ==="
    Write-Host $line167.Substring($start, $actualLength)
} else {
    Write-Host "Position $start dépasse la longueur de la ligne ($($line167.Length))"
}
