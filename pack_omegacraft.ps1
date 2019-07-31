$time = Get-Date -UFormat %H%M%S
$date = Get-Date -UFormat %Y%m%d
$timestamp = $date + "T" + $time
$destination = "Q:\games\Minecraft\textureedit\omegacraft14\backup_omegacraft14_" + $timestamp + ".zip"

# Backup resource pack
	Write-Host "Backing up omegacraft14..."
	Move-Item -Path "Q:\games\Minecraft\textureedit\omegacraft14\omegacraft14.zip" -Destination $destination
	Write-Host "Done."

# Create new pack and move it
	7z a "Q:\games\Minecraft\textureedit\omegacraft14\omegacraft14.zip" "Q:\games\Minecraft\textureedit\omegacraft14\OmegaCraft-Resource-Pack\omegacraft14\*"
	Move-Item -Path "Q:\games\Minecraft\textureedit\omegacraft14\omegacraft14.zip" -Destination "Q:\games\Minecraft\textureedit\omegacraft14\omegacraft14.zip" -Force

# Calculate SHA1 hash for server deployment
	$Hash = Get-FileHash -Algorithm SHA1 "Q:\games\Minecraft\textureedit\omegacraft14\omegacraft14.zip"
	Write-Host "`nSHA1 Hash: " $Hash.Hash
	Set-Clipboard -Value $Hash.Hash
	Write-Host "`nSHA1 Hash copied to clipboard."

# Copy resource pack to resource pack folder
	Copy-Item "Q:\games\Minecraft\textureedit\omegacraft14\omegacraft14.zip" -Destination "$env:appdata\.minecraft\resourcepacks" -Force
	Write-Host "`nCopied to Minecraft resourcepacks folder."

# Send the resource pack to the server
	scp -P 23466 "Q:\games\Minecraft\textureedit\omegacraft14\omegacraft14.zip" root@www:/var/www/snipeit/public/minecraft
	ssh -p 23466 root@www 'chown -v snipeitapp:apache /var/www/snipeit/public/minecraft/omegacraft14.zip'
	Write-Host "`nCopied to web server."

Write-Host "`nPress any key to continue...";
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

