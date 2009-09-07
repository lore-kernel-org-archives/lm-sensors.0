From: Adrian Sevcenco <Adrian.Sevcenco@cern.ch>
Date: Mon, 07 Sep 2009 18:56:55 +0000
Subject: [lm-sensors] Supermicro X7DWN+ info
Message-Id: <4AA55777.6050806@cern.ch>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4045818764965394863=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============4045818764965394863==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms080001000708060307010905"

--------------ms080001000708060307010905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi!
I would need some advice about creating the sensors3.conf for Supermicro 
  X7DWN+ motherboard ..

what chip should i use? in my centos 5.3 i have driver only up to w83792d

also is not very clear to me what do i do with the offsets of various 
data (in sensors example the line with offsets is only a comment ... )

i have the following info from vendor :
(it seems that the info is common for X7DW3, X7DWN, X7DWA, X7DBI, X7DBU, 
X7DBN)

Bus Type = SMBus
One W83793G

Windbond W83793G, Slave Address=0x2f (0x5E in 8-Bit format)
=============================================================
Fan1 Fan Speed, Offset 0x23, 0x24		RPM = 1350000/Data
Fan2 Fan Speed, Offset 0x25, 0x26		RPM = 1350000/Data
Fan3 Fan Speed, Offset 0x27, 0x28		RPM = 1350000/Data
Fan4 Fan Speed, Offset 0x29, 0x2a		RPM = 1350000/Data
Fan5 Fan Speed, Offset 0x2b, 0x2c		RPM = 1350000/Data
Fan6 Fan Speed, Offset 0x2d, 0x2e		RPM = 1350000/Data
Fan7/CPU1 Fan Speed, Offset 0x2f, 0x30		RPM = 1350000/Data
Fan8/CPU2 Fan Speed, Offset 0x31, 0x32		RPM = 1350000/Data
CPU1 Core Voltage, Offset 0x10			Voltage = Data* 0.008		
CPU2 Core Voltage, Offset 0x11			Voltage = Data* 0.008

-12V Voltage, Offset 0x14	Voltage =
((Data*0.016) - (2.048*(232./260.)))/(1-(232./260.))

+1.5V Voltage, Offset 0x15			Voltage = Data* 0.016
+3.3V Voltage, Offset 0x16			Voltage = Data* 0.016
+12V Voltage, Offset 0x17           Voltage = Data* 0.008/ (10./120.)
+5V Voltage, Offset 0x18			Voltage = Data* 0.024
5Vsb Voltage, Offset 0x19			Voltage = Data* 0.024
Battery Voltage, Offset 0x1a			Voltage = Data* 0.016

CPU1 CoreA (PECI Agent1) Temperature, Offset 0x1c	Temperature = Data

CPU1 CoreB (PECI Agent2) Temperature, Offset 0x1d	Temperature = Data

CPU2 CoreA (PECI Agent3) Temperature, Offset 0x1e	Temperature = Data

CPU2 CoreB (PECI Agent4) Temperature, Offset 0x1f	Temperature = Data

System Temperature, Offset 0x20			Temperature = Data
Chassis Intrusion, Offset 0x44, BitMask 0x40	1 = Bad, 0 = Good


Windbond W83627HF
=============================================================
Power Supply Failure, GP11(From W83627HF)	1 = Good, 0 = Bad


Thank you,
Adrian

