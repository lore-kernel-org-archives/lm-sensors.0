From: Andrew Smith <Andrew@GNAServicesInc.com>
Date: Fri, 27 Jan 2012 20:26:17 +0000
Subject: Re: [lm-sensors] sensors-detect bug ?
Message-Id: <4F230869.3000301@GNAServicesInc.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3559503086595358558=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4F22E64F.8060204@GNAServicesInc.com>
In-Reply-To: <4F22E64F.8060204@GNAServicesInc.com>
To: lm-sensors@vger.kernel.org

This is a cryptographically signed message in MIME format.

--===============3559503086595358558==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms000501070709050003040008"

This is a cryptographically signed message in MIME format.

--------------ms000501070709050003040008
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

3.2.2

ls -l /sys/bus/i2c/devices/i2c-*/
/sys/bus/i2c/devices/i2c-0/:
ls: cannot access /sys/bus/i2c/devices/i2c-0/LNXSYSTM:00: No such file
or directory
ls: cannot access /sys/bus/i2c/devices/i2c-0/cpu: No such file or directo=
ry
ls: cannot access /sys/bus/i2c/devices/i2c-0/breakpoint: No such file or
directory
total 0
drwxr-xr-x 18 root root 0 2012-01-27 12:18
d?????????  ? ?    ?    ?                ? breakpoint
d?????????  ? ?    ?    ?                ? cpu
drwxr-xr-x  4 root root 0 2012-01-27 12:18 i2c-1
drwxr-xr-x  4 root root 0 2012-01-27 12:18 i2c-2
drwxr-xr-x  4 root root 0 2012-01-27 12:18 i2c-3
drwxr-xr-x  4 root root 0 2012-01-27 12:18 i2c-4
drwxr-xr-x  3 root root 0 2012-01-27 12:18 ibs
d?????????  ? ?    ?    ?                ? LNXSYSTM:00
drwxr-xr-x 18 root root 0 2012-01-27 12:18 pci0000:00
drwxr-xr-x 10 root root 0 2012-01-27 12:18 platform
drwxr-xr-x 18 root root 0 2012-01-27 12:18 pnp0
drwxr-xr-x  3 root root 0 2012-01-27 15:06 rapidio
drwxr-xr-x  3 root root 0 2012-01-27 12:18 software
drwxr-xr-x  8 root root 0 2012-01-27 12:20 system
drwxr-xr-x 19 root root 0 2012-01-27 12:18 virtual

/sys/bus/i2c/devices/i2c-1/:
total 0
- --w------- 1 root root 4096 2012-01-27 15:06 delete_device
drwxr-xr-x 3 root root    0 2012-01-27 13:19 i2c-dev
- -r--r--r-- 1 root root 4096 2012-01-27 12:18 name
- --w------- 1 root root 4096 2012-01-27 15:06 new_device
drwxr-xr-x 2 root root    0 2012-01-27 15:06 power
lrwxrwxrwx 1 root root    0 2012-01-27 12:18 subsystem -> ../../bus/i2c
- -rw-r--r-- 1 root root 4096 2012-01-27 12:18 uevent

/sys/bus/i2c/devices/i2c-2/:
total 0
- --w------- 1 root root 4096 2012-01-27 15:06 delete_device
drwxr-xr-x 3 root root    0 2012-01-27 13:19 i2c-dev
- -r--r--r-- 1 root root 4096 2012-01-27 12:18 name
- --w------- 1 root root 4096 2012-01-27 15:06 new_device
drwxr-xr-x 2 root root    0 2012-01-27 15:06 power
lrwxrwxrwx 1 root root    0 2012-01-27 12:18 subsystem -> ../../bus/i2c
- -rw-r--r-- 1 root root 4096 2012-01-27 12:18 uevent

/sys/bus/i2c/devices/i2c-3/:
total 0
- --w------- 1 root root 4096 2012-01-27 15:06 delete_device
drwxr-xr-x 3 root root    0 2012-01-27 13:19 i2c-dev
- -r--r--r-- 1 root root 4096 2012-01-27 12:18 name
- --w------- 1 root root 4096 2012-01-27 15:06 new_device
drwxr-xr-x 2 root root    0 2012-01-27 15:06 power
lrwxrwxrwx 1 root root    0 2012-01-27 12:18 subsystem -> ../../bus/i2c
- -rw-r--r-- 1 root root 4096 2012-01-27 12:18 uevent

/sys/bus/i2c/devices/i2c-4/:
total 0
- --w------- 1 root root 4096 2012-01-27 15:06 delete_device
drwxr-xr-x 3 root root    0 2012-01-27 13:19 i2c-dev
- -r--r--r-- 1 root root 4096 2012-01-27 12:18 name
- --w------- 1 root root 4096 2012-01-27 15:06 new_device
drwxr-xr-x 2 root root    0 2012-01-27 15:06 power
lrwxrwxrwx 1 root root    0 2012-01-27 12:18 subsystem -> ../../bus/i2c
- -rw-r--r-- 1 root root 4096 2012-01-27 12:18 uevent

