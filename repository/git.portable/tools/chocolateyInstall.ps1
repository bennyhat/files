try {
	$sPathDevelopmentHome = Get-EnvironmentVariable -Name "PATH_HOME" -Scope "User" 
	$sPathToolsHome = Join-Path $sPathDevelopmentHome "tools"
	Write-Folder $sPathToolsHome

	$sPackageVersion = "1.9.4"
	$sPackageName = "git.portable-$sPackageVersion"	
	$sPackageUrl = "https://github.com/msysgit/msysgit/releases/download/Git-1.9.4-preview20140929/PortableGit-1.9.4-preview20140929.7z"
	$sPackageHome = Join-Path $sPathToolsHome $sPackageName
	
	Install-ChocolateyZipPackage "git.portable" $sPackageUrl $sPackageHome | Out-Null
	
	$sPathGitBinHome = Join-Path $sPackageHome "bin"
	Install-ChocolateyPath $sPathGitBinHome
	
	$sPathGitBinary = Join-Path $sPathGitBinHome "git.exe"
	Generate-BinFile "git" $sPathGitBinary
}
catch {
  Write-ChocolateyFailure "git.portable" "$($_.Exception.Message)"
  throw
}
