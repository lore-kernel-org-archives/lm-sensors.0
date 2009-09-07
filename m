From: Rob Robason <Rob@robason.net>
Date: Mon, 07 Sep 2009 00:27:08 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] k8temp add support for family 10h and
Message-Id: <1252283228.4496.22.camel@pepe.robason.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0305843202601750668=="
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F7B6.4000901@assembler.cz>
In-Reply-To: <48E3F7B6.4000901@assembler.cz>
To: lm-sensors@vger.kernel.org


--===============0305843202601750668==
Content-Type: multipart/signed; micalg="sha1";
	protocol="application/x-pkcs7-signature";
	boundary="=-Scdqg9Pq5J/QMY1IruYH"


--=-Scdqg9Pq5J/QMY1IruYH
Content-Type: multipart/alternative; boundary="=-KoI9H9nXIorQ3xmx246J"


--=-KoI9H9nXIorQ3xmx246J
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm running my Fedora 11 system on an AMD Athlon 64 X2 7750 processor
and Gigabyte GA-MA78GM-US2H motherboard.=20
Running sensors-detect(8) finds the embedded "AMD K10 thermal sensors"
and reports "(driver "to be written"). In the summary it reports:

        Driver `to-be-written':
          * Chip `AMD K10 thermal sensors' (confidence: 9)
       =20
        Note: there is no driver for AMD K10 thermal sensors yet.
        Check http://www.lm-sensors.org/wiki/Devices for updates.

Checking the site, I found the subject topic and wondered if the 10h
family is synonymous with K10, and if the subject patch applies to my
system?

The sensors(1) app appears to pick up temperature readings from my
system, but I'm not able to figure out the mapping of the values I'm
getting (sample below):

        $ sensors
        it8718-isa-0228
        Adapter: ISA adapter
        in0:         +1.04 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
        in1:         +1.95 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
        in2:         +3.30 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
        in3:         +2.96 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
        in4:         +3.06 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
        in5:         +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
        in6:         +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
        in7:         +2.03 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
        Vbat:        +3.30 V
        fan1:       2537 RPM  (min =3D   10 RPM)
        fan2:          0 RPM  (min =3D    0 RPM)
        fan3:          0 RPM  (min =3D    0 RPM)
        fan4:          0 RPM  (min =3D    0 RPM)
        temp1:       +44.0=C2=B0C  (low  =3D +127.0=C2=B0C, high =3D +127.0=
=C2=B0C)  sensor
        =3D thermistor
        temp2:       +37.0=C2=B0C  (low  =3D +127.0=C2=B0C, high =3D +60.0=
=C2=B0C)  sensor
        =3D thermal diode
        temp3:       +46.0=C2=B0C  (low  =3D +127.0=C2=B0C, high =3D +127.0=
=C2=B0C)  sensor
        =3D thermistor
        cpu0_vid:   +1.550 V

Can you help me understand whether I need to wait for a K10 driver, can
use the subject patch, or need nothing? If waiting for the K10 driver is
the answer, can you give me any sense of when that might be available?
If I can use the patch, can you guide me on how to apply it to my
system?

Thanks, and best regards,

Rob Robason
Improving Software
Development
Practices and
Products=20


Work:
925-825-1512
Mobile:
925-348-1512


Email:
rob@robason.net http://www.linkedin.com/in/robrobason



 Concord, CA
       94518


See who we know in common=20
        Want a signature like this?=20


--=-KoI9H9nXIorQ3xmx246J
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; CHARSET=3DUTF-8">
  <META NAME=3D"GENERATOR" CONTENT=3D"GtkHTML/3.26.3">
</HEAD>
<BODY>
I'm running my Fedora 11 system on an AMD Athlon 64 X2 7750 processor and G=
igabyte GA-MA78GM-US2H motherboard. <BR>
Running sensors-detect(8) finds the embedded &quot;AMD K10 thermal sensors&=
quot; and reports &quot;(driver &quot;to be written&quot;). In the summary =
it reports:<BR>
<BLOCKQUOTE>
    Driver `to-be-written':<BR>
    &nbsp; * Chip `AMD K10 thermal sensors' (confidence: 9)<BR>
    <BR>
    Note: there is no driver for AMD K10 thermal sensors yet.<BR>
    Check http://www.lm-sensors.org/wiki/Devices for updates.<BR>
</BLOCKQUOTE>
Checking the site, I found the subject topic and wondered if the 10h family=
 is synonymous with K10, and if the subject patch applies to my system?<BR>
