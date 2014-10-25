function Run-Process {
param(
  [string] $file,
  [string] $arguments = $args,
  [string] $workingDirectory = $(Get-Location),
  [switch] $elevated
)
  Write-Host "running command $file $arguments in $workingDirectory"
  $psi = new-object System.Diagnostics.ProcessStartInfo $file;
  $psi.Arguments = $arguments;
  $psi.UseShellExecute = $false;
  $psi.CreateNoWindow = false;
  $psi.WorkingDirectory = $workingDirectory;

  $s = [System.Diagnostics.Process]::Start($psi);
  $s.WaitForExit();
  if ($s.ExitCode -ne 0) {
    throw "[ERROR] Running $file with $arguments was not successful."
  }
}

# load in the package configuration template file
$xPackageConfigXmlDocument = [xml] (Get-Content "packages.config.template")
[System.Xml.XmlElement] $xPackageConfigXml = $xPackageConfigXmlDocument.get_DocumentElement()

# look for nuspec files one directory deep
Get-ChildItem "*\*.nuspec" | ForEach-Object {
    # to make things clearer
	$fPackage = $_

    # skip if it's the chocolatey template package
	if ($fPackage.Name -eq "__NAME__.nuspec") { return }

	# get chocolatey path and pack with chocolatey
	$sChocolateyBinary = Get-Command "chocolatey" | Select-Object -ExpandProperty Definition
	Run-Process $sChocolateyBinary "pack $($fPackage.FullName)" $(Split-Path -parent $fPackage.FullName)
	
	# get id, version, and parent directory
	$nsDefault = @{dns = 'http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd'} # seriously...MS requires a namespace, even if it's the default
	$sPackageId = (Select-Xml -xpath "/dns:package/dns:metadata/dns:id" -namespace $nsDefault -path $fPackage.FullName | Select-Object -ExpandProperty Node).InnerText
	$sPackageVersion = (Select-Xml -xpath "/dns:package/dns:metadata/dns:version" -namespace $nsDefault -path $fPackage.FullName | Select-Object -ExpandProperty Node).InnerText
	$sPackageSource = Split-Path -leaf (Split-Path -parent $fPackage.FullName) # only taking the parent directory, as this isn't a deep traverse
	
	# write into the configuration template file
	$xePackage = $xPackageConfigXmlDocument.CreateElement("package")
	$xaPackageId = $xPackageConfigXmlDocument.CreateAttribute("id")
	$xaPackageVersion = $xPackageConfigXmlDocument.CreateAttribute("version")
	$xaPackageSource = $xPackageConfigXmlDocument.CreateAttribute("source")
    $xaPackageId.Value = $sPackageId
	$xaPackageVersion.Value = $sPackageVersion
	$xaPackageSource.Value = $sPackageSource
	
    $xePackage.SetAttributeNode($xaPackageId) | Out-Null
	$xePackage.SetAttributeNode($xaPackageVersion) | Out-Null
	$xePackage.SetAttributeNode($xaPackageSource) | Out-Null
	
	$xPackageConfigXml.AppendChild($xePackage) | Out-Null	
}
$sOutputFile = Join-Path $(Get-Location) "packages.config"
$xPackageConfigXmlDocument.Save($sOutputFile)
