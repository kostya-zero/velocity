$u="https://raw.githubusercontent.com/kostya-zero/velocity/main/velocity.ps1";$p=$PROFILE;$d=Split-Path $p -Parent;ni $d -Type Directory -Force -EA 0;$s=Join-Path $d (Split-Path $u -Leaf);irm $u -OutFile $s;if(!(Test-Path $p)){ni $p -Type File -Force};$l=". `"$s`"";if(!(sls -Path $p -Pattern ([regex]::Escape($l)) -Quiet)){ac $p "`n$l"}