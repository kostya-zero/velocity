function Get-VelocityCwdText {
    $cwd = (Get-Location).Path

    # Add tilda if home directory.
    $homePath = $env:USERPROFILE
    $firstCwd = $cwd -replace [regex]::Escape($homePath), '~'
    $firstCwd = "`e[0;90m$firstCwd`e[0m"

    # Highlight current directory.
    $currentDirectoryName = Split-Path -Leaf $cwd
    $finalCwd = $firstCwd -replace [regex]::Escape($currentDirectoryName), "`e[1m`e[97m$currentDirectoryName`e[0m"

    return $finalCwd
}

function Get-VelocityGitText {
    if (Get-Command git -ErrorAction SilentlyContinue) {
        $gitBranch = git symbolic-ref --short HEAD
        if ($gitBranch) {
            return "`e[0m`e[90m$gitBranch`e[0m "
        }
    } else {
        return ""
    }
}

function Prompt {
    $cwd = Get-VelocityCwdText
    $git = Get-VelocityGitText
    
    Write-Host "$cwd " -NoNewline
    Write-Host $git -NoNewline
    Write-Host "`e[97m❱`e[0m " -NoNewline
    return ""
}