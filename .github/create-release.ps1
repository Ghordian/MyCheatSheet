# Script para crear release ZIP
# Ejecutar desde la carpeta del addon

$version = "1.0.0"
$zipName = "MyCheatSheet-v$version.zip"

# Archivos a incluir en el release
$filesToInclude = @(
    "MyCheatSheet.toc",
    "core.lua",
    "data.lua", 
    "config.lua",
    "validdata.lua",
    "edit.lua",
    "export.lua",
    "bindings.lua",
    "embeds.xml",
    "types.lua",
    "Bindings.xml",
    "locale",
    "Libs"
)

# Crear carpeta temporal
$tempDir = "temp_release"
New-Item -ItemType Directory -Force -Path $tempDir
New-Item -ItemType Directory -Force -Path "$tempDir\MyCheatSheet"

# Copiar archivos
foreach ($item in $filesToInclude) {
    if (Test-Path $item) {
        Copy-Item -Path $item -Destination "$tempDir\MyCheatSheet\" -Recurse -Force
        Write-Host "✅ Copied: $item"
    } else {
        Write-Host "⚠️  Not found: $item"
    }
}

# Crear ZIP
Compress-Archive -Path "$tempDir\MyCheatSheet" -DestinationPath $zipName -Force

# Limpiar
Remove-Item $tempDir -Recurse -Force

Write-Host "🎉 Created: $zipName"
Write-Host "📁 Ready for GitHub release!"
