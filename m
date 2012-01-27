From: Andrew Smith <Andrew@GNAServicesInc.com>
Date: Fri, 27 Jan 2012 18:00:47 +0000
Subject: [lm-sensors] sensors-detect bug ?
Message-Id: <4F22E64F.8060204@GNAServicesInc.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5388868121059178906=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a cryptographically signed message in MIME format.

--===============5388868121059178906==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms000600090102040904060204"

This is a cryptographically signed message in MIME format.

--------------ms000600090102040904060204
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

When I run the latest lm-sensors I am getting some errors,

The unique error lines are

Use of uninitialized value in string eq at ./sensors-detect line 2622,
<STDIN> line 5.

Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040, <STDIN> line 5.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040.
Use of uninitialized value in concatenation (.) or string at
=2E/sensors-detect line 3575.

The entire output is:

Use of uninitialized value in string eq at ./sensors-detect line 2622,
<STDIN> line 5.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040, <STDIN> line 5.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040, <STDIN> line 5.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040, <STDIN> line 5.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040, <STDIN> line 5.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040, <STDIN> line 5.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040, <STDIN> line 5.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040, <STDIN> line 5.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040, <STDIN> line 5.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040, <STDIN> line 5.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040, <STDIN> line 5.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040, <STDIN> line 5.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040, <STDIN> line 5.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040, <STDIN> line 5.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040, <STDIN> line 5.

Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040.
Use of uninitialized value $name in pattern match (m//) at
=2E/sensors-detect line 3040.
Use of uninitialized value in concatenation (.) or string at
=2E/sensors-detect line 3575.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJPIuZKAAoJEGf+DvovjtYGZUwP/i5KHrikEPyI1E+DxDc9jttc
6mTkn5CHAER3RbDhKkfoUlvGyhSGsNvam5Wov5wYDz539esbTfW9gGuQBcWp7sTE
1+2sm0IOY3ImZIppuoeVSjEs/0uEAXSaePlmncdm32wxT4oJADBA2nKGpaClaFFu
ECDd11SKIEOhVEBOGQw4oA891OdNoLQHE0i3nwlJnEvT1/w6qgH94EVyl9jimeUU
SjKl/8XOIBoJF159/tJfyw9gNBdkNjOFHMD+AN5KnPgDYudMFeQXa/S10p1NWC5q
0cLBT+fAIRP+6ZJehnb9mxeCr6NV6qluaNgd984cs/WE1TnSZKlt5wmtt95y2KT1
87CHl4Qo+8f0pt78DtkXLyBWkYQ5R+u4lFyP2NAYTJZizp2ae0zfuDvRzX5YYtKY
djEsL7TUiyc7mSzhqQigK/ML6iFf3EqUwc5KoaszoBgayC1D3eimHpC0t1pT1jah
c3zsnw6nm102dSTLVkkISVDkYgnKHdVDGzmNzHpvQkbfD1cB9XYXgQ4xjG64at4M
IcKjacQbMwGTwMZU+2rPGB5u1nNnMeWXzieaj4HdrWP81KD1Y1Qojn8H6uP1katp
vD/ziuL6ydw6dyjqb71mxpiPupLsJwJOismSHHJnZopQFovTdbO/q93zmUxuvpnZ
HqD21FbI5aomOcBdwgkL
=3DuZLO
-----END PGP SIGNATURE-----


--------------ms000600090102040904060204
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKEjCC
BIowggNyoAMCAQICECf06hH0eobEbp27bqkXBwcwDQYJKoZIhvcNAQEFBQAwbzELMAkGA1UE
BhMCU0UxFDASBgNVBAoTC0FkZFRydXN0IEFCMSYwJAYDVQQLEx1BZGRUcnVzdCBFeHRlcm5h
bCBUVFAgTmV0d29yazEiMCAGA1UEAxMZQWRkVHJ1c3QgRXh0ZXJuYWwgQ0EgUm9vdDAeFw0w
NTA2MDcwODA5MTBaFw0yMDA1MzAxMDQ4MzhaMIGuMQswCQYDVQQGEwJVUzELMAkGA1UECBMC
VVQxFzAVBgNVBAcTDlNhbHQgTGFrZSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5l
dHdvcmsxITAfBgNVBAsTGGh0dHA6Ly93d3cudXNlcnRydXN0LmNvbTE2MDQGA1UEAxMtVVRO
LVVTRVJGaXJzdC1DbGllbnQgQXV0aGVudGljYXRpb24gYW5kIEVtYWlsMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsjmFpPJ9q0E7YkY3rs3BYHW8OWX5ShpHornMSMxqmNVN
NRm5pELlzkniii8efNIxB8dOtINknS4p1aJkxIW9hVE1eaROaJB7HHqkkqgX8pgV8pPMyaQy
lbsMTzC9mKALi+VuG6JG+ni8om+rWV6lL8/K2m2qL+usobNqqrcuZzWLeeEeaYji5kbNoKXq
vgvOdjp6Dpvq/NonWz1zHyLmSGHGTPNpsaguG7bUMSAsvIKKjqQOpdeJQ/wWWq8dcdcRWdq6
hw2v+vPhwvCkxWeM1tZUOt4KpLoDd7NlyP0e03RiqhjKaJMeoYV+9Udly/hNVyh00jT/MLbu
9mIwFIws6wIDAQABo4HhMIHeMB8GA1UdIwQYMBaAFK29mHo0tCb3+sQmVO8DveAky1QaMB0G
A1UdDgQWBBSJgmd9xJ0mcABLtFBIfN49rgRufTAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/
BAUwAwEB/zB7BgNVHR8EdDByMDigNqA0hjJodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9BZGRU
cnVzdEV4dGVybmFsQ0FSb290LmNybDA2oDSgMoYwaHR0cDovL2NybC5jb21vZG8ubmV0L0Fk
ZFRydXN0RXh0ZXJuYWxDQVJvb3QuY3JsMA0GCSqGSIb3DQEBBQUAA4IBAQAZ2IkRbyispgCi
54fBm5AD236hEv0e8+LwAamUVEJrmgnEoG3XkJIEA2Z5Q3H8+G+v23ZF4jcaPd3kWQR4rBz0
g0bzes9bhHIt5UbBuhgRKfPLSXmHPLptBZ2kbWhPrXIUNqi5sf2/z3/wpGqUNVCPz4FtVbHd
WTBK322gnGQfSXzvNrv042n0+DmPWq1LhTq3Du3Tzw1EovsEv+QvcI4l+1pUBrPQxLxtjftz
Mizpm4QkLdZ/kXpoAlAfDj9N6cz1u2fo3BwuO/xOzf4CjuOoEwqlJkRl6RDyTVKnrtw+ymsy
XEFs/vVdoOr/0fqbhlhtPZZH5f4ulQTCAMyOofK7MIIFgDCCBGigAwIBAgIQUVX68kYv248J
0u62JN9CvDANBgkqhkiG9w0BAQUFADCBrjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlVUMRcw
FQYDVQQHEw5TYWx0IExha2UgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3Jr
MSEwHwYDVQQLExhodHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20xNjA0BgNVBAMTLVVUTi1VU0VS
Rmlyc3QtQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBFbWFpbDAeFw0xMTAyMTAwMDAwMDBa
Fw0xMjAyMTAyMzU5NTlaMCoxKDAmBgkqhkiG9w0BCQEWGWFuZHJld0BnbmFzZXJ2aWNlc2lu
Yy5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDElVlYcSSyKqkAo6Tw2Z2y
yKmsak/RPwTfPW3xROiTs9sxs8p6NsutIcqEjezJWK3BuglcUUx28vQm5eaqGiXSOvCrjWz+
Qq+oINqYRcMn7ziU1NKNxrH60ZGHLFzclfRNUhzkIfjwnmIJyUorwhsZhWfP+bxO13iPc4MO
3+bko1GJ1fzF3eLZsMHbl2joRwrbSs7IbCPLJ/XqBV4efmugFd3jK6lU8rQFaKxAKb+bK26q
bI3NIGWo//d9c7gNaqG9Xa+mWWgz9d2EY8MyMm/J5zNNAspE7ppZLT75zxrZMJLjMxnWqLo/
3v6DQjsVTupG6NclSd4nnJNM9cLGeu0dAgMBAAGjggIbMIICFzAfBgNVHSMEGDAWgBSJgmd9
xJ0mcABLtFBIfN49rgRufTAdBgNVHQ4EFgQUnEKDEnBFULXrM4/Hz22n+DoolKAwDgYDVR0P
AQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwIAYDVR0lBBkwFwYIKwYBBQUHAwQGCysGAQQBsjEB
AwUCMBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEBATArMCkG
CCsGAQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzCBpQYDVR0fBIGdMIGa
MEygSqBIhkZodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9VVE4tVVNFUkZpcnN0LUNsaWVudEF1
dGhlbnRpY2F0aW9uYW5kRW1haWwuY3JsMEqgSKBGhkRodHRwOi8vY3JsLmNvbW9kby5uZXQv
VVROLVVTRVJGaXJzdC1DbGllbnRBdXRoZW50aWNhdGlvbmFuZEVtYWlsLmNybDBsBggrBgEF
BQcBAQRgMF4wNgYIKwYBBQUHMAKGKmh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL1VUTkFBQUNs
aWVudENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMCQGA1Ud
EQQdMBuBGWFuZHJld0BnbmFzZXJ2aWNlc2luYy5jb20wDQYJKoZIhvcNAQEFBQADggEBAIgy
Ezr16rXgcQpUP5YEsnm0DM+mZIMnB4viL9ScZ6RsffZYrdqA1Nnyt/q2bgPu/vBIQxjykc+G
g62YrM0N0Lp1gccNTFhIo/cFd7+A/90zNqe1iq7R+U1UO4vlii6pf39IoM1Lhk8kpoCJcK3T
OCVYF8viWZfmPm6FIPbz+kI5qBE7739/ub7RheEn5kXS1Tz29s2typf/2CtsBMigCQ1Jr15M
LCEY0juMsAt5YEyKYpJ1LkLhtu+7hCg/sVd8I49Htf7LkZlcVRZhrNR3s79z9yRbRm7uPgEC
I9RzEb/S8zVtw8abTj5r8ZW7aIJ9fDIDhQ7iihWSJxHMLDU9VUIxggRdMIIEWQIBATCBwzCB
rjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlVUMRcwFQYDVQQHEw5TYWx0IExha2UgQ2l0eTEe
MBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMSEwHwYDVQQLExhodHRwOi8vd3d3LnVz
ZXJ0cnVzdC5jb20xNjA0BgNVBAMTLVVUTi1VU0VSRmlyc3QtQ2xpZW50IEF1dGhlbnRpY2F0
aW9uIGFuZCBFbWFpbAIQUVX68kYv248J0u62JN9CvDAJBgUrDgMCGgUAoIICbjAYBgkqhkiG
9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMjAxMjcxODAwNDdaMCMGCSqG
SIb3DQEJBDEWBBS7PzBVwoRCjeiQ3g8DrFguy+nJQDBfBgkqhkiG9w0BCQ8xUjBQMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYF
Kw4DAgcwDQYIKoZIhvcNAwICASgwgdQGCSsGAQQBgjcQBDGBxjCBwzCBrjELMAkGA1UEBhMC
VVMxCzAJBgNVBAgTAlVUMRcwFQYDVQQHEw5TYWx0IExha2UgQ2l0eTEeMBwGA1UEChMVVGhl
IFVTRVJUUlVTVCBOZXR3b3JrMSEwHwYDVQQLExhodHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20x
NjA0BgNVBAMTLVVUTi1VU0VSRmlyc3QtQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBFbWFp
bAIQUVX68kYv248J0u62JN9CvDCB1gYLKoZIhvcNAQkQAgsxgcaggcMwga4xCzAJBgNVBAYT
AlVTMQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRo
ZSBVU0VSVFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29t
MTYwNAYDVQQDEy1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgRW1h
aWwCEFFV+vJGL9uPCdLutiTfQrwwDQYJKoZIhvcNAQEBBQAEggEAp7Aqb+0thATltljRrR2e
Z0K/VrG1MbHe4US9W0PSOJK2QdEvW0Q3VBSXbqO6Ug1eoDb6qbAjX/Z7zgJ4g7kxyAqIkL+e
qk+7TYh+S9SWxIfn/NS7oK7px2g6vMBpJbXyICFpBkt44gErSioHE+BLQkdmFNRZD6t3RR8A
L0swx1+Kg13iAd/VsP9xH1mACKpta2FoFtwylsrOyUhomye83EHIx93uIXpV1QsOY7lpPVRn
Ft7HVki4OuA9+qSEZ0f6X6KbYjUYXko3bLlJ8TiE6LK9ErEsEZ1sIG0sIeRKkezTZLKKwthY
NdAMeWRaydjDBQvol5+mTWF7A8pOiD+2LwAAAAAAAA==
--------------ms000600090102040904060204--


--===============5388868121059178906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5388868121059178906==--