<BR>
The sensors(1) app appears to pick up temperature readings from my system, =
but I'm not able to figure out the mapping of the values I'm getting (sampl=
e below):<BR>
<BLOCKQUOTE>
    $ sensors<BR>
    it8718-isa-0228<BR>
    Adapter: ISA adapter<BR>
    in0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.04 V&nbsp; (min=
 =3D&nbsp; +0.00 V, max =3D&nbsp; +4.08 V)&nbsp;&nbsp; <BR>
    in1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.95 V&nbsp; (min=
 =3D&nbsp; +0.00 V, max =3D&nbsp; +4.08 V)&nbsp;&nbsp; <BR>
    in2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.30 V&nbsp; (min=
 =3D&nbsp; +0.00 V, max =3D&nbsp; +4.08 V)&nbsp;&nbsp; <BR>
    in3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +2.96 V&nbsp; (min=
 =3D&nbsp; +0.00 V, max =3D&nbsp; +4.08 V)&nbsp;&nbsp; <BR>
    in4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.06 V&nbsp; (min=
 =3D&nbsp; +0.00 V, max =3D&nbsp; +4.08 V)&nbsp;&nbsp; <BR>
    in5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +4.08 V&nbsp; (min=
 =3D&nbsp; +0.00 V, max =3D&nbsp; +4.08 V)&nbsp;&nbsp; ALARM<BR>
    in6:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +4.08 V&nbsp; (min=
 =3D&nbsp; +0.00 V, max =3D&nbsp; +4.08 V)&nbsp;&nbsp; ALARM<BR>
    in7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +2.03 V&nbsp; (min=
 =3D&nbsp; +0.00 V, max =3D&nbsp; +4.08 V)&nbsp;&nbsp; <BR>
    Vbat:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.30 V<BR>
    fan1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2537 RPM&nbsp; (min =3D&nbsp;=
&nbsp; 10 RPM)<BR>
    fan2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp;=
 (min =3D&nbsp;&nbsp;&nbsp; 0 RPM)<BR>
    fan3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp;=
 (min =3D&nbsp;&nbsp;&nbsp; 0 RPM)<BR>
    fan4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp;=
 (min =3D&nbsp;&nbsp;&nbsp; 0 RPM)<BR>
    temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +44.0&#176;C&nbsp; (low&nbsp=
; =3D +127.0&#176;C, high =3D +127.0&#176;C)&nbsp; sensor =3D thermistor<BR=
>
    temp2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +37.0&#176;C&nbsp; (low&nbsp=
; =3D +127.0&#176;C, high =3D +60.0&#176;C)&nbsp; sensor =3D thermal diode<=
BR>
    temp3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +46.0&#176;C&nbsp; (low&nbsp=
; =3D +127.0&#176;C, high =3D +127.0&#176;C)&nbsp; sensor =3D thermistor<BR=
>
    cpu0_vid:&nbsp;&nbsp; +1.550 V<BR>
</BLOCKQUOTE>
Can you help me understand whether I need to wait for a K10 driver, can use=
 the subject patch, or need nothing? If waiting for the K10 driver is the a=
nswer, can you give me any sense of when that might be available? If I can =
use the patch, can you guide me on how to apply it to my system?<BR>
<BR>
<TABLE CELLSPACING=3D"0" CELLPADDING=3D"0" WIDTH=3D"100%">
<TR>
<TD>
Thanks, and best regards,<BR>
<BR>
<TABLE CELLSPACING=3D"0" CELLPADDING=3D"0" WIDTH=3D"100%">
<TR>
<TD COLSPAN=3D"2">
<TABLE CELLSPACING=3D"0" CELLPADDING=3D"0" WIDTH=3D"100%">
<TR>
<TD>
<B>Rob Robason</B><BR>
Improving Software Development Practices and Products=20
</TD>
<TD ALIGN=3D"right">
<BR>
<BR>
</TD>
</TR>
</TABLE>
</TD>
</TR>
<TR>
<TD COLSPAN=3D"2">
<TABLE CELLSPACING=3D"0" CELLPADDING=3D"0" WIDTH=3D"100%">
<TR>
<TD WIDTH=3D"33%" VALIGN=3D"top">
<B><FONT COLOR=3D"#999999">Work:</FONT></B> 925-825-1512<BR>
<B><FONT COLOR=3D"#999999">Mobile:</FONT></B> 925-348-1512<BR>
<BR>
<BR>
</TD>
<TD WIDTH=3D"33%" VALIGN=3D"top">
<B><FONT COLOR=3D"#999999">Email:</FONT></B> <FONT COLOR=3D"#000000"><A HRE=
F=3D"mailto:rob@robason.net">rob@robason.net</A></FONT> <A HREF=3D"http://w=
ww.linkedin.com/in/robrobason">http://www.linkedin.com/in/robrobason</A><BR=
>
<BR>
<BR>
</TD>
<TD WIDTH=3D"33%" ALIGN=3D"right" VALIGN=3D"top">
<BR>
<FONT COLOR=3D"#000000"><A HREF=3D"http://maps.google.com/maps?q=3D%2CConco=
rd%2CCA+94518&amp;hl=3Den">Concord, CA 94518</A></FONT><BR>
<BR>
<BR>
</TD>
</TR>
</TABLE>
</TD>
</TR>
<TR>
<TD>
<A HREF=3D"http://www.linkedin.com/e/wwk/1418237/">See who we know in commo=
n</A>=20
</TD>
<TD ALIGN=3D"right">
<A HREF=3D"http://www.linkedin.com/e/sig/1418237/">Want a signature like th=
is?</A>=20
</TD>
</TR>
</TABLE>
</TD>
</TR>
</TABLE>
<BR>
</BODY>
</HTML>

