# Define os caminhos base para as chaves do registro
$processorBaseKeyPath = "HKLM:\SYSTEM\ControlSet001\Enum\ACPI\AuthenticAMD_-_AMD64_Family_23_Model_96_-_AMD_Ryzen_5_4500U_with_Radeon_Graphics_________"
$gpuBaseKeyPath = "HKLM:\SYSTEM\ControlSet001\Control\Video\{39176416-9601-11ED-836A-806E6F6E6963}"

# Define os novos valores
$newProcessorName = "Intel(R) Core(TM) i7-9700K CPU @ 3.60GHz"
$newGpuName = "NVIDIA GeForce GTX 1070"

# Atualiza os nomes dos processadores
for ($i = 0; $i -le 5; $i++) {
    $processorKeyPath = "$processorBaseKeyPath\$i"
    if (Test-Path $processorKeyPath) {
        Set-ItemProperty -Path $processorKeyPath -Name "FriendlyName" -Value $newProcessorName
        Write-Host "Nome do processador $i atualizado."
    } else {
        Write-Host "Caminho do processador $i não encontrado: $processorKeyPath"
    }
}

# Atualiza os nomes das GPUs
for ($j = 0; $j -le 4; $j++) {
    $gpuKeyPath = "$gpuBaseKeyPath\000$j"
    if (Test-Path $gpuKeyPath) {
        Set-ItemProperty -Path $gpuKeyPath -Name "DriverDesc" -Value $newGpuName
        Write-Host "Nome da GPU $j atualizado."
    } else {
        Write-Host "Caminho da GPU $j não encontrado: $gpuKeyPath"
    }
}