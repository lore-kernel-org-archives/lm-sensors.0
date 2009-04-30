From: Stefan Steuerwald <salsasepp@googlemail.com>
Date: Thu, 30 Apr 2009 12:33:41 +0000
Subject: Re: [lm-sensors] dme1737: Base address not set / How to do the
Message-Id: <f76a32050904300533kac519b9v2c8bc5fcd7463af9@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="001636457c72f7d2870468c4e7f4"
List-Id: <lm-sensors.vger.kernel.org>
References: <f76a32050904290817u6e296898x2fdbd43136e0d5ef@mail.gmail.com>
In-Reply-To: <f76a32050904290817u6e296898x2fdbd43136e0d5ef@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--001636457c72f7d2870468c4e7f4
Content-Type: multipart/alternative; boundary=001636457c72f7d2790468c4e7f2

--001636457c72f7d2790468c4e7f2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Have attached cpuinfo and ioports.
I chose 0x0600 as the base address for the SCH3114 SuperIO, seems to work so
far. Better suggestions welcome ;-)

Thank you!
  Stefan.


2009/4/30 Rudolf Marek <r.marek@assembler.cz>

> Hi,
>
> If you tell me cat /proc/cpuinfo and what type of SB you have I might tell
> some IO addresses which are safe to use ;)
>
> I think you can setup there usually something around 0x300 like 0x290.
> Assuming that the rest of superio lives at 0x2e/0x2f or so...
>
> Btw what BIOS is that?
>
> Rudolf
>

--001636457c72f7d2790468c4e7f2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Have attached cpuinfo and ioports.<br>I chose 0x0600 as the base address fo=
r the SCH3114 SuperIO, seems to work so far. Better suggestions welcome ;-)=
<br><br>Thank you!<br>=C2=A0 Stefan.<br><br><br><div class=3D"gmail_quote">=
2009/4/30 Rudolf Marek <span dir=3D"ltr">&lt;<a href=3D"mailto:r.marek@asse=
mbler.cz">r.marek@assembler.cz</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br>
<br>
If you tell me cat /proc/cpuinfo and what type of SB you have I might tell =
some IO addresses which are safe to use ;)<br>
<br>
I think you can setup there usually something around 0x300 like 0x290. Assu=
ming that the rest of superio lives at 0x2e/0x2f or so...<br>
<br>
Btw what BIOS is that?<br><font color=3D"#888888">
<br>
Rudolf<br>
</font></blockquote></div><br>

--001636457c72f7d2790468c4e7f2--

--001636457c72f7d2870468c4e7f4
Content-Type: application/octet-stream; name="proc.cpuinfo"
Content-Disposition: attachment; filename="proc.cpuinfo"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fu5foith0

cHJvY2Vzc29yCTogMAp2ZW5kb3JfaWQJOiBHZW51aW5lSW50ZWwKY3B1IGZhbWlseQk6IDYKbW9k
ZWwJCTogMjgKbW9kZWwgbmFtZQk6IEludGVsKFIpIEF0b20oVE0pIENQVSBaNTMwICAgQCAxLjYw
R0h6CnN0ZXBwaW5nCTogMgpjcHUgTUh6CQk6IDE1OTUuOTYwCmNhY2hlIHNpemUJOiA1MTIgS0IK
cGh5c2ljYWwgaWQJOiAwCnNpYmxpbmdzCTogMgpjb3JlIGlkCQk6IDAKY3B1IGNvcmVzCTogMQph
cGljaWQJCTogMAppbml0aWFsIGFwaWNpZAk6IDAKZmRpdl9idWcJOiBubwpobHRfYnVnCQk6IG5v
CmYwMGZfYnVnCTogbm8KY29tYV9idWcJOiBubwpmcHUJCTogeWVzCmZwdV9leGNlcHRpb24JOiB5
ZXMKY3B1aWQgbGV2ZWwJOiAxMAp3cAkJOiB5ZXMKZmxhZ3MJCTogZnB1IHZtZSBkZSBwc2UgdHNj
IG1zciBwYWUgbWNlIGN4OCBhcGljIHNlcCBtdHJyIHBnZSBtY2EgY21vdiBwYXQgY2xmbHVzaCBk
dHMgYWNwaSBtbXggZnhzciBzc2Ugc3NlMiBzcyBodCB0bSBwYmUgbnggY29uc3RhbnRfdHNjIGFy
Y2hfcGVyZm1vbiBwZWJzIGJ0cyBwbmkgZHRlczY0IG1vbml0b3IgZHNfY3BsIHZteCBlc3QgdG0y
IHNzc2UzIHh0cHIgcGRjbSBsYWhmX2xtIHRwcl9zaGFkb3cgdm5taSBmbGV4cHJpb3JpdHkKYm9n
b21pcHMJOiAzMTkxLjkyCmNsZmx1c2ggc2l6ZQk6IDY0CnBvd2VyIG1hbmFnZW1lbnQ6Cgpwcm9j
ZXNzb3IJOiAxCnZlbmRvcl9pZAk6IEdlbnVpbmVJbnRlbApjcHUgZmFtaWx5CTogNgptb2RlbAkJ
OiAyOAptb2RlbCBuYW1lCTogSW50ZWwoUikgQXRvbShUTSkgQ1BVIFo1MzAgICBAIDEuNjBHSHoK
c3RlcHBpbmcJOiAyCmNwdSBNSHoJCTogMTU5NS45NjAKY2FjaGUgc2l6ZQk6IDUxMiBLQgpwaHlz
aWNhbCBpZAk6IDAKc2libGluZ3MJOiAyCmNvcmUgaWQJCTogMApjcHUgY29yZXMJOiAxCmFwaWNp
ZAkJOiAxCmluaXRpYWwgYXBpY2lkCTogMQpmZGl2X2J1Zwk6IG5vCmhsdF9idWcJCTogbm8KZjAw
Zl9idWcJOiBubwpjb21hX2J1Zwk6IG5vCmZwdQkJOiB5ZXMKZnB1X2V4Y2VwdGlvbgk6IHllcwpj
cHVpZCBsZXZlbAk6IDEwCndwCQk6IHllcwpmbGFncwkJOiBmcHUgdm1lIGRlIHBzZSB0c2MgbXNy
IHBhZSBtY2UgY3g4IGFwaWMgc2VwIG10cnIgcGdlIG1jYSBjbW92IHBhdCBjbGZsdXNoIGR0cyBh
Y3BpIG1teCBmeHNyIHNzZSBzc2UyIHNzIGh0IHRtIHBiZSBueCBjb25zdGFudF90c2MgYXJjaF9w
ZXJmbW9uIHBlYnMgYnRzIHBuaSBkdGVzNjQgbW9uaXRvciBkc19jcGwgdm14IGVzdCB0bTIgc3Nz
ZTMgeHRwciBwZGNtIGxhaGZfbG0gdHByX3NoYWRvdyB2bm1pIGZsZXhwcmlvcml0eQpib2dvbWlw
cwk6IDMxOTEuOTMKY2xmbHVzaCBzaXplCTogNjQKcG93ZXIgbWFuYWdlbWVudDoKCg==
--001636457c72f7d2870468c4e7f4
Content-Type: application/octet-stream; name="proc.ioports"
Content-Disposition: attachment; filename="proc.ioports"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fu5fopjc1

