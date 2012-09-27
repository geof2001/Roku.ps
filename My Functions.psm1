function DisplayMenu {
  param([string[]]$arr)
    write-host 'write:' $arr[0]
  foreach ($i in $arr)
    {
      $z = $i + 1
      write-host $arr[$z]
    }
}


#Return array from Single Directory

Function DirArray {
  param([string]$a)
  $d = @()
  foreach ($b in gci $a) {
  $d +=$b.fullname }
  return ,$d
}

#Return array from Multiple Directories

Function MultiDirArray {
  param([string[]]$mda)
    write-host 'write:' $mda[0]
  foreach ($i in $mda)
    { 
      $z = $i +1
      write-host $mda[$z]
    }
}


#Install file Launcher

Function Launcher {
  param([string]$installer)

  if ($installer.substring($installer.length-3) -eq "msi") {
    write-host "Installing MSI $installer." 
    Start-Process -FilePath msiexec -ArgumentList /i, $installer, /quiet -Wait
  }

  elseif ($installer.substring($installer.length-3) -eq "exe") {
    write-host "Installing EXE $installer please complete the interactive install."
    Start-Process $installer -Wait
  }

  else {
    write-host "This file $installer is not a msi or exe.  Please check the location or run manually."
  }

}


#API Cert Install

Function InstallCert
{ $install = "c:\install"
  $certfolder = $install + "\certificates"
  $pfxtool = $install + "\tools\importpfx.exe"
  $cstores = gci $certfolder
  ForEach ( $store in $cstores )
	{ $cert = gci (join-path $certfolder (join-path \ $store))
	  cls
	  write-host Installing $cert from $certfolder\$store in $store
	  [System.Security.SecureString]$securePass = Read-Host "Please supply the password for Certificate $cert" -AsSecureString; 
	  [String]$pass = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePass)); 
	  $args = "-f $certfolder\$store\$cert -p $pass -t MACHINE -s $store"
	  start-process $pfxtool $args -wait
	}
  #CLEAN
  $cstores = @()
}


