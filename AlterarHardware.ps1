# Função para exibir um menu e obter a escolha do usuário
function Show-Menu {
    param (
        [string[]]$options,
        [string]$prompt
    )
    
    # Exibe as opções
    for ($i = 0; $i -lt $options.Length; $i++) {
        Write-Host "$($i + 1): $($options[$i])"
    }
    
    # Obtém a escolha do usuário
    $choice = Read-Host $prompt
    
    # Valida a escolha do usuário
    if ($choice -match '^\d+$' -and $choice -ge 1 -and $choice -le $options.Length) {
        return [int]$choice
    } else {
        Write-Host "Escolha inválida. Tente novamente."
        return Show-Menu -options $options -prompt $prompt
    }
}

# Definir opções de processador
$processorOptions = @(
    "Intel(R) Core(TM) i7-9700K CPU @ 3.60GHz",
    "AMD Ryzen 7 3700X"
)
$processorChoice = Show-Menu -options $processorOptions -prompt "Escolha o processador (1 para Intel, 2 para AMD):"

# Definir opções de GPU
$gpuOptions = @(
    "NVIDIA GeForce RTX 2060",
    "AMD Radeon RX 5600 XT",
    "Intel Arc A580"
)
$gpuChoice = Show-Menu -options $gpuOptions -prompt "Escolha a GPU (1 para NVIDIA, 2 para AMD, 3 para Intel):"

# Definir os novos valores com base na escolha do usuário
$newProcessorName = $processorOptions[$processorChoice - 1]
$newGpuName = $gpuOptions[$gpuChoice - 1]

# Define os caminhos base para as chaves do registro
$processorBaseKeyPath = "HKLM:\SYSTEM\ControlSet001\Enum\ACPI\AuthenticAMD_-_AMD64_Family_23_Model_96_-_AMD_Ryzen_5_4500U_with_Radeon_Graphics_________"
$gpuBaseKeyPath = "HKLM:\SYSTEM\ControlSet001\Control\Video\{39176416-9601-11ED-836A-806E6F6E6963}"

# Atualiza os nomes dos processadores
for ($i = 0; $i -le 5; $i++) {
    $processorKeyPath = "$processorBaseKeyPath\$i"
    if (Test-Path $processorKeyPath) {
        Set-ItemProperty -Path $processorKeyPath -Name "FriendlyName" -Value $newProcessorName
        Write-Host "Nome do processador $i atualizado para $newProcessorName."
    } else {
        Write-Host "Caminho do processador $i não encontrado: $processorKeyPath"
    }
}

# Atualiza os nomes das GPUs
for ($j = 0; $j -le 4; $j++) {
    $gpuKeyPath = "$gpuBaseKeyPath\000$j"
    if (Test-Path $gpuKeyPath) {
        Set-ItemProperty -Path $gpuKeyPath -Name "DriverDesc" -Value $newGpuName
        Write-Host "Nome da GPU $j atualizado para $newGpuName."
    } else {
        Write-Host "Caminho da GPU $j não encontrado: $gpuKeyPath"
    }
}