--=-KoI9H9nXIorQ3xmx246J--

--=-Scdqg9Pq5J/QMY1IruYH
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGRDCCAv0w
ggJmoAMCAQICEDmnjpbpTJSID2nUm8c08ogwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA5MDIyODA4MjQzMFoXDTEwMDIyODA4MjQz
MFowZjEQMA4GA1UEBBMHUm9iYXNvbjEUMBIGA1UEKhMLUm9iZXJ0IEVhcmwxHDAaBgNVBAMTE1Jv
YmVydCBFYXJsIFJvYmFzb24xHjAcBgkqhkiG9w0BCQEWD3JvYkByb2Jhc29uLm5ldDCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAM2QTVas0KKhMheXU0X8vDc0tPd4eRCwATOilpsDfJZF
SJCUmC12mrPZyoMCCi6r+pEuXr6gTIdTrBb5Ob3tNPkvLLEckj7KbxLVNPVNpkQt4F/98JsewaSr
/SpsrGk3V4wxnm7VjwKQJrnMQHQSkNxiGheB9LzGABXk6oCI1qE0YrNAvSyFQtEFvn2ysI7Cqv2c
AgKKFhxYA8u8fbEc2KS3TXvjgOU615ZHYmPbHQ5a0kWCCX7yLyAb0h7ljmZeCwsFfCfMr0YbF6lP
oY9Nk+4jTba+K1cxN4JOSSQ5VgNScwLzGEtQlnyrg/V7mw4dXBu8MLPsWhH23LO2WkCIfJ8CAwEA
AaMsMCowGgYDVR0RBBMwEYEPcm9iQHJvYmFzb24ubmV0MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcN
AQEFBQADgYEAhoJkMgUGsglUQPxCV2+SJ01RuvcQHerrUsD20HYOyjTztu6bn4FHUqrm0PE5SNbf
XxlK9kojLQR0C9OHlzgpSJdsTS4V81cZp+tBHdkrREuSxguPCjveipPhez+BN0GV+UwqvfFB2bfP
LGTNEVMI/otpKi9Eq4z3tG4D3e12vtcwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHR
MQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24x
GjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZp
Y2VzIERpdmlzaW9uMSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkq
hkiG9w0BCQEWHHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcN
MTMwNzE2MjM1OTU5WjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcg
KFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0Ew
gZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb
8hp2vX8MOmHyv1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9
A74r/rsYPge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYD
VR0TAQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20v
VGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQeMBwx
GjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsuzA2j
ZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguCdJ4l
UJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9d
X2VPMYIB/DCCAfgCAQEwdjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRp
bmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3Vpbmcg
Q0ECEDmnjpbpTJSID2nUm8c08ogwCQYFKw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTA5MDkwNzAwMjY0NlowIwYJKoZIhvcNAQkEMRYEFBBRWrb20bda
iSWhro/YEwusk2bnMA0GCSqGSIb3DQEBAQUABIIBAA7e/Ue2EgfM9gxSYrgc2Y6+Q8y+DHFIO7D9
dJmy9gc15OGbczYiJueePq7491Vm4YHOpyu1hCIRArqwLSfOIFPtv8/N0aueDYTU3/oCWy0sAZxl
hYn36JfhADzFukk+wvzrnP29AkKpBuPqCAhyhogKGXkjuMjO8X7e9z0Ru6BI9imgEPGJFyhjixCe
zEjPNYnlNMQuUvLwwU2A1YMml3iYWNJrDRKVRcVg5rlXeoy8QTgXelnDhr4t//thI0HYWfQX4prq
0v591vIRXSOYSWfHp5igs9oEUPFVfVOJE31Zarg1frkwv7ODc1qUo6zbZDx9DgGPYmfXdCl9bNUN
IV8AAAAAAAA=


--=-Scdqg9Pq5J/QMY1IruYH--



--===============0305843202601750668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0305843202601750668==--