--------------ms080001000708060307010905
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIIzDCC
BGIwggNKoAMCAQICAgDxMA0GCSqGSIb3DQEBBQUAMH0xEjAQBgoJkiaJk/IsZAEZEwJSTzEc
MBoGCgmSJomT8ixkARkTDFJvbWFuaWFuR1JJRDENMAsGA1UEChMEUk9TQTEgMB4GA1UECxMX
Q2VydGlmaWNhdGlvbiBBdXRob3JpdHkxGDAWBgNVBAMTD1JvbWFuaWFuR1JJRCBDQTAeFw0w
OTA3MzEwODM5NDVaFw0xMDA3MzEwODM5NDVaMFoxEjAQBgoJkiaJk/IsZAEZFgJSTzEcMBoG
CgmSJomT8ixkARkWDFJvbWFuaWFuR1JJRDEMMAoGA1UEChMDSVNTMRgwFgYDVQQDEw9BZHJp
YW4gU0VWQ0VOQ08wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBANGdBpzVLlWQZOVPUrWr
Z70ZZi7bJqPzcuvR4dp55DarOStxTkQv/ER8+tweHgEPDO3xQ2m7R4L9ct7WhQMB4AmFnOk0
Nz6mJ4a6ad1zHUaU90nGbfqPej4qPPvFMS+X8xmLDxtQsL5GPCOgJ+j8tRf+GMEO228KL0lv
ZdSZiow5AgMBAAGjggGRMIIBjTAMBgNVHRMBAf8EAjAAMBEGCWCGSAGG+EIBAQQEAwIFoDAO
BgNVHQ8BAf8EBAMCBLAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB8GA1UdIwQY
MBaAFH8QzVxurMprEgvgqYeIEZW8MBdoMGMGA1UdIARcMFowWAYOKwYBBAGB018JAQIBAQQw
RjBEBggrBgEFBQcCARY4aHR0cDovL3d3dy5yb21hbmlhbmdyaWQucm8vZG9jcy9Sb21hbmlh
bkdSSURfQ0FfdjEuNC5wZGYwOgYDVR0fBDMwMTAvoC2gK4YpaHR0cDovL3d3dy5yb21hbmlh
bmdyaWQucm8vY3JsL2NybC12Mi5kZXIwHQYDVR0OBBYEFN2alXZhqrnpqODFM2Jck5MepMlF
MDYGA1UdEgQvMC2BD2dyaWQtY2FAcm9zYS5yb4YaaHR0cDovL3d3dy5yb21hbmlhbmdyaWQu
cm8wIgYDVR0RBBswGYEXYWRyaWFuLnNldmNlbmNvQGNlcm4uY2gwDQYJKoZIhvcNAQEFBQAD
ggEBAJp4O2eh3AG0k8JQFWPFx1pGxDcwHEqtXh3wAU1Vggyx5WI+ulouJXxqDE8m5Qr53fcr
TXTi4arf8cNqFGIRSvBzfq+l6tnfYxiWtEAEk/ejVQgLgtKnpVFmNiTRKPGQzIgzvXRjSE0i
g1O2gXd3+z1TSr+OCZe45Zv7YM4AhlD3oN8OdqnJRnuqnYKQ1aMsgwyEgCZ1PeEZGuH0n/kO
otVnYg6xx7tLW7YOd3ECyzryjEQ5tu3HOj4//1wLiYyp+Z6W4sWoQiY7Fzr4riCed7wxSYte
GIIUI2mqXd0Cq9+oL3T0tRd51PHay3WGH3N5gIImNtai+g6itai0a1KAXZAwggRiMIIDSqAD
AgECAgIA8TANBgkqhkiG9w0BAQUFADB9MRIwEAYKCZImiZPyLGQBGRMCUk8xHDAaBgoJkiaJ
k/IsZAEZEwxSb21hbmlhbkdSSUQxDTALBgNVBAoTBFJPU0ExIDAeBgNVBAsTF0NlcnRpZmlj
YXRpb24gQXV0aG9yaXR5MRgwFgYDVQQDEw9Sb21hbmlhbkdSSUQgQ0EwHhcNMDkwNzMxMDgz
OTQ1WhcNMTAwNzMxMDgzOTQ1WjBaMRIwEAYKCZImiZPyLGQBGRYCUk8xHDAaBgoJkiaJk/Is
ZAEZFgxSb21hbmlhbkdSSUQxDDAKBgNVBAoTA0lTUzEYMBYGA1UEAxMPQWRyaWFuIFNFVkNF
TkNPMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDRnQac1S5VkGTlT1K1q2e9GWYu2yaj
83Lr0eHaeeQ2qzkrcU5EL/xEfPrcHh4BDwzt8UNpu0eC/XLe1oUDAeAJhZzpNDc+pieGumnd
cx1GlPdJxm36j3o+Kjz7xTEvl/MZiw8bULC+RjwjoCfo/LUX/hjBDttvCi9Jb2XUmYqMOQID
AQABo4IBkTCCAY0wDAYDVR0TAQH/BAIwADARBglghkgBhvhCAQEEBAMCBaAwDgYDVR0PAQH/
BAQDAgSwMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDAfBgNVHSMEGDAWgBR/EM1c
bqzKaxIL4KmHiBGVvDAXaDBjBgNVHSAEXDBaMFgGDisGAQQBgdNfCQECAQEEMEYwRAYIKwYB
BQUHAgEWOGh0dHA6Ly93d3cucm9tYW5pYW5ncmlkLnJvL2RvY3MvUm9tYW5pYW5HUklEX0NB
X3YxLjQucGRmMDoGA1UdHwQzMDEwL6AtoCuGKWh0dHA6Ly93d3cucm9tYW5pYW5ncmlkLnJv
L2NybC9jcmwtdjIuZGVyMB0GA1UdDgQWBBTdmpV2Yaq56ajgxTNiXJOTHqTJRTA2BgNVHRIE
LzAtgQ9ncmlkLWNhQHJvc2Eucm+GGmh0dHA6Ly93d3cucm9tYW5pYW5ncmlkLnJvMCIGA1Ud
EQQbMBmBF2Fkcmlhbi5zZXZjZW5jb0BjZXJuLmNoMA0GCSqGSIb3DQEBBQUAA4IBAQCaeDtn
odwBtJPCUBVjxcdaRsQ3MBxKrV4d8AFNVYIMseViPrpaLiV8agxPJuUK+d33K0104uGq3/HD
ahRiEUrwc36vperZ32MYlrRABJP3o1UIC4LSp6VRZjYk0SjxkMyIM710Y0hNIoNTtoF3d/s9
U0q/jgmXuOWb+2DOAIZQ96DfDnapyUZ7qp2CkNWjLIMMhIAmdT3hGRrh9J/5DqLVZ2IOsce7
S1u2DndxAss68oxEObbtxzo+P/9cC4mMqfmeluLFqEImOxc6+K4gnne8MUmLXhiCFCNpql3d
AqvfqC909LUXedTx2st1hh9zeYCCJjbWovoOorWotGtSgF2QMYIDHDCCAxgCAQEwgYMwfTES
MBAGCgmSJomT8ixkARkTAlJPMRwwGgYKCZImiZPyLGQBGRMMUm9tYW5pYW5HUklEMQ0wCwYD
VQQKEwRST1NBMSAwHgYDVQQLExdDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEYMBYGA1UEAxMP
Um9tYW5pYW5HUklEIENBAgIA8TAJBgUrDgMCGgUAoIIB7jAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wOTA5MDcxODU2NTVaMCMGCSqGSIb3DQEJBDEWBBSB
Vpn8pTtm4HPnf1sNSlUQCCVb7jBfBgkqhkiG9w0BCQ8xUjBQMAsGCWCGSAFlAwQBAjAKBggq
hkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZI
hvcNAwICASgwgZQGCSsGAQQBgjcQBDGBhjCBgzB9MRIwEAYKCZImiZPyLGQBGRMCUk8xHDAa
BgoJkiaJk/IsZAEZEwxSb21hbmlhbkdSSUQxDTALBgNVBAoTBFJPU0ExIDAeBgNVBAsTF0Nl
cnRpZmljYXRpb24gQXV0aG9yaXR5MRgwFgYDVQQDEw9Sb21hbmlhbkdSSUQgQ0ECAgDxMIGW
BgsqhkiG9w0BCRACCzGBhqCBgzB9MRIwEAYKCZImiZPyLGQBGRMCUk8xHDAaBgoJkiaJk/Is
ZAEZEwxSb21hbmlhbkdSSUQxDTALBgNVBAoTBFJPU0ExIDAeBgNVBAsTF0NlcnRpZmljYXRp
b24gQXV0aG9yaXR5MRgwFgYDVQQDEw9Sb21hbmlhbkdSSUQgQ0ECAgDxMA0GCSqGSIb3DQEB
AQUABIGAh+iQKgUkherG9l84HXs38TWK3TQuLoS9btDk2Bw0z6zDscJQNgdP5y3CrHqeKA6e
rkLadJsjdcbR/kibshdwbluvu8n9qGyXYR00ynzAnVwsQCOisZpY6ZRsLFcNDZDcVp/7VHPb
lzYXkYklrxboRPNHrH+pqvxpVk8Ed+nzEPUAAAAAAAA=
--------------ms080001000708060307010905--


--===============4045818764965394863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4045818764965394863==--
