function Get-Confirm {
    $caption = "Please Confirm To Terminate Process Number $ProcessToKill"
    $message = "Are you Sure You Want To Proceed?"
    [int]$defaultChoice = 0
    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Terminate The Process"
    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Do not Terminate The Process"
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

    return $host.ui.PromptForChoice($caption, $message, $options, $defaultChoice)
}

$Port = Read-Host -Prompt 'What port would you like to free?'

$Output = Get-NetTCPConnection -LocalPort $Port -ErrorAction SilentlyContinue
if (!$Output) {
    Write-Host -ForegroundColor Red "Port is not used"
    exit
}

Write-Host -ForegroundColor Yellow ("Found {0} processes related to this port`n" -f @($Output).Count)
foreach ($item in $Output) {
    $ProcessToKill = $item.OwningProcess
    $choice = Get-Confirm

    if ( $choice -ne 1 ) {
        $taskKillCommand = taskkill.exe /PID $ProcessToKill /F 2>&1
        $taskKillError = $taskKillCommand | Where-Object{$_.gettype().Name -eq "ErrorRecord"}

        if ($taskKillError) {
            Write-Host -ForegroundColor Red "$taskKillError"
        } else {
            Write-Host -ForegroundColor Green "$taskKillCommand"
        }
    }
}
