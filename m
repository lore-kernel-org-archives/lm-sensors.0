From: =?ISO-8859-1?Q?Kristleifur_Da=F0ason?= <kristleifur@gmail.com>
Date: Mon, 18 Oct 2010 18:58:30 +0000
Subject: Re: [lm-sensors] Writing a .conf for Supermicro X8DTH-6F board
Message-Id: <AANLkTinzAHa--zzK+OmDCc6nXb+-UuYPTYgE7GnRPFUd@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="000e0cd29c8e6dbc010492e8c450"
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=7hV6DxhkeMUF9Bu87g78uRUsdPuL1RCQxiYY9@mail.gmail.com>
In-Reply-To: <AANLkTi=7hV6DxhkeMUF9Bu87g78uRUsdPuL1RCQxiYY9@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--000e0cd29c8e6dbc010492e8c450
Content-Type: multipart/alternative; boundary=000e0cd29c8e6dbbf20492e8c44e

--000e0cd29c8e6dbbf20492e8c44e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Certainly!

Looking at the config for the C7X58 board, the overall setup seems to be
different.

2010/10/18 Henrique de Moraes Holschuh <hmh@hmh.eng.br>

> On Mon, 18 Oct 2010, Kristleifur Da=C4=91ason wrote:
> > Here's an excerpt from the specifications file:
>
> Please send us the entire file, so that I can compare it with the one for
> the C7X58 (which uses the same sensor chip).
>
> --
>  "One disk to rule them all, One disk to find them. One disk to bring
>  them all and in the darkness grind them. In the Land of Redmond
>  where the shadows lie." -- The Silicon Valley Tarot
>  Henrique Holschuh
>

--000e0cd29c8e6dbbf20492e8c44e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Certainly!<div><br></div><div>Looking at the config for the C7X58 board, th=
e overall setup seems to be different.</div><div><div><br><div class=3D"gma=
il_quote">2010/10/18 Henrique de Moraes Holschuh <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:hmh@hmh.eng.br">hmh@hmh.eng.br</a>&gt;</span><br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On Mon, 18 Oct 2010, Kris=
tleifur Da=C4=91ason wrote:<br>
&gt; Here&#39;s an excerpt from the specifications file:<br>
<br>
</div>Please send us the entire file, so that I can compare it with the one=
 for<br>
the C7X58 (which uses the same sensor chip).<br>
<div><div></div><div class=3D"h5"><br>
--<br>
 =C2=A0&quot;One disk to rule them all, One disk to find them. One disk to =
bring<br>
 =C2=A0them all and in the darkness grind them. In the Land of Redmond<br>
 =C2=A0where the shadows lie.&quot; -- The Silicon Valley Tarot<br>
 =C2=A0Henrique Holschuh<br>
</div></div></blockquote></div><br></div></div>

--000e0cd29c8e6dbbf20492e8c44e--

--000e0cd29c8e6dbc010492e8c450
Content-Type: text/plain; charset=US-ASCII; name="X8DTH.txt"
Content-Disposition: attachment; filename="X8DTH.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gffpk1jx0

