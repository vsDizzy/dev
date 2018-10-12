if ((Get-ExecutionPolicy) -gt 'RemoteSigned') {
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
}

function refreshEnv {
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

& {Invoke-WebRequest 'https://get.scoop.sh' -UseBasicParsing | Invoke-Expression}
refreshEnv
    
scoop install git nodejs
scoop install yarn
    
scoop bucket add extras
scoop install vscode
code --install-extension eg2.tslint
code --install-extension esbenp.prettier-vscode
