try {
	$sPathDevelopmentHome = Get-EnvironmentVariable -Name "PATH_HOME" -Scope "User" 
	$sPathToolsHome = Join-Path $sPathDevelopmentHome "tools"

	$sPackageVersion = "1.6.5"
	$sPackageName = "vagrant.install-$sPackageVersion"	
	$sPackageUrl = "https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.5.msi"
	$sPackageHome = Join-Path $sPathToolsHome $sPackageName
	
	Run-ChocolateyProcess "msiexec" "/uninstall $sPackageUrl /quiet"

	$sPathVagrantBinary = Join-Path $sPackageHome $(Join-Path "bin" "vagrant.exe")
	Remove-BinFile "vagrant" $sPathVagrantBinary
}
catch {
  Write-ChocolateyFailure "vagrant.install" "$($_.Exception.Message)"
}