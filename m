From: Adam Thompson <athompso@athompso.net>
Date: Thu, 02 Apr 2009 04:17:21 +0000
Subject: [lm-sensors] Tyan S2466 update for kernel 2.6.27 / lm_sensors 3.0.2
Message-Id: <8ce1230f0904012117q78660911y35e064a56ff9fa9@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="000e0cd32d0468f0ef04668ab516"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--000e0cd32d0468f0ef04668ab516
Content-Type: multipart/alternative; boundary=000e0cd32d0468f0e604668ab514

--000e0cd32d0468f0e604668ab514
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The configuration information for a Tyan Tiger MPX S2466-4M motherboard
provided at http://www.tyan.com/archive/support/html/software_utilities.html(direct
link:
ftp://ftp.tyan.com/software/lms/lms_s2466.tgz) does *not* function with
lm_sensors 3.x.
As far as I can tell, the instructions provided cannot have worked at any
point since somewhere late in the 2.x series, notably because the two sensor
chips are now supported by two different modules.

As of Ubuntu 8.10 (lm_sensors 3.0.2, linux kernel 2.6.27) the optimal
configuration for this motherboard with BIOS 4.06 appears to be to load the
two modules in question (w83781d & w83627hf) with the "init=0" module option
and allow the pre-programmed limits to propagate from the BIOS.  Obviously
if anyone has any idea what the various temperature max & hysterisys values
actually should be, they can be programmed into /etc/sensors.conf instead.
I haven't been able to detect any other difference between using "init=1"
and "init=0".

Contrary to Tyan's supplied instructions & config file, no module parameters
at all are required on my system - and presumably this would apply to any
2.6.x kernel, but I'm not about to test that exhaustively.

See attached sensors.conf for a version that actually works (reasonably)
well on my S2466-4M.

(Would some kind soul please create a new ticket in the lm_sensors TRAC
system so the next sucker with one of these doesn't spend an entire evening
figuring this out from scratch again?  Thanks...)

-- 
-Adam Thompson
<athompso@athompso.net>

