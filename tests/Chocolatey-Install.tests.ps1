$here = Split-Path -Parent $MyInvocation.MyCommand.Definition
$src = Join-Path (Split-Path $here) 'src'
$script = Join-Path $src 'chocolatey.ps1'

. $script

function Chocolatey-PackagesConfig {
  $script:chocolatey_packages_was_called = $true
}

function Chocolatey-NuGet {
  $script:chocolatey_nuget_was_called = $true
}

Describe "When installing packages from a manifest" {

  Chocolatey-Install "TestDrive:\packages.config"

  It "should call the chocolatey packages config function" {
    $script:chocolatey_packages_was_called.should.be($true)
  }

}

Describe "When installing a package that happens to end in 'packages.config'" {

  Chocolatey-Install "fake.packages.config"
  
  It "should call Chocolatey NuGet as if to download the package" {
    $script:chocolatey_nuget_was_called.should.be($true)
  }

}