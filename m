From: Steve.Glendinning@smsc.com
Date: Fri, 13 May 2011 12:59:45 +0000
Subject: Re: [lm-sensors] [PATCH] Document existing support for SMSC EMC2300
Message-Id: <OF765AC631.0AA1773F-ONC125788F.00476376-C125788F.004763BD@smsc.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305037288-16695-1-git-send-email-steve.glendinning@smsc.com>
In-Reply-To: <1305037288-16695-1-git-send-email-steve.glendinning@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

--=_mixed 004763B6C125788F_MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<FONT face="Default Sans Serif,Verdana,Arial,Helvetica,sans-serif" size=2><DIV>Hi Jean,<BR><DIV>&nbsp;</DIV><DIV>&gt;Ah,&nbsp;I&nbsp;get&nbsp;it.&nbsp;On&nbsp;this&nbsp;dump, <BR>&gt;monitoring&nbsp;isn't&nbsp;enabled&nbsp;(bit&nbsp;0&nbsp;of&nbsp;register&nbsp;0x40&nbsp;is&nbsp;0). <BR>&gt; <BR>&gt;Steve,&nbsp;can&nbsp;you&nbsp;please&nbsp;enable&nbsp;monitoring&nbsp;and&nbsp;provide&nbsp;a&nbsp;new&nbsp;dump? <BR></DIV><DIV>Sorry!&nbsp; Hopefully this one is more useful:</DIV><DIV>&nbsp;</DIV><DIV><A href="mailto:root@mustafa" target=blank>root@mustafa</A>:~# i2cdump 3 0x2e b<BR>WARNING! This program can confuse your I2C bus, cause data loss and worse!<BR>I will probe file /dev/i2c-3, address 0x2e, mode byte<BR>Continue? [Y/n] <BR>&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; 1&nbsp; 2&nbsp; 3&nbsp; 4&nbsp; 5&nbsp; 6&nbsp; 7&nbsp; 8&nbsp; 9&nbsp; a&nbsp; b&nbsp; c&nbsp; d&nbsp; e&nbsp; f&nbsp;&nbsp;&nbsp; 0123456789abcdef<BR>00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<BR>10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<BR>20: 00 92 c2 00 00 17 18 17 07 03 ff ff ff ff ff ff&nbsp;&nbsp;&nbsp; .??..?????......<BR>30: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 5c 6a&nbsp;&nbsp;&nbsp; ..............\j<BR>40: 05 89 01 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f&nbsp;&nbsp;&nbsp; ???...........??<BR>50: 81 7f 81 7f ff ff ff ff ff ff ff ff 62 62 62 c3&nbsp;&nbsp;&nbsp; ????........bbb?<BR>60: c3 c3 e0 00 80 80 80 80 80 80 64 64 64 44 40 00&nbsp;&nbsp;&nbsp; ???.??????dddD@.<BR>70: ff ff ff 09 09 09 09 07 07 00 30 00 40 00 ec 10&nbsp;&nbsp;&nbsp; ...??????.0.@.??<BR>80: 1e a4 0e 00 00 08 03 00 35 00 57 57 0b 0b 0c 00&nbsp;&nbsp;&nbsp; ???..??.5.WW???.<BR>90: 04 04 04 04 0c 0c 0c 5a f1 00 00 00 23 00 00 00&nbsp;&nbsp;&nbsp; ???????Z?...#...<BR>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<BR>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<BR>c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<BR>d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<BR>e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<BR>f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................</DIV><DIV>&nbsp;</DIV><DIV>Steve</DIV></DIV></FONT>
--=_mixed 004763B6C125788F_Content-Type: application/octet-stream; name="i2cdump-active.txt"
Content-Disposition: attachment; filename="i2cdump-active.txt"
Content-Transfer-Encoding: base64

cm9vdEBtdXN0YWZhOn4jIGkyY2R1bXAgMyAweDJlIGIKV0FSTklORyEgVGhpcyBwcm9ncmFtIGNh
biBjb25mdXNlIHlvdXIgSTJDIGJ1cywgY2F1c2UgZGF0YSBsb3NzIGFuZCB3b3JzZSEKSSB3aWxs
IHByb2JlIGZpbGUgL2Rldi9pMmMtMywgYWRkcmVzcyAweDJlLCBtb2RlIGJ5dGUKQ29udGludWU/
IFtZL25dIAogICAgIDAgIDEgIDIgIDMgIDQgIDUgIDYgIDcgIDggIDkgIGEgIGIgIGMgIGQgIGUg
IGYgICAgMDEyMzQ1Njc4OWFiY2RlZgowMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgICAgLi4uLi4uLi4uLi4uLi4uLgoxMDogMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgICAgLi4uLi4uLi4uLi4uLi4uLgoyMDog
MDAgOTIgYzIgMDAgMDAgMTcgMTggMTcgMDcgMDMgZmYgZmYgZmYgZmYgZmYgZmYgICAgLj8/Li4/
Pz8/Py4uLi4uLgozMDogZmYgZmYgZmYgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
NWMgNmEgICAgLi4uLi4uLi4uLi4uLi5cago0MDogMDUgODkgMDEgMDAgMDAgZmYgMDAgZmYgMDAg
ZmYgMDAgZmYgMDAgZmYgODEgN2YgICAgPz8/Li4uLi4uLi4uLi4/Pwo1MDogODEgN2YgODEgN2Yg
ZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgNjIgNjIgNjIgYzMgICAgPz8/Py4uLi4uLi4uYmJiPwo2
MDogYzMgYzMgZTAgMDAgODAgODAgODAgODAgODAgODAgNjQgNjQgNjQgNDQgNDAgMDAgICAgPz8/
Lj8/Pz8/P2RkZERALgo3MDogZmYgZmYgZmYgMDkgMDkgMDkgMDkgMDcgMDcgMDAgMzAgMDAgNDAg
MDAgZWMgMTAgICAgLi4uPz8/Pz8/LjAuQC4/Pwo4MDogMWUgYTQgMGUgMDAgMDAgMDggMDMgMDAg
MzUgMDAgNTcgNTcgMGIgMGIgMGMgMDAgICAgPz8/Li4/Py41LldXPz8/Lgo5MDogMDQgMDQgMDQg
MDQgMGMgMGMgMGMgNWEgZjEgMDAgMDAgMDAgMjMgMDAgMDAgMDAgICAgPz8/Pz8/P1o/Li4uIy4u
LgphMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgICAg
Li4uLi4uLi4uLi4uLi4uLgpiMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgICAgLi4uLi4uLi4uLi4uLi4uLgpjMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgICAgLi4uLi4uLi4uLi4uLi4uLgpkMDogMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgICAgLi4uLi4uLi4uLi4u
Li4uLgplMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
ICAgLi4uLi4uLi4uLi4uLi4uLgpmMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgICAgLi4uLi4uLi4uLi4uLi4uLgoK

--=_mixed 004763B6C125788F_Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=_mixed 004763B6C125788F_=--
