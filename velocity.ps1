function Get-VelocityCwd {
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
            $uncommittedChanges = (git status --porcelain).Split("`n").Count
            $commitsAhead = (git rev-list --count "@{u}..HEAD")
            $commitsBehind = (git rev-list --count "HEAD..@{u}")
            $gitText = "`e[0m`e[90m$gitBranch`e[0m"
            if ($uncommittedChanges -gt 0) { $gitText += " `e[93m✎ $uncommittedChanges`e[0m" }
            if ($commitsAhead -gt 0) { $gitText += " `e[92m↑$commitsAhead`e[0m" }
            if ($commitsBehind -gt 0) { $gitText += " `e[91m↓$commitsBehind`e[0m" }
            return "$gitText "
        }
    } else {
        return ""
    }
}

function Prompt {
    $cwd = Get-VelocityCwd
    $git = Get-VelocityGitText
    
    Write-Host "$cwd " -NoNewline
    Write-Host $git -NoNewline
    if ($?) {
        Write-Host "`e[97m❱`e[0m" -NoNewline
    } else {
        Write-Host "`e[91m❱`e[0m" -NoNewline
    }
    return " "
}