MDAwMC0wMDFmIDogZG1hMQowMDIwLTAwMjEgOiBwaWMxCjAwNDAtMDA0MyA6IHRpbWVyMAowMDUw
LTAwNTMgOiB0aW1lcjEKMDA2MC0wMDYwIDoga2V5Ym9hcmQKMDA2NC0wMDY0IDoga2V5Ym9hcmQK
MDA3MC0wMDcxIDogcnRjMAowMDgwLTAwOGYgOiBkbWEgcGFnZSByZWcKMDBhMC0wMGExIDogcGlj
MgowMGMwLTAwZGYgOiBkbWEyCjAwZjAtMDBmZiA6IGZwdQowMTcwLTAxNzcgOiAwMDAwOjAwOjFm
LjEKICAwMTcwLTAxNzcgOiBwYXRhX3NjaAowMWYwLTAxZjcgOiAwMDAwOjAwOjFmLjEKICAwMWYw
LTAxZjcgOiBwYXRhX3NjaAowMzc2LTAzNzYgOiAwMDAwOjAwOjFmLjEKICAwMzc2LTAzNzYgOiBw
YXRhX3NjaAowM2MwLTAzZGYgOiB2Z2ErCjAzZjYtMDNmNiA6IDAwMDA6MDA6MWYuMQogIDAzZjYt
MDNmNiA6IHBhdGFfc2NoCjA0MDAtMDQzZiA6IHBucCAwMDowNgogIDA0MDAtMDQzZiA6IGlzY2hf
c21idXMKMDQ4MC0wNGJmIDogcG5wIDAwOjA2CjA0ZDAtMDRkMSA6IHBucCAwMDowNgowNjcwLTA2
NzEgOiBkbWUxNzM3CiAgMDY3MC0wNjcxIDogZG1lMTczNwowODEwLTA4MTUgOiBBQ1BJIENQVSB0
aHJvdHRsZQowOTAwLTA5ZjMgOiBwbnAgMDA6MDYKICAwOTAwLTA5MDMgOiBBQ1BJIFBNMWFfRVZU
X0JMSwogIDA5MDQtMDkwNSA6IEFDUEkgUE0xYV9DTlRfQkxLCiAgMDkwOC0wOTBiIDogQUNQSSBQ
TV9UTVIKICAwOTIwLTA5MjAgOiBBQ1BJIFBNMl9DTlRfQkxLCiAgMDljMC0wOWM3IDogQUNQSSBH
UEUwX0JMSwowYTAwLTBhMGYgOiBwbnAgMDA6MDUKMGNmOC0wY2ZmIDogUENJIGNvbmYxCmUwODAt
ZTA5ZiA6IDAwMDA6MDA6MWQuMQogIGUwODAtZTA5ZiA6IHVoY2lfaGNkCmU0ODAtZTQ5ZiA6IDAw
MDA6MDA6MWQuMAogIGU0ODAtZTQ5ZiA6IHVoY2lfaGNkCmU4ODAtZTg4NyA6IDAwMDA6MDA6MDIu
MAplZjAwLWVmMWYgOiAwMDAwOjAwOjFkLjIKICBlZjAwLWVmMWYgOiB1aGNpX2hjZApmZmEwLWZm
YWYgOiAwMDAwOjAwOjFmLjEKICBmZmEwLWZmYWYgOiBwYXRhX3NjaAo=
--001636457c72f7d2870468c4e7f4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--001636457c72f7d2870468c4e7f4--
