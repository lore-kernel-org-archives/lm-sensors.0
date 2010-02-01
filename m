From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Date: Mon, 01 Feb 2010 14:08:25 +0000
Subject: Re: [lm-sensors] API extensions (for IIO,
Message-Id: <4B66E059.9000501@iis.fraunhofer.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6863025586513226058=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4B65CC6C.7070605@cam.ac.uk>
In-Reply-To: <4B65CC6C.7070605@cam.ac.uk>
To: lm-sensors@vger.kernel.org

This is a cryptographically signed message in MIME format.

--===============6863025586513226058==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms010706020904060700050703"

This is a cryptographically signed message in MIME format.

--------------ms010706020904060700050703
Content-Type: multipart/mixed;
 boundary="------------060401050509030903030401"

This is a multi-part message in MIME format.
--------------060401050509030903030401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Jean,

Am 01.02.2010 14:52, schrieb Jean Delvare:
> Hi Jonathan,
>
> On Sun, 31 Jan 2010 18:31:08 +0000, Jonathan Cameron wrote:
>> We recently proposed an API specification for parts of the Industrial =
I/O
>> subsystem in a thread on LKML.  Greg KH pointed out that a we ought to=
, where
>> sensible keep as close as possible to API's of existing subsystems.  T=
o that
>> end we are working on an updated version of the original document.
>> (original at http://lkml.org/lkml/2010/1/20/195, please note it has ch=
anged
>> a lot in response to comments made in that thread!)
>
> I've read Greg's comment. I'm not quite sure I agree... IIO serves a
> purpose which is clearly different from hwmon. The use cases are
> different. Otherwise everyone would use hwmon and IIO wouldn't have to
> support voltage and temperature inputs at all. So I don't think it
> makes too much sense to make the new IIO API look like the hwmon one.
> Learning from our mistakes, yes, certainly. But let's not get too far
> into copying, otherwise we might lose the focus on the specific IIO
> needs.

You're absolutly right here. IIO has to support more hardware features=20
of these devices than hwmon does. But IIO knows about the type of=20
sensor, so it shouldn't be too hard to add an option to IIO to export=20
voltage and temperature devices into hwmon. The same could be done with=20
accelerometers for input.

--=20
Dipl.-Inf. Manuel Stahl
Fraunhofer-Institut f=FCr Integrierte Schaltungen IIS
- Leistungsoptimierte Systeme -
Nordostpark 93                Telefon  +49 (0)911/58061-6419
90411 N=FCrnberg                Fax      +49 (0)911/58061-6398
http://www.iis.fraunhofer.de  manuel.stahl@iis.fraunhofer.de

--------------060401050509030903030401
Content-Type: text/x-vcard; charset=utf-8;
 name="manuel_stahl.vcf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="manuel_stahl.vcf"

begin:vcard
fn:Manuel Stahl
n:Stahl;Manuel
email;internet:manuel.stahl@iis.fraunhofer.de
tel;work:+49 911 58061-6419
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------060401050509030903030401--

--------------ms010706020904060700050703
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIUWDCC
BC4wggMWoAMCAQICAgEMMA0GCSqGSIb3DQEBBQUAMHExCzAJBgNVBAYTAkRFMRwwGgYDVQQK
ExNEZXV0c2NoZSBUZWxla29tIEFHMR8wHQYDVQQLExZULVRlbGVTZWMgVHJ1c3QgQ2VudGVy
MSMwIQYDVQQDExpEZXV0c2NoZSBUZWxla29tIFJvb3QgQ0EgMjAeFw0wNzEyMDUxNTE4NTha
Fw0xOTA2MzAyMzU5NTlaMGcxCzAJBgNVBAYTAkRFMRMwEQYDVQQKEwpGcmF1bmhvZmVyMSEw
HwYDVQQLExhGcmF1bmhvZmVyIENvcnBvcmF0ZSBQS0kxIDAeBgNVBAMTF0ZyYXVuaG9mZXIg
Um9vdCBDQSAyMDA3MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwz0eyWWNW4g3
9z7BIbZU3rA6VxsaHO6YCHQBWm+13zZXK0RFzvNGE2V2lZhUx6iFFW4SpBfoC+EhpzE9Kd3/
o9ZP0rSJ/WNK2qtT71kFtE/iOyqRmcDLZVeBozCTkA7Jvf0VMjIIpEh8VgXyuzaJ4kjCb0uS
DCVFvq0+1McB7bHIErQwCG6nb396IKe7tOU1gFQsGY/ZS8Adq0P4YRSU+7AdXbeR7GLAkdFe
3acLsy0fZjkYPK4EFOXSfTbZss2nE7DMRZ1WBFFxMzZcL11RE55PSJAOl1pLcNu5edmh1pTI
ktCl+2C/La2ecQAXhsD9SGadFEwFTkzRcUQL0HoPsQIDAQABo4HZMIHWMB8GA1UdIwQYMBaA
FDHDeRu69VPXF+CJei0XbAqzK50zMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUL0VCHjEF
gNVw2PgdV8tbetU9nPcwEgYDVR0TAQH/BAgwBgEB/wIBATBwBgNVHR8EaTBnMGWgY6Bhhl9o
dHRwOi8vcGtpLnRlbGVzZWMuZGUvY2dpLWJpbi9zZXJ2aWNlL2FmX0Rvd25sb2FkQVJMLmNy
bD8tY3JsX2Zvcm1hdD1YXzUwOSYtaXNzdWVyPURUX1JPT1RfQ0FfMjANBgkqhkiG9w0BAQUF
AAOCAQEAGrdMejzl3cJjst6GJU5FYkz08o9fXdfljc4O1/WU4YuTMTanmiPnZ+FSwVoY1pnh
gGQ4D0o1M11meijcOH83cs1SdW4Qjmx9jPcp63fCuRkF1Lc9YbroBRLUUGJT7yJUYvxNAcNe
1A2DdGlR1TyerNukK3xthJbTcU3P1S1xo5LEP1XPmz0jdwdX6cjOHZe2M/uRl2CWD/f23m8l
kBKrGUfVRCOuwZI1KL8qQ14P6gdd0kTQhYLjErxH6iyt+PBBUn02uiKfeqAy70u8+ToHtinG
fThfNVV+OPI/fLPuLW4heF+5E8/v3mWAyCX1Zi1USq3O2S4OMM+AM6eLGXLqQTCCBMYwggOu
oAMCAQICCmEdMxkAAAAAAAMwDQYJKoZIhvcNAQEFBQAwZzELMAkGA1UEBhMCREUxEzARBgNV
BAoTCkZyYXVuaG9mZXIxITAfBgNVBAsTGEZyYXVuaG9mZXIgQ29ycG9yYXRlIFBLSTEgMB4G
A1UEAxMXRnJhdW5ob2ZlciBSb290IENBIDIwMDcwHhcNMDcxMjEyMTQ0OTM1WhcNMTkwNjMw
MjM1OTU5WjBnMQswCQYDVQQGEwJERTETMBEGA1UEChMKRnJhdW5ob2ZlcjEhMB8GA1UECxMY
RnJhdW5ob2ZlciBDb3Jwb3JhdGUgUEtJMSAwHgYDVQQDExdGcmF1bmhvZmVyIFVzZXIgQ0Eg
MjAwNzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMJ0EFHLddGB8Ss1nVqCOq+S
rs0C/K7I+yB3Dv9oEhWQSadnfGgkX/oOJhplPkqeCQrTh08zEYprVaJLTaVPVhvjx3h5+KML
3lVGZIfajA89TolhLwk+ml29VbqV5nLhNrSwdZy157b6dCu5JffxvpO5wXCn95Z/TLyLdeux
gVHs/MnhczvmBbBRS+Ow9UoKn+PZvyYmUEdOHg8cA5PGFaRP9q88q734VnlI+W4+y7BoN5wt
uqVrqWbbpOQ2sHYo9riv3b+x5WdsMrVieKGApQ/dNvgB5vuuAchRnsANZHgpAiPCzP7/QFYY
qk2undcxEXwPgo72oifB3uQZ3xHOV/cCAwEAAaOCAXIwggFuMBIGA1UdEwEB/wQIMAYBAf8C
AQAwHQYDVR0OBBYEFE8dr4jKbbiqHAn5xdER7Vm0k/oLMA4GA1UdDwEB/wQEAwIBBjAfBgNV
HSMEGDAWgBQvRUIeMQWA1XDY+B1Xy1t61T2c9zB1BgNVHR8EbjBsMGqgaKBmhjFodHRwOi8v
Y3JsLnBraS5mcmF1bmhvZmVyLmRlL2ZoZy1yb290LWNhLTIwMDcuY3JshjFodHRwOi8vY3Js
LmZyYXVuaG9mZXItcGtpLmRlL2ZoZy1yb290LWNhLTIwMDcuY3JsMIGQBggrBgEFBQcBAQSB
gzCBgDA+BggrBgEFBQcwAoYyaHR0cDovL2NlcnQucGtpLmZyYXVuaG9mZXIuZGUvZmhnLXJv
b3QtY2EtMjAwNy5jZXIwPgYIKwYBBQUHMAKGMmh0dHA6Ly9jZXJ0LmZyYXVuaG9mZXItcGtp
LmRlL2ZoZy1yb290LWNhLTIwMDcuY2VyMA0GCSqGSIb3DQEBBQUAA4IBAQAAd2yMM/nuVwQl
ysuIOeZOTKTOwpZLGYZNuERXwpWpEDfsMFUxX/Wetbu1a1qhd+x6SyXY4V1CzcFDOGF3wA7b
yIV/6dyC53I9luZTjy9zjUsjLZucD4jeNja3QEu39sQsYsuE3MTfFFJgr/NeAFMHVkkHGx3l
VXb+F3J3+9xeXHk/wB/yIKd/RIiMMTT4+a+ra2MTCsYAe4kgJ0vz2TXYGN8tujjCgsUUbwfJ
C9wrOiCJMNJM1i7sUVqVKIoswW7h5QpWUNu1E4RAsDEz7depXCYaAIwPprEIkr0dE63zqHhm
M4egS7iGmBfNQohUO6jJOWNcJ9dIxqc0c/4WUHg8MIIFpDCCBIygAwIBAgIKXts1tgAAAACh
VTANBgkqhkiG9w0BAQUFADBnMQswCQYDVQQGEwJERTETMBEGA1UEChMKRnJhdW5ob2ZlcjEh
MB8GA1UECxMYRnJhdW5ob2ZlciBDb3Jwb3JhdGUgUEtJMSAwHgYDVQQDExdGcmF1bmhvZmVy
IFVzZXIgQ0EgMjAwNzAeFw0wOTEyMDkxNDQ3MTlaFw0xNTEyMDgxNDQ3MTlaMFgxCzAJBgNV
BAYTAkRFMRMwEQYDVQQKEwpGcmF1bmhvZmVyMQwwCgYDVQQLEwNJSVMxDzANBgNVBAsTBlBl
b3BsZTEVMBMGA1UEAxMMTWFudWVsIFN0YWhsMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAyc3xmHk19YZAmko+jIM52UsU0keIMlZuSsQvl7HCAGEzifKcfmrR6EX1lYPUKVZJ
BpqMSG3jyA4GW6gR/7cwz0IbnwFPC40KHPODRVIWDIJbZrP6zl+hF+G6/ZTe7ttPahSNhfeq
wkhQZJYQwoxEPoaODFpgQ8St+WRRkgfi3jvjuUIddgWV4NyVAm6m5fmF9a6iv20e+ZSW0As7
brNVf4Xvl5+y58MWniD3hjryz2OsqH1+NrFk8dxPjR4z3tWfty4x4J5af1z25tKX3xnJtx6Q
l61FI1UlSUqR3DHxkmLY7RRCccxtpwOES2YgmBBpJzrxCJ+cYwVJIVHR7I/3qwIDAQABo4IC
XzCCAlswDgYDVR0PAQH/BAQDAgbAMCkGA1UdEQQiMCCBHm1hbnVlbC5zdGFobEBpaXMuZnJh
dW5ob2Zlci5kZTAdBgNVHQ4EFgQUbNwp94oWTogPsGGtBT3dcKtNhXUwHwYDVR0jBBgwFoAU
Tx2viMptuKocCfnF0RHtWbST+gswdQYDVR0fBG4wbDBqoGigZoYxaHR0cDovL2NybC5wa2ku
ZnJhdW5ob2Zlci5kZS9maGctdXNlci1jYS0yMDA3LmNybIYxaHR0cDovL2NybC5mcmF1bmhv
ZmVyLXBraS5kZS9maGctdXNlci1jYS0yMDA3LmNybDCCAQoGCCsGAQUFBwEBBIH9MIH6MD4G
CCsGAQUFBzAChjJodHRwOi8vY2VydC5wa2kuZnJhdW5ob2Zlci5kZS9maGctdXNlci1jYS0y
MDA3LmNlcjA+BggrBgEFBQcwAoYyaHR0cDovL2NlcnQuZnJhdW5ob2Zlci1wa2kuZGUvZmhn
LXVzZXItY2EtMjAwNy5jZXIwOwYIKwYBBQUHMAGGL2h0dHA6Ly9maGctdXNlci1jYS0yMDA3
Lm9jc3AucGtpLmZyYXVuaG9mZXIuZGUvMDsGCCsGAQUFBzABhi9odHRwOi8vZmhnLXVzZXIt
Y2EtMjAwNy5vY3NwLmZyYXVuaG9mZXItcGtpLmRlLzATBgNVHSUEDDAKBggrBgEFBQcDBDBE
BgNVHSAEPTA7MDkGCysGAQQBhgpQAwEBMCowKAYIKwYBBQUHAgEWHGh0dHA6Ly9wa2kuZnJh
dW5ob2Zlci5kZS9jcC8wDQYJKoZIhvcNAQEFBQADggEBACWdlXdPPIhNtjC0aYQgGYQ9+e0N
XHqtaQsxgzZ2D4Rp34VeuZPWkF/YMDXgxB9sarzCO4WcBxz0QWjWiQOtAYzPc+2U3C3Pyw6Y
Mc0yxSpg6R602Hy/O1aNn7XZ50gujpIjuwo0fAFhg8OI63uolkgKAYyoUcTRHc4Z4kwb8bgg
+5a56lKIqBwTweqd2VaNnW0FCfk5bJsaw2j3bHnWkS2D9BWt0U+t+/zCqMYT9E38vTP57kho
vpb44u+8m6Xaaorn3bCK2WzHH5HZp/mVEZ6TZw+mJ+Ltjrcnz+9JAFYZxtpSpZN/k1zRM0P6
6CKxV9JfFqwQJnso0LtpcfLFGuMwggWwMIIEmKADAgECAgpe2zMWAAAAAKFUMA0GCSqGSIb3
DQEBBQUAMGcxCzAJBgNVBAYTAkRFMRMwEQYDVQQKEwpGcmF1bmhvZmVyMSEwHwYDVQQLExhG
cmF1bmhvZmVyIENvcnBvcmF0ZSBQS0kxIDAeBgNVBAMTF0ZyYXVuaG9mZXIgVXNlciBDQSAy
MDA3MB4XDTA5MTIwOTE0NDcxOVoXDTE1MTIwODE0NDcxOVowWDELMAkGA1UEBhMCREUxEzAR
BgNVBAoTCkZyYXVuaG9mZXIxDDAKBgNVBAsTA0lJUzEPMA0GA1UECxMGUGVvcGxlMRUwEwYD
VQQDEwxNYW51ZWwgU3RhaGwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC18idY
1AthSSVhkq1AFUnVfm5pzin5dEuixfJs+PaEQah9OWHYqSCxvXYL/58MtfpCsMl8HpIUsnuh
O4GPDjdxawgLSItU/LCF5/cmdc6swyi2efJC5QviHJ/aB/MbD3TKl9aGQXE0K85/iS4KQT2c
GM8uvWhF3yNNJIuauJ8BMX55vyelXT1rsldiGsBwKQ2PRcoM24jdtw/4DigsImSAkV6rxgg7
CeV92wE1trfx7OOoK9PPgAE9D95oiZz25f2MH7NnD4Wzo+73chdoQnhPZHNBojcxdyg+Rf3O
PCuKfXLYdTgEzEFGNFIwojaKoJ2ws1t2z3O62h7Tye0EMBtTAgMBAAGjggJrMIICZzAOBgNV
HQ8BAf8EBAMCBDAwKQYDVR0RBCIwIIEebWFudWVsLnN0YWhsQGlpcy5mcmF1bmhvZmVyLmRl
MB0GA1UdDgQWBBR3QN2wMBSsk+rxgVGtX5Plvb9tNzAfBgNVHSMEGDAWgBRPHa+Iym24qhwJ
+cXREe1ZtJP6CzB1BgNVHR8EbjBsMGqgaKBmhjFodHRwOi8vY3JsLnBraS5mcmF1bmhvZmVy
LmRlL2ZoZy11c2VyLWNhLTIwMDcuY3JshjFodHRwOi8vY3JsLmZyYXVuaG9mZXItcGtpLmRl
L2ZoZy11c2VyLWNhLTIwMDcuY3JsMIIBCgYIKwYBBQUHAQEEgf0wgfowPgYIKwYBBQUHMAKG
Mmh0dHA6Ly9jZXJ0LnBraS5mcmF1bmhvZmVyLmRlL2ZoZy11c2VyLWNhLTIwMDcuY2VyMD4G
CCsGAQUFBzAChjJodHRwOi8vY2VydC5mcmF1bmhvZmVyLXBraS5kZS9maGctdXNlci1jYS0y
MDA3LmNlcjA7BggrBgEFBQcwAYYvaHR0cDovL2ZoZy11c2VyLWNhLTIwMDcub2NzcC5wa2ku
ZnJhdW5ob2Zlci5kZS8wOwYIKwYBBQUHMAGGL2h0dHA6Ly9maGctdXNlci1jYS0yMDA3Lm9j
c3AuZnJhdW5ob2Zlci1wa2kuZGUvMB8GA1UdJQQYMBYGCisGAQQBgjcKAwQGCCsGAQUFBwME
MEQGA1UdIAQ9MDswOQYLKwYBBAGGClADAQEwKjAoBggrBgEFBQcCARYcaHR0cDovL3BraS5m
cmF1bmhvZmVyLmRlL2NwLzANBgkqhkiG9w0BAQUFAAOCAQEAIny6T0ZtZyrpF4dLpcM6G07I
HDC4cdGFLqfnqRLfMLwgdgxACPkYB8VbApcGKiSxcXaZEaz8CLLMrdwXkta1o+ZA6dz90Y1T
dYlvHvdsuhGeIkNwlJoGwlf4Ts4+7pi2d7sbYX3GFSzD3KcBn6DJp71pl4+MEcvkwVVaBKCw
+ohHssiRmG40fYAmdxBqPmjGyer4PftJdkvZQqmhqVDFp1NTJU9k/CQaIB24iSnuXfjHi1+z
Lz4flTgIGuN6lNAKGGt51kBl+WGy8olUDuyMwFAP7f1WIK4OWKWK0SbmMeDZtdN/aEpRRQ6l
0QATNFeFf1cK8auS+lRgG7lj74w/KzGCA24wggNqAgEBMHUwZzELMAkGA1UEBhMCREUxEzAR
BgNVBAoTCkZyYXVuaG9mZXIxITAfBgNVBAsTGEZyYXVuaG9mZXIgQ29ycG9yYXRlIFBLSTEg
MB4GA1UEAxMXRnJhdW5ob2ZlciBVc2VyIENBIDIwMDcCCl7bNbYAAAAAoVUwCQYFKw4DAhoF
AKCCAc4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTAwMjAx
MTQwODI1WjAjBgkqhkiG9w0BCQQxFgQUx2cpWbiJqn/ICLT66ViVCvLbJW0wXwYJKoZIhvcN
AQkPMVIwUDALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGEBgkrBgEEAYI3EAQxdzB1MGcx
CzAJBgNVBAYTAkRFMRMwEQYDVQQKEwpGcmF1bmhvZmVyMSEwHwYDVQQLExhGcmF1bmhvZmVy
IENvcnBvcmF0ZSBQS0kxIDAeBgNVBAMTF0ZyYXVuaG9mZXIgVXNlciBDQSAyMDA3Agpe2zMW
AAAAAKFUMIGGBgsqhkiG9w0BCRACCzF3oHUwZzELMAkGA1UEBhMCREUxEzARBgNVBAoTCkZy
YXVuaG9mZXIxITAfBgNVBAsTGEZyYXVuaG9mZXIgQ29ycG9yYXRlIFBLSTEgMB4GA1UEAxMX
RnJhdW5ob2ZlciBVc2VyIENBIDIwMDcCCl7bMxYAAAAAoVQwDQYJKoZIhvcNAQEBBQAEggEA
YuAgLYcLc67IcVKobDG8wknYMpkemh9DZ6qQ0P7zQ8dYIVXAy+2EJP/ALjo0Q/fTaIxPuefi
l5XIpPcytdXZBgGI5sRewMQUQrN8IhppOr8gy12gkYROr6w+88oWwd3l5D3wQb7YFUndzeuo
UYbCVDqIisFNaxoqzT+h0Iu+7KvIRw9Ehs3H5lk0kXFTYFBPQQVMnWkH1hi2v31vwu7Riotz
kuHudTh6jyI+eBUfwf/ag43yXrUaS/8ii7nlukr+62hIbV9O8wtjfhKBeOFOBlponKa9+g67
L4f8JSf4kthzO1gaUt2i+HNcDRTV9cigOPAQDZ0IMDJELN2JZMLUvQAAAAAAAA==
--------------ms010706020904060700050703--


--===============6863025586513226058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6863025586513226058==--
