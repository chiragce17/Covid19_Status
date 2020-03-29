clear
Clear-Content .\rawoutput.txt -ErrorAction Ignore

$url = "https://www.worldometers.info/coronavirus/"
$req = Invoke-WebRequest -Uri $url
$req.ParsedHtml.body.getElementsByTagName("table") | Select -ExpandProperty Textcontent | Out-File rawoutput.txt
$output = Get-Content .\Rawoutput.txt

$Windex = $output.IndexOf("World")
$sindex = $Windex + 12
$indiaindex = $output.IndexOf("India")
$count = 1
$outarray = @()

$outarray += "`nTotal Cases : " + $output[$windex+1]
$outarray += "`nNew Cases : " + $output[$windex+2]
$outarray += "`nTotal Deaths : " + $output[$windex+3]
$outarray += "`nNew Deaths : " + $output[$windex+4]
$outarray += "`nTotal Recovered : " + $output[$windex+5]

Write-Host "`nThis script is to retrieve COVID-19 status world wide from the below reference URL`n"
Write-Host "`nhttps://www.worldometers.info/coronavirus/ `n" -BackgroundColor darkred


Write-Host "`n************* Worldwide Corona virus Cases ********************`n"
Write-Host $outarray
Write-Host "`n***************************************************************`n"

$outarray = @()

$outarray += "`nTotal Cases : " + $output[$indiaindex+1]
$outarray += "`nNew Cases : " + $output[$indiaindex+2]
$outarray += "`nTotal Deaths : " + $output[$indiaindex+3]
$outarray += "`nNew Deaths : " + $output[$indiaindex+4]
$outarray += "`nTotal Recovered : " + $output[$indiaindex+5]

Write-Host "`n************* India Corona virus Cases ********************`n"
Write-Host $outarray
Write-Host "`n***************************************************************`n"



$outarray1 = @()


while($sindex -le $output.Length){

    $outarray1 += [PSCustomObject]@{"Country" = $output[$sindex]
                  "Total Cases" = $output[$sindex+1]
                  "New Cases" = $output[$sindex+2]
                  "Total Deaths" = $output[$sindex+3]
                  "New Deaths" = $output[$sindex+4] 
                  "Total Recovered" = $output[$sindex+5]
                }


     #$outarray  += $hashtable

     
     

      $sindex += 13
      $count++

      if($count -eq 30){Break}
}

Write-Host "************ Top 30 Countries *******************`n"
$outarray1 | ft -AutoSize