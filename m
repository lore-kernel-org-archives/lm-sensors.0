From: Philip Edelbrock <phil_edelbrock@edgedesign.us>
Date: Thu, 19 Jul 2007 23:51:22 +0000
Subject: Re: [lm-sensors] Call for 2.10.4
Message-Id: <6CE73EEB-DA69-452B-A89F-367295107939@edgedesign.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1812159335792583214=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070625101648.511dc9c4@hyperion.delvare>
In-Reply-To: <20070625101648.511dc9c4@hyperion.delvare>
To: lm-sensors@vger.kernel.org


--===============1812159335792583214==
Content-Type: multipart/signed; micalg=sha1; boundary=Apple-Mail-39-423452223;
	protocol="application/pkcs7-signature"


--Apple-Mail-39-423452223
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


On Jul 19, 2007, at 9:25 AM, Jean Delvare wrote:

> On Wed, 18 Jul 2007 16:26:55 +0200, Axel Thimm wrote:
>> the new devel server was just missing symlinks which I now added  
>> in. I
>> haven't tested if everything works under devel as it did under
>> devel-old (actually I also let the date for introducing the new devel
>> server slip, as we just had our son get born :).
>
> Wow! All my wishes of happiness :)
>

Ditto!

>> If something is
>> broken/missing on devel please ping me in PM and use devel-old
>> instead. Once you're happy on devel (new) we can decomission
>> devel-old, but there is no hurry.
>
> OK, I've completed the release by copying the files from Phil's home
> to /srv/lm-sensors/dl, and updating the wiki. Only thing missing  
> now is
> the download mirror, which doesn't yet have the new files. Phil,  
> can you
> please copy them there?

Thanks for finishing the release.  I've put copies on the mirror, too.


Phil


--Apple-Mail-39-423452223
Content-Transfer-Encoding: base64
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Disposition: attachment;
	filename=smime.p7s

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGOTCCAvIw
ggJboAMCAQICEB3T2LOOSxQTALAFxZ8KF6YwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA2MTExNDIwNTc0NVoXDTA3MTExNDIwNTc0
NVowTjEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjErMCkGCSqGSIb3DQEJARYccGhp
bF9lZGVsYnJvY2tAZWRnZWRlc2lnbi51czCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
ANriZ0rz4fljJCvNkkyHqnr8OD4xSy8SfcYXMKNWkEuhcvdToRoEcw8OUBslSMFJWuIHigK4M0Or
0uqyujMZg7oq7ZuPNNFmktc1TVv+9IuJpXbIRRsE+cvlVqLxUKNTClik6e5jMU7UAkZnccHL0mhr
Z2+7PDPPP2WR0NpubMepWQOUx2rFD4+Ay3TGq4ix7fMn3zs6Uahn7oVcdwfswGTfZn0k+Bfcckor
iGoarY1xClBj22M6H06PFETkbtja20TR7dY+HvV468irtprGG1vJrPg9cwZzu3Y71rwhVWKkv83g
rBiKa5V5rjlgE3Y0RD7mH8muxjsmNnKOzVqIBJsCAwEAAaM5MDcwJwYDVR0RBCAwHoEccGhpbF9l
ZGVsYnJvY2tAZWRnZWRlc2lnbi51czAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBABPl
xWFL+hyDucFHLG+V0BV9TPKQ9H4K6mJawxVmFZSDiUICEUMhXGiR896Hyt8kPyIZ6y0PDLltrRPN
o7TqHsOI9Ez9XdpoGRTYiXv38N2M/veunzQrAtWXsKlSOsyXweSluROeSXLOxmZ1yCA7n+rlNcPJ
pLdUenggfFNltJD8MIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMC
WkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFU
aGF3dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lv
bjEkMCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxw
ZXJzb25hbC1mcmVlbWFpbEB0aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1
OVowYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4x
LDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3
DQEBAQUAA4GNADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9R
zgHU5VAKMNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CA
AmTXp6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYB
Af8CAQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBlcnNv
bmFsRnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQ
cml2YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2asZw9/r6y+wheh
Q5aUnX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSeJVCUYsfbJ3FXJY3d
qZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/XV9lTzGCAxAwggMM
AgEBMHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0
ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhAd09izjksU
EwCwBcWfChemMAkGBSsOAwIaBQCgggFvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTA3MDcxOTIzNTEyMlowIwYJKoZIhvcNAQkEMRYEFHkeOuJWgIzBKHrA9myrTpfr
xsu6MIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQQIQHdPYs45LFBMAsAXFnwoXpjCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3
dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQHdPYs45LFBMAsAXFnwoXpjANBgkqhkiG
9w0BAQEFAASCAQB8liYza0ggYd4rdZBCQSG5tsvyom41TAvaCUtO+VYaAeRtmGt9m0RGJcy6LdGE
DjVkCKJ4sV3vNDTGL21dc96D8jnRcPEyG5EgZaa7BGmLJdfcvXAxrXb/VBkLXaWsifF8YzWROB1c
k4FvdTqz/z9SbAifna0wjHX3wULe/mpOrkNWY7G/b5/PMcddFe3ywkux+StDu1XAhgPSnEmrj9BJ
RuEXYX0/8LttJuRXJReEdpQFKjl+yRSd50rNgE03qs+IMHsaZD4uFzieKjpGu4DdUUN8X6KRpy8Y
S+Sn47/FTycCBeNOQHKQefTx0wCDO3XraVYbjvD1OLaRjOVYIjCEAAAAAAAA

--Apple-Mail-39-423452223--


--===============1812159335792583214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1812159335792583214==--
