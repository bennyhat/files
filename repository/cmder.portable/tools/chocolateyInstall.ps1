try {
	$sPathDevelopmentHome = Get-EnvironmentVariable -Name "PATH_HOME" -Scope "User" 
	$sPathToolsHome = Join-Path $sPathDevelopmentHome "tools"
	Write-Folder $sPathToolsHome

	$sPackageVersion = "1.1.4.100"
	$sPackageName = "cmder.portable-$sPackageVersion"	
	$sPackageUrl = "https://github.com/bliker/cmder/releases/download/v1.1.4.1/cmder.7z"
	$sPackageHome = Join-Path $sPathToolsHome $sPackageName
	
	Install-ChocolateyZipPackage "cmder.portable" $sPackageUrl $sPackageHome | Out-Null
	
	$sPathCmderBinary = Join-Path $sPackageHome "Cmder.exe"
	Generate-BinFile "cmder" $sPathCmderBinary
}
catch {
  Write-ChocolateyFailure "cmder.portable" "$($_.Exception.Message)"
  throw
}