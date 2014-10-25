try {
	$sPathDevelopmentHome = Get-EnvironmentVariable -Name "PATH_HOME" -Scope "User" 
	$sPathToolsHome = Join-Path $sPathDevelopmentHome "tools"

	$sPackageVersion = "2.0.0"
	$sPackageName = "ruby.devkit.portable-$sPackageVersion"	
	$sPackageHome = Join-Path $sPathToolsHome $sPackageName
	
	# TODO - fix permissions issue
	#Remove-Folder $sPackageHome
	
	# can't easily uninstall the extensions to ruby
}
catch {
  Write-ChocolateyFailure "ruby.devkit.portable" "$($_.Exception.Message)"
}