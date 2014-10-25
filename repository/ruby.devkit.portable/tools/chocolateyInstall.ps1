try {
	$sPathDevelopmentHome = Get-EnvironmentVariable -Name "PATH_HOME" -Scope "User" 
	$sPathToolsHome = Join-Path $sPathDevelopmentHome "tools"
	Write-Folder $sPathToolsHome

	$sPackageVersion = "2.0.0"
	$sPackageName = "ruby.devkit.portable-$sPackageVersion"	
	$sPackageUrl = "http://cdn.rubyinstaller.org/archives/devkits/DevKit-mingw64-32-4.7.2-20130224-1151-sfx.exe"
	$sPackageHome = Join-Path $sPathToolsHome $sPackageName
	
	Install-ChocolateyZipPackage "ruby.devkit.portable" $sPackageUrl $sPackageHome | Out-Null 
	
	$sRubyBinary = Get-Command ruby | Select-Object -ExpandProperty Definition	
	cd $sPackageHome
	Run-ChocolateyProcess $sRubyBinary "dk.rb init"
	Run-ChocolateyProcess $sRubyBinary "dk.rb install --force"
}
catch {
  Write-ChocolateyFailure "ruby.devkit.portable" "$($_.Exception.Message)"
  throw
}