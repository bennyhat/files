try {
	$sPathDevelopmentHome = Get-EnvironmentVariable -Name "PATH_HOME" -Scope "User" 
	$sPathToolsHome = Join-Path $sPathDevelopmentHome "tools"

	$sPackageVersion = "1.1.4.100"
	$sPackageName = "cmder.portable-$sPackageVersion"	
	$sPackageHome = Join-Path $sPathToolsHome $sPackageName
	
	Remove-Folder $sPackageHome

	$sPathCmderBinary = Join-Path $sPackageHome "Cmder.exe"
	Remove-BinFile "cmder" $sPathCmderBinary
}
catch {
  Write-ChocolateyFailure "cmder.portable" "$($_.Exception.Message)"
}