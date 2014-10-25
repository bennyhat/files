try {
	$sPathDevelopmentHome = Get-EnvironmentVariable -Name "PATH_HOME" -Scope "User" 
	$sPathToolsHome = Join-Path $sPathDevelopmentHome "tools"
	Write-Folder $sPathToolsHome

	$sPackageVersion = "1.8.4"
	$sPackageName = "ant.portable-$sPackageVersion"	
	$sPackageUrl = "http://archive.apache.org/dist/ant/binaries/apache-ant-1.8.4-bin.zip"
	$sPackageHome = Join-Path $sPathToolsHome $sPackageName
	
	Install-ChocolateyZipPackage "ant.portable" $sPackageUrl $sPathToolsHome | Out-Null 
	
	$sPathUnzipped = Join-Path $sPathToolsHome "apache-ant-1.8.4"
	Rename-Item $sPathUnzipped $sPackageHome

	Install-ChocolateyEnvironmentVariable "ANT_HOME" $sPackageHome
	Install-ChocolateyEnvironmentVariable "ANT_OPTS" "-Xmx256M"

	$sPathAntBinary = Join-Path $sPackageHome $(Join-Path "bin" "ant.bat")
	Generate-BinFile "ant" $sPathAntBinary
}
catch {
  Write-ChocolateyFailure "ant.portable" "$($_.Exception.Message)"
  throw
}