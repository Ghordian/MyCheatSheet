param(
    [string]$WoWPath = "D:\World of Warcraft\_retail_\Interface\AddOns"
)

# Función para calcular ruta relativa (compatible con PowerShell 5.1)
function Get-RelativePath($base, $path) {
    $base = [System.IO.Path]::GetFullPath($base)
    $path = [System.IO.Path]::GetFullPath($path)
    if ($path.StartsWith($base)) {
        return $path.Substring($base.Length).TrimStart('\')
    } else {
        return $path
    }
}
# deploy.ps1 - Script inteligente para copiar addon

$AddonName = "MyCheatSheet"
$SourcePath = (Resolve-Path (Join-Path $PSScriptRoot ".."))
$SourcePath = $SourcePath.Path
$DestinationPath = Join-Path $WoWPath $AddonName
$TocFile = Join-Path $SourcePath "$AddonName.toc"

Write-Host "=== MyCheatSheet Smart Deploy Script ===" -ForegroundColor Cyan
Write-Host "Source: $SourcePath" -ForegroundColor Gray
Write-Host "Destination: $DestinationPath" -ForegroundColor Gray

if (!(Test-Path $TocFile)) {
    Write-Host "ERROR: .toc file not found" -ForegroundColor Red
    exit 1
}

function Get-TocFiles {
    param($TocPath)
    $files = @()
    $content = Get-Content $TocPath -Encoding UTF8
    foreach ($line in $content) {
        $line = $line.Trim()
        if ($line.StartsWith("#") -or $line.StartsWith("##") -or [string]::IsNullOrWhiteSpace($line)) {
            continue
        }
        $files += $line
    }
    return $files
}

function Get-EmbeddedFiles {
    param($XmlPath, $BasePath)
    $files = @()
    if (!(Test-Path $XmlPath)) {
        return $files
    }
    try {
        [xml]$xmlContent = Get-Content $XmlPath -Encoding UTF8
        
        # Obtener el directorio del archivo XML actual para rutas relativas
        $xmlDir = Split-Path $XmlPath -Parent
        $xmlRelativeDir = ""
        
        # Solo calcular ruta relativa si no estamos en el directorio base
        if ($xmlDir -ne $BasePath) {
            $xmlRelativeDir = $xmlDir.Substring($BasePath.Length + 1) -replace "\\", "\"
        }
        
        # Obtener archivos Script directamente
        if ($xmlContent.Ui.Script) {
            foreach ($script in $xmlContent.Ui.Script) {
                if ($script.file) {
                    $absPath = Join-Path $xmlDir $script.file
                    $relPath = Get-RelativePath $BasePath $absPath
                    $files += $relPath
                }
            }
        }
        
        # Obtener archivos Include y procesar recursivamente
        if ($xmlContent.Ui.Include) {
            foreach ($include in $xmlContent.Ui.Include) {
                if ($include.file) {
                    $absInclude = Join-Path $xmlDir $include.file
                    $relInclude = Get-RelativePath $BasePath $absInclude
                    $files += $relInclude
                    $includePath = Join-Path $BasePath $relInclude
                    $nestedFiles = Get-EmbeddedFiles $includePath $BasePath
                    $files += $nestedFiles
                }
            }
        }
    }
    catch {
        Write-Host "Warning: Could not parse XML file $XmlPath - $($_.Exception.Message)" -ForegroundColor Yellow
    }
    return $files
}

function Copy-WithStructure {
    param($Source, $Destination, $File)
    $sourceFile = Join-Path $Source $File
    $destFile = Join-Path $Destination $File
    $destDir = Split-Path $destFile -Parent
    
    if (!(Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }
    
    # Intentar buscar el archivo con diferentes casos (case-insensitive en Windows)
    if (Test-Path $sourceFile) {
        Copy-Item $sourceFile $destFile -Force
        return $true
    } else {
        # Buscar con case-insensitive si no se encuentra exacto
        $parentDir = Split-Path $sourceFile -Parent
        $fileName = Split-Path $sourceFile -Leaf
        
        if (Test-Path $parentDir) {
            $actualFile = Get-ChildItem -Path $parentDir -Filter $fileName -ErrorAction SilentlyContinue | Select-Object -First 1
            if ($actualFile) {
                Copy-Item $actualFile.FullName $destFile -Force
                return $true
            }
        }
    }
    return $false
}

if (!(Test-Path $DestinationPath)) {
    New-Item -ItemType Directory -Path $DestinationPath -Force | Out-Null
    Write-Host "Created addon directory" -ForegroundColor Green
} else {
    Write-Host "Cleaning existing addon directory..." -ForegroundColor Yellow
    Remove-Item -Path "$DestinationPath\*" -Recurse -Force
}

Write-Host "Parsing .toc file..." -ForegroundColor Yellow
$tocFiles = Get-TocFiles $TocFile
Write-Host "Found $($tocFiles.Count) files referenced in .toc" -ForegroundColor Gray

$allFiles = @()
$allFiles += $tocFiles

foreach ($file in $tocFiles) {
    if ($file.EndsWith(".xml")) {
        $xmlPath = Join-Path $SourcePath $file
        $embeddedFiles = Get-EmbeddedFiles $xmlPath $SourcePath
        Write-Host "Found $($embeddedFiles.Count) embedded files in $file" -ForegroundColor Gray
        $allFiles += $embeddedFiles
    }
}


# Asegurar que Bindings.xml esté incluido
if (-not ($allFiles -contains "Bindings.xml")) {
    $allFiles += "Bindings.xml"
}
$uniqueFiles = @("$AddonName.toc") + ($allFiles | Sort-Object | Get-Unique)

Write-Host "Copying addon files..." -ForegroundColor Yellow
$FilesCopied = 0
$FilesSkipped = 0

foreach ($file in $uniqueFiles) {
    if (Copy-WithStructure $SourcePath $DestinationPath $file) {
        $FilesCopied++
        Write-Host "  + $file" -ForegroundColor Green
    } else {
        $FilesSkipped++
        Write-Host "  - $file (not found)" -ForegroundColor Red
    }
}

Write-Host ""

# Copiar carpeta Images a la raíz del addon
$imagesSource = Join-Path $SourcePath "Images"
$imagesDest = Join-Path $DestinationPath "Images"
if (Test-Path $imagesSource) {
    Write-Host "Copying Images folder..." -ForegroundColor Yellow
    Copy-Item $imagesSource $imagesDest -Recurse -Force
    Write-Host "Images folder copied successfully." -ForegroundColor Green
} else {
    Write-Host "Images folder not found, skipping copy." -ForegroundColor Yellow
}

Write-Host "Deploy Summary:" -ForegroundColor Cyan
Write-Host "  Files copied: $FilesCopied" -ForegroundColor Green
Write-Host "  Files skipped: $FilesSkipped" -ForegroundColor Yellow

if ($FilesSkipped -eq 0) {
    Write-Host "Addon deployed successfully!" -ForegroundColor Green
} else {
    Write-Host "Addon deployed with warnings" -ForegroundColor Yellow
}

Write-Host "Reinicia WoW o usa /reload para cargar los cambios" -ForegroundColor Yellow