--000e0cd32d0468f0e604668ab514
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The configuration information for a Tyan Tiger MPX S2466-4M motherboard pro=
vided at <a href=3D"http://www.tyan.com/archive/support/html/software_utili=
ties.html">http://www.tyan.com/archive/support/html/software_utilities.html=
</a> (direct link: <a href=3D"ftp://ftp.tyan.com/software/lms/lms_s2466.tgz=
">ftp://ftp.tyan.com/software/lms/lms_s2466.tgz</a>) does *not* function wi=
th lm_sensors 3.x.<br>
As far as I can tell, the instructions provided cannot have worked at any p=
oint since somewhere late in the 2.x series, notably because the two sensor=
 chips are now supported by two different modules.<br><br>As of Ubuntu 8.10=
 (lm_sensors 3.0.2, linux kernel 2.6.27) the optimal configuration for this=
 motherboard with BIOS 4.06 appears to be to load the two modules in questi=
on (w83781d &amp; w83627hf) with the &quot;init=3D0&quot; module option and=
 allow the pre-programmed limits to propagate from the BIOS.=C2=A0 Obviousl=
y if anyone has any idea what the various temperature max &amp; hysterisys =
values actually should be, they can be programmed into /etc/sensors.conf in=
stead.=C2=A0 I haven&#39;t been able to detect any other difference between=
 using &quot;init=3D1&quot; and &quot;init=3D0&quot;.<br>
<br>Contrary to Tyan&#39;s supplied instructions &amp; config file, no modu=
le parameters at all are required on my system - and presumably this would =
apply to any 2.6.x kernel, but I&#39;m not about to test that exhaustively.=
<br>
<br>See attached sensors.conf for a version that actually works (reasonably=
) well on my S2466-4M.<br><br>(Would some kind soul please create a new tic=
ket in the lm_sensors TRAC system so the next sucker with one of these does=
n&#39;t spend an entire evening figuring this out from scratch again?=C2=A0=
 Thanks...)<br>
<br>-- <br>-Adam Thompson<br> &lt;<a href=3D"mailto:athompso@athompso.net">=
athompso@athompso.net</a>&gt;<br><br>

--000e0cd32d0468f0e604668ab514--

--000e0cd32d0468f0ef04668ab516
Content-Type: application/octet-stream; name="sensors.conf"
Content-Disposition: attachment; filename="sensors.conf"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ft0xl7kd0

IyMjIyMKIyAgICBTZW5zb3JzIGNvbmZpZ3VyYXRpb24gZmlsZSB1c2VkIGJ5ICdsaWJzZW5zb3Jz
JyBmb3IgVHlhbiBTMjQ2Ni00TQojCiMgRWRpdGVkIGJ5OiBrZXZpbiBzY2hsaWNodGVyIDxrZXZp
bnNAdHlhbi5jb20+IDA1LjE2LjAzCiMgVXBkYXRlIDA3LjMwLjAzOmtldmluIHNjaGxpY2h0ZXI6
IGFkZCB2aWQgc3VwcG9ydAojIFVwZGF0ZSAyMDA5LUFwci0wMSBBZGFtIFRob21wc29uIDxhdGhv
bXBzb0BhdGhvbXBzby5uZXQ+OiByYWRpY2FsbHkgCiMgICB1cGRhdGVkIGZvciBsbV9zZW5zb3Jz
IDMuMC4yICYgTGludXgga2VybmVsIDIuNi4yNyAoYWthIFVidW50dSA4LjEwKQojCiMgTm90ZSB0
aGF0IGluIHRoZSAyLjYgc2VyaWVzIG9mIGtlcm5lbHMsIHdpdGggbG1fc2Vuc29ycyAzLjAuMiwg
aXQgaXMKIyBubyBsb25nZXIgbmVjZXNzYXJ5IHRvIGp1bXAgdGhyb3VnaCBmb3JjZV9zdWJjbGll
bnQ9IGFuZCBpZ25vcmVfKiBob29wcwojIHdoZW4gbG9hZGluZyB0aGUgdzgzNzgyZCBtb2R1bGU7
IGl0cyBkZWZhdWx0IGJlaGF2aW91ciBpcyBzdWZmaWNpZW50CiMgdG8gc3VwcG9ydCBpdHNlbGYg
Y29ycmVjdGx5IChhbmQgaXQgZmluZHMgdGhlIDMgc3ViY2xpZW50cyB3aXRob3V0IGFueQojIGFk
ZGl0aW9uYWwgcHJvbXB0aW5nKS4gIFRoaXMgZG9lcyBOT1QgYWxsb3cgYWNjZXNzIHRvIHRoZSBv
dGhlciBjaGlwLAojIGEgVzgzNjI3SEYsIG92ZXIgSTJDLCBidXQgdGhpcyBzZWNvbmQgY2hpcCBp
cyBtYXBwZWQgaW50byB0aGUgSVNBIEkvTyAKIyBzcGFjZSBhbnl3YXksIGFuZCBsb2FkaW5nIHRo
ZSAidzgzNjI3aGYiIG1vZHVsZSB3aXRob3V0IGFueSBvcHRpb25zIAojIGxvY2F0ZXMgaXQgYW5k
IGFjY2Vzc2VzIGl0IHBlcmZlY3RseSBmaW5lLiAgU2VlIGFsc28gbm90ZXMgYmVsb3cgYWJvdXQK
IyB0aGUgaW5hZHZpc2FiaWxpdHkgb2Ygb3ZlcnVzaW5nIHRoZSBJMkMgYnVzIG9uIHRoaXMgbW90
aGVyYm9hcmQgYW55d2F5LgojIFRoaXMgaGFzIG9ubHkgYmVlbiB0ZXN0ZWQgb24gTVkgYm9hcmQs
IHdoaWNoIGlzIHRoZSAtNE0gdmFyaWFudCwgd2l0aAojIEJJT1MgNC4wNi4gIERlcGVuZGluZyBv
biB5b3VyIEJJT1MgdmVyc2lvbiwgeW91IG1heSBvciBtYXkgbm90IHdhbnQgdG8gCiMgdXNlIHRo
ZSAiaW5pdD0wIiBtb2R1bGUgb3B0aW9ucyBJTlNURUFEIE9GIHNldHRpbmcgdmFyaW91cyBtaW5z
ICYgbWF4ZXMgCiMgYmVsb3csIHBhcnRpY3VsYXJseSB0ZW1wZXJhdHVyZS13aXNlLiAgWU1NVi4K
IyAtQWRhbSBUaG9tcHNvbiwgMjAwOS1BcHItMDEKIyMjIyMKCiMgc2V0IG1pbi9tYXggbGltaXRz
IHRvICA1JSBmb3IgdGhlIGNyaXRpY2FsIHZvbHRhZ2VzCiMgc2V0IG1pbi9tYXggbGltaXRzIHRv
IDEwJSBmb3IgdGhlIG5vbi1jcml0aWNhbCB2b2x0YWdlcwojIHNldCBtaW4vbWF4IGxpbWl0cyB0
byAyMCUgZm9yIHRoZSBiYXR0ZXJ5IHZvbHRhZ2UKCgpjaGlwICJ3ODM3ODJkLSoiCiAgICBpZ25v
cmUgIGluMCAKICAgIGlnbm9yZSAgaW4xCiAgICBsYWJlbCAgIGluMiAiQUdQIFYiCiAgICBzZXQg
ICAgIGluMl9taW4gMy4zKjAuOTUKICAgIHNldCAgICAgaW4yX21heCAzLjMqMS4wNQogICAgbGFi
ZWwgICBpbjMgIiArNSBWIgogICAgY29tcHV0ZSBpbjMgKCg2LjgvMTApKzEpKkAgLCAgQC8oKDYu
OC8xMCkrMSkKICAgIHNldCAgICAgaW4zX21pbiA1LjAqMC45NQogICAgc2V0ICAgICBpbjNfbWF4
IDUuMCoxLjA1CiAgICBsYWJlbCAgIGluNCAiRERSIFYiCiAgICBpZ25vcmUgIGluNQogICAgaWdu
b3JlICBpbjcKICAgIGxhYmVsICAgaW42ICIzIFZTQiIKICAgIHNldCAgICAgaW42X21heCAzLjAq
MS4wNQogICAgc2V0ICAgICBpbjZfbWluIDMuMCowLjk1CiAgICBsYWJlbCAgIGluOCAiQmF0IFYi
CiAgICBzZXQgICAgIGluOF9taW4gMy4zKjAuODAKICAgIHNldCAgICAgaW44X21heCAzLjMqMS4y
MAogICAgaWdub3JlICB2aWQKICAgIGxhYmVsICAgZmFuMSAiQ2hhc3NpcyBGYW4gMiIKICAgIGxh
YmVsICAgZmFuMiAiQ2hhc3NpcyBGYW4gMSIKICAgIGxhYmVsICAgZmFuMyAiUFNVIEZhbiIKICAg
IGxhYmVsICAgdGVtcDEgIlZSTTIgVGVtcCIKICAgIGxhYmVsICAgdGVtcDIgIkNQVTEgVGVtcCIK
ICAgIGxhYmVsICAgdGVtcDMgIkNQVTIgVGVtcCIKIyAgICBzZXQgICAgIHRlbXAxX3R5cGUgMgoj
ICAgIHNldCAgICAgdGVtcDFfbWF4IDQwCQojICAgIHNldCAgICAgdGVtcDFfbWF4X2h5c3QgNjAJ
CiMgICAgc2V0ICAgICB0ZW1wMl90eXBlIDIKIyAgICBzZXQgICAgIHRlbXAyX21heCA3MAkKIyAg
ICBzZXQgICAgIHRlbXAyX21heF9oeXN0IDgwCQojICAgIHNldCAgICAgdGVtcDNfdHlwZSAyCiMg
ICAgc2V0ICAgICB0ZW1wM19tYXggNzAJCiMgICAgc2V0ICAgICB0ZW1wM19tYXhfaHlzdCA4MAkK
CiMgbG1fc2Vuc29ycyB0aWNrZXQjMTc5NSAoaHR0cDovL3d3dy5sbS1zZW5zb3JzLm9yZy90aWNr
ZXQvMTc5NSkgYWxzbyAKIyBzdHJvbmdseSBzdWdnZXN0cyB1c2luZyB0aGUgSVNBIGJ1cyB3aGVy
ZSBwb3NzaWJsZSB0byBhdm9pZCBvdmVybG9hZGluZwojIHRoZSBTTUJ1cyBvbiBUeWFuIG1vdGhl
cmJvYXJkcy4KIyBBY2Nlc3NpbmcgdGhpcyB2aWEgSVNBIGluYi9vdXRiIGFsc28gYXZvaWRzIHRo
ZSBuZWVkIGFsdG9nZXRoZXIgdG8gdXNlCiMgZm9yY2Vfc3ViY2xpZW50PSBvcHRpb25zIHdoZW4g
bG9hZGluZyB0aGUgdzgzNzgyZCBtb2R1bGUuCgpjaGlwICJ3ODM2MjdoZi0qIgogICAgbGFiZWwg
ICBpbjAgIlZDb3JlMSIKICAgIHNldCAgICAgaW4wX21pbiBjcHUwX3ZpZCowLjk1CiAgICBzZXQg
ICAgIGluMF9tYXggY3B1MF92aWQqMS4wNQogICAgbGFiZWwgICBpbjEgIlZDb3JlMiIKICAgIHNl
dCAgICAgaW4xX21pbiBjcHUwX3ZpZCowLjk1CiAgICBzZXQgICAgIGluMV9tYXggY3B1MF92aWQq
MS4wNQogICAgbGFiZWwgICBpbjIgIiszLjMgViIKICAgIHNldCAgICAgaW4yX21pbiAzLjMqMC45
NQogICAgc2V0ICAgICBpbjJfbWF4IDMuMyoxLjA1CiAgICBpZ25vcmUgIGluMwogICAgbGFiZWwg
ICBpbjQgIiArMTIgViIKICAgIGNvbXB1dGUgaW40ICgoMy44LzEpKzEpKkAgLCBALygoMy44LzEp
KzEpCiAgICBzZXQgICAgIGluNF9tYXggMTIqMC45MAogICAgc2V0ICAgICBpbjRfbWluIDEyKjEu
MTAKICAgIGxhYmVsICAgaW41ICIgLTEyIFYiCiAgICBjb21wdXRlIGluNSAoNS4xNCpAKS0xNC45
MSAsIChAKzE0LjkxKS81LjE0CiAgICBzZXQgICAgIGluNV9tYXggLTEyKjAuOTAKICAgIHNldCAg
ICAgaW41X21pbiAtMTIqMS4xMAogICAgaWdub3JlICBpbjYKICAgIGlnbm9yZSAgaW43CiAgICBp
Z25vcmUgIGluOAogICAgaWdub3JlICB2aWQKICAgIGxhYmVsICAgdGVtcDEgIlZSTTEgVGVtcCIK
ICAgIGxhYmVsICAgdGVtcDIgIkFHUCBUZW1wIgogICAgbGFiZWwgICB0ZW1wMyAiRERSIFRlbXAi
CiAgICBsYWJlbCAgIGZhbjEgIkNQVTEgRmFuIgogICAgbGFiZWwgICBmYW4yICJDUFUyIEZhbiIK
ICAgIGlnbm9yZSAgZmFuMyAKIyAgICBzZXQgICAgIHRlbXAxX3R5cGUgMgojICAgIHNldCAgICAg
dGVtcDFfbWF4IDQwCiMgICAgc2V0ICAgICB0ZW1wMV9tYXhfaHlzdCAzNwojICAgIHNldCAgICAg
dGVtcDJfdHlwZSAyCiMgICAgc2V0ICAgICB0ZW1wMl9tYXggNTIKIyAgICBzZXQgICAgIHRlbXAy
X21heF9oeXN0IDQ3CiMgICAgc2V0ICAgICB0ZW1wM190eXBlIDIKIyAgICBzZXQgICAgIHRlbXAz
X21heCA1MgojICAgIHNldCAgICAgdGVtcDNfbWF4X2h5c3QgNDcKICAgIHNldCAgICAgYmVlcF9l
bmFibGUgMAoK
--000e0cd32d0468f0ef04668ab516
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--000e0cd32d0468f0ef04668ab516--
