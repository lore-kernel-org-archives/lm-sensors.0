From: Philip Edelbrock <phil_edelbrock@edgedesign.us>
Date: Tue, 17 Jul 2007 05:41:57 +0000
Subject: Re: [lm-sensors] Call for 2.10.4
Message-Id: <3CEBF08B-C24A-47C6-8672-E088EB42B9F5@edgedesign.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2267730465137201101=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070625101648.511dc9c4@hyperion.delvare>
In-Reply-To: <20070625101648.511dc9c4@hyperion.delvare>
To: lm-sensors@vger.kernel.org


--===============2267730465137201101==
Content-Type: multipart/signed; micalg=sha1; boundary=Apple-Mail-41-185287373;
	protocol="application/pkcs7-signature"


--Apple-Mail-41-185287373
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


On Jul 16, 2007, at 2:15 AM, Jean Delvare wrote:

> On Sun, 8 Jul 2007 23:07:27 +0200, Jean Delvare wrote:
>> On Mon, 25 Jun 2007 10:16:48 +0200, Jean Delvare wrote:
>>> We should start planning the release of lm-sensors 2.10.4. The  
>>> list of
>>> changes is getting long. We have Linux 2.4 support for the
>>> W83627EHF/EHG, support for extra W83627EHF/EHG/DHG features (VID and
>>> thermal sensor types), support for the dme1737 and applesmc  
>>> chips, an
>>> improved fancontrol script (needs testing!) and an updated
>>> sensors-detect.
>>>
>>> I propose the following schedule:
>>> * July 8th: SVN freeze
>>> * July 9th-15th: testing
>>> * July 16th: release
>>
>> We've seen many commits in the last week, in particular thanks to  
>> Hans
>> de Goede, so there will be a lot of good things in this 2.10.4  
>> release.
>> I've just committed the last patches I had pending myself, so I  
>> declare
>> the lm-sensors trunk frozen in SVN. I'll do as much testing as  
>> possible
>> next week, and I invite everyone else to do so as well.
>
> I am done with the testing. I've made some fixes to sensors-detect,  
> and
> minor documentation updates as well. Things look mostly OK to me now.
> Phil, you can proceed with the release as your time permits.
>
> Notes:
> * libsensors version needs to be set to 3.1.4.
> * No i2c release, only lm-sensors.
>
> Thanks,

OK, I've prepared and signed the release.  The files are in my home  
directory on devel.atrpms.net.  Normally I'd move the files into the  
proper place in /srv/lm-sensors.org and edit the wiki to link to  
them, but that directory doesn't seem to be mounted for me.


Phil


--Apple-Mail-41-185287373
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
hvcNAQkFMQ8XDTA3MDcxNzA1NDE1N1owIwYJKoZIhvcNAQkEMRYEFBn11RFkizDckbckoVo3NXnP
T51FMIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQQIQHdPYs45LFBMAsAXFnwoXpjCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3
dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQHdPYs45LFBMAsAXFnwoXpjANBgkqhkiG
9w0BAQEFAASCAQCiGzb8iWLt0bEtLS8BUjm98CG+2atotAAyBuh95diIHwrKcibhKMyRC/vsVDvn
oRIOn23ugQk9rOr1Wc2jeaSbKdYh34D7GdyK8Plz9PKwSYIHmeIdD0wL1cqQsc1wx6ynG4xcPi5j
4GIKczehq8vucvNVIGBRyhEQz2JWK6ka6lnJPINC8U4Kn0rF0NR7bkn2OlqJCmbEVFb2bLbwEFpa
bAP7QMwl1UgOhuzcU9mn8uAYCpZfJCwB/RJhqw6i/4Qb5CMRTj/nU9EwOUWxvHtzepjDk+Nqk2S/
1H9LILDdsOaCzBpDyi/WxRpvU66arrnuvywRPRfZMVC+LG9SE0oiAAAAAAAA

--Apple-Mail-41-185287373--


--===============2267730465137201101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2267730465137201101==--