QnVzIFR5cGUgPSBJU0FJTy9TTUJ1cw0KT25lIFc4Mzc5NUFHDQoNCldpbmRib25kIFc4Mzc5NUFH
LCBTbGF2ZSBBZGRyZXNzPTB4MmYgKDB4NUUgaW4gOC1CaXQgZm9ybWF0KQ0KPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KRmFuMSBG
YW4gU3BlZWQsIE9mZnNldCAweDJlCQlSUE0gPSA4NDM3NS9EYXRhDQpGYW4yIEZhbiBTcGVlZCwg
T2Zmc2V0IDB4MmYJCVJQTSA9IDg0Mzc1L0RhdGENCkZhbjMgRmFuIFNwZWVkLCBPZmZzZXQgMHgz
MAkJUlBNID0gODQzNzUvRGF0YQ0KRmFuNCBGYW4gU3BlZWQsIE9mZnNldCAweDMxCQlSUE0gPSA4
NDM3NS9EYXRhDQpGYW41IEZhbiBTcGVlZCwgT2Zmc2V0IDB4MzIJCVJQTSA9IDg0Mzc1L0RhdGEN
CkZhbjYgRmFuIFNwZWVkLCBPZmZzZXQgMHgzMwkJUlBNID0gODQzNzUvRGF0YQ0KRmFuNyBGYW4g
U3BlZWQsIE9mZnNldCAweDM0CQlSUE0gPSA4NDM3NS9EYXRhDQpGYW44IEZhbiBTcGVlZCwgT2Zm
c2V0IDB4MzUJCVJQTSA9IDg0Mzc1L0RhdGENCkNQVTEgVm9sdGFnZSwgT2Zmc2V0IDB4MTAJCVZv
bHRhZ2UgPSBEYXRhKiAwLjAwOA0KQ1BVMiBWb2x0YWdlLCBPZmZzZXQgMHgxMQkJVm9sdGFnZSA9
IERhdGEqIDAuMDA4DQpDUFUxIERJTU0gVm9sdGFnZSwgT2Zmc2V0IDB4MTMJCVZvbHRhZ2UgPSBE
YXRhKiAwLjAwOA0KQ1BVMiBESU1NIFZvbHRhZ2UsIE9mZnNldCAweDE0CQlWb2x0YWdlID0gRGF0
YSogMC4wMDgNCkNQVTEgVlRUIFZvbHRhZ2UsIE9mZnNldCAweDFiCQlWb2x0YWdlID0gRGF0YSog
MC4wMDgNCkNQVTIgVlRUIFZvbHRhZ2UsIE9mZnNldCAweDEyCQlWb2x0YWdlID0gRGF0YSogMC4w
MDgNCisxLjVWIFZvbHRhZ2UsIE9mZnNldCAweDE2CQlWb2x0YWdlID0gRGF0YSogMC4wMDgNCisx
LjhWIFZvbHRhZ2UsIE9mZnNldCAweDE3CQlWb2x0YWdlID0gRGF0YSogMC4wMDgNCis1ViBWb2x0
YWdlLCBPZmZzZXQgMHgxZgkJVm9sdGFnZSA9IERhdGEqIDAuMDA4ICogKDQwLzEwKQ0KKzEyViBW
b2x0YWdlLCBPZmZzZXQgMHgyMAkJVm9sdGFnZSA9IERhdGEqIDAuMDA4LyAoMTAuLzY2LjIpDQor
MS4xViBWb2x0YWdlLCBPZmZzZXQgMHgxNQkJVm9sdGFnZSA9IERhdGEqIDAuMDA4DQorMy4zViBW
b2x0YWdlLCBPZmZzZXQgMHgxYwkJVm9sdGFnZSA9IERhdGEqIDAuMDI0DQorMy4zVlNCIFZvbHRh
Z2UsIE9mZnNldCAweDFkCQlWb2x0YWdlID0gRGF0YSogMC4wMjQNCkJhdHRlcnkgVm9sdGFnZSwg
T2Zmc2V0IDB4MWUJCVZvbHRhZ2UgPSBEYXRhKiAwLjAyNA0KQ1BVMSBUZW1wZXJhdHVyZSwgT2Zm
c2V0IDB4MjcJCVRlbXBlcmF0dXJlID0gRGF0YQ0KQ1BVMiBUZW1wZXJhdHVyZSwgT2Zmc2V0IDB4
MjYJCVRlbXBlcmF0dXJlID0gRGF0YQ0KU3lzdGVtIFRlbXBlcmF0dXJlLCBPZmZzZXQgMHgyMQkJ
VGVtcGVyYXR1cmUgPSBEYXRhDQpDaGFzc2lzIEludHJ1c2lvbiwgQmFuayAwLCBPZmZzZXQgMHg0
NiwgQml0TWFzayAweDQwCTEgPSBCYWQsIDAgPSBHb29kDQoJCQkoQ2xlYXIgQml0OiBCYW5rIDAs
IE9mZnNldCAweDRkLCBCaXRNYXNrIDB4ODApDQoNCg0KUG93ZXIgU3VwcGx5IEZhaWx1cmUsIEdQ
MjEoRnJvbSBXODM1MjdIRykJCTEgPSBHb29kLCAwID0gQmFk
--000e0cd29c8e6dbc010492e8c450
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--000e0cd29c8e6dbc010492e8c450--
