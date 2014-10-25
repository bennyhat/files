try {
	$sPathDevelopmentHome = Get-EnvironmentVariable -Name "PATH_HOME" -Scope "User" 
	$sPathToolsHome = Join-Path $sPathDevelopmentHome "tools"
	Write-Folder $sPathToolsHome

	$sPackageVersion = "2.0.0"
	$sPackageName = "ruby.install-$sPackageVersion"	
	$sPackageUrl = "http://dl.bintray.com/oneclick/rubyinstaller/rubyinstaller-2.0.0-p481.exe?direct"
	$sPackageHome = Join-Path $sPathToolsHome $sPackageName
	
	$sSilentArguments = "/verysilent /dir=`"$sPackageHome`" /tasks=`"assocfiles,modpath`""
	Install-ChocolateyPackage 'ruby' 'exe' "$sSilentArguments" "$sPackageUrl"
	
	$sPathRubyBinHome = Join-Path $sPackageHome "bin"
	Install-ChocolateyPath $sPathRubyBinHome
}
catch {
  Write-ChocolateyFailure "ruby.install" "$($_.Exception.Message)"
  throw
}
