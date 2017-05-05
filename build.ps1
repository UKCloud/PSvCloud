param ($Task = 'Test')

# Grab nuget bits, install modules, set build variables, start build.
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null

Install-Module Psake, PSDeploy, BuildHelpers -Force -AllowClobber
Install-Module Pester -RequiredVersion 4.0.2 -Force -AllowClobber
Import-Module Psake, BuildHelpers

Set-BuildEnvironment

Invoke-psake -buildFile $ENV:BHProjectPath\psake.ps1 -taskList $Task -nologo
exit ( [int]( -not $psake.build_success ) )
