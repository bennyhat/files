try {
	$sPathDevelopmentHome = Get-EnvironmentVariable -Name "PATH_HOME" -Scope "User" 
	$sPathToolsHome = Join-Path $sPathDevelopmentHome "tools"
	
	$sPackageVersion = "2.0.0"
	$sPackageName = "ruby.install-$sPackageVersion"	
	$sPackageHome = Join-Path $sPathToolsHome $sPackageName
	
	$sPackageUninstaller = Join-Path $sPackageHome "unins000.exe"
	$sSilentArguments = "/verysilent"
	Uninstall-ChocolateyPackage 'ruby' 'exe' "$sSilentArguments" "$sPackageUninstaller"
	
	Remove-Folder $sPackageHome
	
	$sPathRubyBinHome = Join-Path $sPackageHome "bin"
	Uninstall-ChocolateyPath $sPathRubyBinHome
}
catch {
  Write-ChocolateyFailure "ruby.install" "$($_.Exception.Message)"
}