grep . /sys/bus/i2c/devices/i2c-*/name
/sys/bus/i2c/devices/i2c-1/name:Radeon i2c bit bus 0x91
/sys/bus/i2c/devices/i2c-2/name:Radeon i2c bit bus 0x92
/sys/bus/i2c/devices/i2c-3/name:Radeon i2c bit bus 0x93
/sys/bus/i2c/devices/i2c-4/name:Radeon i2c bit bus 0x14
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJPIwhpAAoJEGf+DvovjtYGkL0P/2HQ+ShUBH3jQfpgJ1oN421t
y5UHPiT/aO3WVGH+wEH+Uw5Tz6Tmjk9gjUnucVgi+Buz+uTQ36ZQONkTPQ28Y+K3
m05f0/9eQmT/Etm29rh6LilJ9/HO2DRCNiyqJ4CoWbcfYH75e1bmhPsJdE3fqXVT
+JMavjj5B3iEPHxvBIS//fTtlHL72cBQfZGGOUw+YuYCAD2VVEO8VOpYcLDdYXrU
roNRKxJAMwHFkqJGwd+Nt6oGEvRsKcsUH12ZfNnth/0XJzYHGrqVROPBb+Nfsvne
G8CbXv4/yUI7Dx4bNxgAjqY+iPjU9sJjjESFURs0vsy5MOPELIIVTgPyuCQbtoj+
PF6SE5+gXtTaxhfwr/qvyMzS30eMIBj2TQTLgUAF1aQAAD/CgE60swJ2Qj3XiQuG
nnx8fM//pf9WTYY28t9Gnr4BPW4KNfrAPcy5tK5ob82p2O34EgSjZ6sXB0M/73MP
2Ir6h4Kt/s7RfaX7NJlAVrhAe8amTb8jcF2PMthe1RQCPQYPxcTsdRXjjFklGd6u
ahVa/1Ss/yAnkC9oauHD4FhlRObQ+S8M93qRGNbTzUACLMsnQBljrMH5im7I1tu9
qGXA0WzyY3b1zqnChUS6T3LAzMWO405ASLT86bl03gW3HZnItrVFFlG4Ov6Ki6g0
LIOR9GiLethsJiay4+mT
=3DX0wa
-----END PGP SIGNATURE-----


--------------ms000501070709050003040008
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
9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMjAxMjcyMDI2MTdaMCMGCSqG
SIb3DQEJBDEWBBRht+ATLGkwJnLZdZM8LAJND9qPXjBfBgkqhkiG9w0BCQ8xUjBQMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYF
Kw4DAgcwDQYIKoZIhvcNAwICASgwgdQGCSsGAQQBgjcQBDGBxjCBwzCBrjELMAkGA1UEBhMC
VVMxCzAJBgNVBAgTAlVUMRcwFQYDVQQHEw5TYWx0IExha2UgQ2l0eTEeMBwGA1UEChMVVGhl
IFVTRVJUUlVTVCBOZXR3b3JrMSEwHwYDVQQLExhodHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20x
NjA0BgNVBAMTLVVUTi1VU0VSRmlyc3QtQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBFbWFp
bAIQUVX68kYv248J0u62JN9CvDCB1gYLKoZIhvcNAQkQAgsxgcaggcMwga4xCzAJBgNVBAYT
AlVTMQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRo
ZSBVU0VSVFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29t
MTYwNAYDVQQDEy1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgRW1h
aWwCEFFV+vJGL9uPCdLutiTfQrwwDQYJKoZIhvcNAQEBBQAEggEAfUPuuljulXbGGoDYFcuS
K8Eh9TVbI6NOQQCvhxtQzK09Nzkx4l3UNzoZqOljud9h7P9x7tg5NpqWO+u6qBG8XANdT+BJ
rHgExJqKffXN57BN1HxpYJzvyWgPknbGlQ0cOuF+2aH9dbNrOIfxbm7NRBNzspJXWOYvcG1G
uqYwyqxlG/sJcDDh9wy9h2SpJ0LQxPTnaElHVRCmuSCPx/oID6HF3IGAJ10OY4eO7YxxiWVe
EJewOOy6U9JGCCcdzdeBKTqhV22gCFGJ8jPKNbNErSU1kehZpcZWLFx+oOn+s+Bv4YzsA81A
Can175NmDr9Mcedy3hsDv2ixutvPdQLO3QAAAAAAAA==
--------------ms000501070709050003040008--


--===============3559503086595358558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3559503086595358558==--
