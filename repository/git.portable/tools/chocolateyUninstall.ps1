try {
	$sPathDevelopmentHome = Get-EnvironmentVariable -Name "PATH_HOME" -Scope "User" 
	$sPathToolsHome = Join-Path $sPathDevelopmentHome "tools"

	$sPackageVersion = "1.9.4"
	$sPackageName = "git.portable-$sPackageVersion"	
	$sPackageHome = Join-Path $sPathToolsHome $sPackageName
	
	Remove-Folder $sPackageHome
	
	$sPathGitBinHome = Join-Path $sPackageHome "bin"
	Uninstall-ChocolateyPath $sPathGitBinHome
	
	$sPathGitBinary = Join-Path $sPathGitBinHome "git.exe"
	Remove-BinFile "git" $sPathGitBinary
}
catch {
  Write-ChocolateyFailure "git.portable" "$($_.Exception.Message)"
  throw
}
