param (
  [Parameter(Position = 0)]
  [ValidateSet('install', 'update')]
  [string]
  $command
)

function refreshEnv {
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

switch ($command) {
  'install' {
    & {Invoke-WebRequest 'https://get.scoop.sh' -UseBasicParsing | Invoke-Expression}
    refreshEnv
    
    scoop install git nodejs
    
    scoop bucket add extras
    scoop install vscode
    code --install-extension eg2.tslint
    code --install-extension esbenp.prettier-vscode
  }
  'update' {
    scoop update
  }
  default {
    'Usage: dev <command>

Commands:
    install - Install dev tools.
    update - Update dev tools.
'
  }
}