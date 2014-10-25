try {
	$sPathDevelopmentHome = Get-EnvironmentVariable -Name "PATH_HOME" -Scope "User" 
	$sPathToolsHome = Join-Path $sPathDevelopmentHome "tools"

	$sPackageVersion = "1.8.4"
	$sPackageName = "ant.portable-$sPackageVersion" 
	$sPackageHome = Join-Path $sPathToolsHome $sPackageName

	Remove-Folder $sPackageHome

	Remove-EnvironmentVariable "ANT_HOME"
	Remove-EnvironmentVariable "ANT_OPTS"
	
	$sPathAntBinary = Join-Path $sPackageHome $(Join-Path "bin" "ant.bat")
	Remove-BinFile "ant" $sPathAntBinary
}
catch {
  Write-ChocolateyFailure "ant.portable" "$($_.Exception.Message)"
}