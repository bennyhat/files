try {
	$sPackageUrl = "http://downloads.atlassian.com/software/sourcetree/windows/SourceTreeSetup_1.6.5.exe"
	
	$sSilentArguments = "/exenoui /passive"
	Install-ChocolateyPackage 'sourcetree.install' 'exe' "$sSilentArguments" "$sPackageUrl"
}
catch {
  Write-ChocolateyFailure "sourcetree.install" "$($_.Exception.Message)"
  throw
}