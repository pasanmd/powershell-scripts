$stream_reader = New-Object System.IO.StreamReader{C:\Users\DELL\Documents\user-list.txt}
$line_number = 1
while (($current_line =$stream_reader.ReadLine()))
{
    $SubjSigRt="CN=" + $current_line + "ROOT"
    $SubjSigClt="CN=" + $current_line + "CLIENT"
    #define the $cert variable with the usernamefor the cert
    $cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature -Subject $SubjSigRt -KeyExportPolicy Exportable -HashAlgorithm sha256 -KeyLength 2048 -CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign -KeyUsage CertSign
    Write-Host $cert
    #execute a new self signed cert
    $DnsNa= $current_line + "CLIENT"
    New-SelfSignedCertificate -Type Custom -DnsName $DnsNa -KeySpec Signature -Subject $SubjSigClt -KeyExportPolicy Exportable -HashAlgorithm sha256 -KeyLength 2048 -CertStoreLocation "Cert:\CurrentUser\My"  -Signer $cert -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2")

$line_number++
}