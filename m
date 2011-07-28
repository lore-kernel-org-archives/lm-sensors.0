From: Suyu Zhang <coolbeet@gmail.com>
Date: Thu, 28 Jul 2011 18:48:00 +0000
Subject: Re: [lm-sensors] want memory temperature(i5k_amb),
Message-Id: <CAOfki7CDeNKSqi6uNTeeiatULcYn4E6mbh9F8uhgtRmwL9i+mg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="001517476a70a9235504a9259abb"
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOfki7BChsVD09-EKKKG+tkmjAysXqQTO98XDZqxjmdRPh=sag@mail.gmail.com>
In-Reply-To: <CAOfki7BChsVD09-EKKKG+tkmjAysXqQTO98XDZqxjmdRPh=sag@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--001517476a70a9235504a9259abb
Content-Type: multipart/alternative; boundary=001517476a70a9234504a9259ab9

--001517476a70a9234504a9259ab9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi, that two files is as attached, Thank you so much, the author of i5k_amb
said:

*"Error -16 means that the memory regions that contain the temperature info
that
the i5kamb driver reads are busy, which means that there's some other drive=
r
already claiming ownership of the AMB temperature data.  Most likely it's
the
SMC or something that's monitoring AMB temperature.  You could send me the
contents of /proc/meminfo if you want to try to confirm that, but I suspect
you'll have to get DIMM temperature info from the applesmc driver."*

then he replied:
*=E2=80=9CHmm, that looks ok; can you send me the contents of /proc/iomem a=
s well?
*
*
I suspect you might see a line that looks something like:
fe000000-fe01ffff : reserved

On my system I get:
fe000000-fe01ffff : i5k_amb

If you see reserved (or really, anything that isn't i5k_amb) then most
likely
the BIOS has declared the AMB memory region "off-limits" and you won't be
able
to load i5k-amb without extreme measures.

(Extreme measures means disabling the kernel's standard mechanisms for
preventing two pieces of code from trying to own the same piece of hardware=
.
Not recommended.)

> and also I found error info from dmesg for applesmc:
>
>  applesmc: supported laptop not found!
>  applesmc: driver init failed (ret=3D-19)!

Ugh, applesmc doesn't seem to support Xserves. :(

I guess you could try asking the applesmc author if he/she has any patches
to
*
*make it work for xserve.=E2=80=9C*

Thank you so much~

On Sun, Jul 24, 2011 at 1:42 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Adding the driver author in Cc.
>
> On Sat, 23 Jul 2011 23:57:27 -0500, Suyu Zhang wrote:
> > my chipset is intel 5000 and I got error info from dmesg=EF=BC=9A
> > i5k_amb: probe of i5k_amb.0 failed with error -16
>
> Please provide the outputs of:
> * cat /proc/iomem
> * lspci -d 8086:25F0 -v -xxx
>
> The i5k_amb driver could certainly be made a little bit more verbose on
> errors for easier diagnostics.
>
> --
> Jean Delvare
>



--=20
Suyu Zhang
Electrical and Computer Engineering
University of Illinois at Chicago
phone: (+1) 312-810-6072
google voice: (+1) 773-SUYU-214
website: http://suyu.us
szhang33@uic.edu

--001517476a70a9234504a9259ab9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<span class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-f=
amily: arial, sans-serif; font-size: 13px; "><div class=3D"im">Hi, that two=
 files is as attached, Thank you so much, the author of i5k_amb said:<div><=
br>
</div><div><b>&quot;Error -16 means that the memory regions that contain th=
e temperature info that<br>the i5kamb driver reads are busy, which means th=
at there&#39;s some other driver<br>already claiming ownership of the AMB t=
emperature data. =C2=A0Most likely it&#39;s the<br>
SMC or something that&#39;s monitoring AMB temperature. =C2=A0You could sen=
d me the<br>contents of /proc/meminfo if you want to try to confirm that, b=
ut I suspect<br>you&#39;ll have to get DIMM temperature info from the apple=
smc driver.&quot;</b><br>
<br></div></div><div>then he=C2=A0replied:</div><span style=3D"border-colla=
pse: collapse; font-family: arial, sans-serif; font-size: 13px; "><b>=E2=80=
=9CHmm, that looks ok; can you send me the contents of /proc/iomem as well?=
<br></b></span><div class=3D"im">
<span style=3D"border-collapse: collapse; font-family: arial, sans-serif; f=
ont-size: 13px; "><b><br>I suspect you might see a line that looks somethin=
g like:<br>fe000000-fe01ffff : reserved<br><br>On my system I get:<br>fe000=
000-fe01ffff : i5k_amb<br>
<br>If you see reserved (or really, anything that isn&#39;t i5k_amb) then m=
ost likely<br>the BIOS has declared the AMB memory region &quot;off-limits&=
quot; and you won&#39;t be able<br>to load i5k-amb without extreme measures=
.<br>
<br>(Extreme measures means disabling the kernel&#39;s standard mechanisms =
for<br>preventing two pieces of code from trying to own the same piece of h=
ardware.<br>Not recommended.)<br><div><br>&gt; and also I found error info =
from dmesg for applesmc:<br>
&gt;<br>&gt; =C2=A0applesmc: supported laptop not found!<br>&gt; =C2=A0appl=
esmc: driver init failed (ret=3D-19)!<br><br></div>Ugh, applesmc doesn&#39;=
t seem to support Xserves. :(<br><br>I guess you could try asking the apple=
smc author if he/she has any patches to<br>
</b></span></div><div><span style=3D"border-collapse: collapse; font-family=
: arial, sans-serif; font-size: 13px; "><b>make it work for xserve.=E2=80=
=9C</b></span></div><div><br></div><div>Thank you so much~</div></span><br>=
<div class=3D"gmail_quote">
On Sun, Jul 24, 2011 at 1:42 AM, Jean Delvare <span dir=3D"ltr">&lt;<a href=
=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">
Adding the driver author in Cc.<br>
<div class=3D"im"><br>
On Sat, 23 Jul 2011 23:57:27 -0500, Suyu Zhang wrote:<br>
&gt; my chipset is intel 5000 and I got error info from dmesg=EF=BC=9A<br>
&gt; i5k_amb: probe of i5k_amb.0 failed with error -16<br>
<br>
</div>Please provide the outputs of:<br>
* cat /proc/iomem<br>
* lspci -d 8086:25F0 -v -xxx<br>
<br>
The i5k_amb driver could certainly be made a little bit more verbose on<br>
errors for easier diagnostics.<br>
<br>
--<br>
<font color=3D"#888888">Jean Delvare<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br><span style=3D"f=
ont-family:arial, sans-serif;font-size:13px;border-collapse:collapse">Suyu =
Zhang<br>Electrical and Computer Engineering<br>University of Illinois at C=
hicago=C2=A0=C2=A0</span><div>
<span style=3D"font-family:arial, sans-serif;font-size:13px;border-collapse=
:collapse">phone: (+1) 312-810-6072</span></div><div><span style=3D"font-fa=
mily:arial, sans-serif;font-size:13px;border-collapse:collapse">google voic=
e: (+1) 773-SUYU-214</span></div>
<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><span style=3D"border-collapse:separate;font-family:arial"><span style=
=3D"font-family:arial, sans-serif;font-size:13px;border-collapse:collapse">=
website:=C2=A0</span><a href=3D"http://suyu.us/" target=3D"_blank">http://s=
uyu.us</a></span></span></font></div>
<div><span style=3D"font-family:arial, sans-serif;font-size:13px;border-col=
lapse:collapse"><a href=3D"mailto:szhang33@uic.edu" target=3D"_blank">szhan=
g33@uic.edu</a></span></div><br>

--001517476a70a9234504a9259ab9--

--001517476a70a9235504a9259abb
Content-Type: application/octet-stream; name=iomem
Content-Disposition: attachment; filename=iomem
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gqo2sm5p0

MDAwMDAwMDAtMDAwMGZmZmYgOiByZXNlcnZlZAowMDAxMDAwMC0wMDA4ZWZmZiA6IFN5c3RlbSBS
QU0KMDAwOGYwMDAtMDAwOGZmZmYgOiBBQ1BJIE5vbi12b2xhdGlsZSBTdG9yYWdlCjAwMDkwMDAw
LTAwMDlmZmZmIDogU3lzdGVtIFJBTQowMDBhMDAwMC0wMDBiZmZmZiA6IFBDSSBCdXMgMDAwMDow
MAogIDAwMGEwMDAwLTAwMGJmZmZmIDogcmVzZXJ2ZWQKMDAxMDAwMDAtN2VhZDRmZmYgOiBTeXN0
ZW0gUkFNCiAgMDEwMDAwMDAtMDE1OTc4OTIgOiBLZXJuZWwgY29kZQogIDAxNTk3ODkzLTAxYWQ2
YzRmIDogS2VybmVsIGRhdGEKICAwMWJjMzAwMC0wMWQ2M2E1MyA6IEtlcm5lbCBic3MKN2VhZDUw
MDAtN2VhZDhmZmYgOiBBQ1BJIFRhYmxlcwo3ZWFkOTAwMC03ZWFkOWZmZiA6IFN5c3RlbSBSQU0K
N2VhZGEwMDAtN2VhZTBmZmYgOiBBQ1BJIFRhYmxlcwo3ZWFlMTAwMC03ZWFlMmZmZiA6IFN5c3Rl
bSBSQU0KN2VhZTMwMDAtN2VhZWZmZmYgOiBBQ1BJIFRhYmxlcwo3ZWFmMDAwMC03ZWFmMGZmZiA6
IFN5c3RlbSBSQU0KN2VhZjEwMDAtN2VhZjZmZmYgOiBBQ1BJIFRhYmxlcwo3ZWFmNzAwMC03ZWFm
Y2ZmZiA6IFN5c3RlbSBSQU0KN2VhZmQwMDAtN2ViMDVmZmYgOiBBQ1BJIFRhYmxlcwo3ZWIwNjAw
MC03ZWIxMGZmZiA6IFN5c3RlbSBSQU0KN2ViMTEwMDAtN2ViMTFmZmYgOiBBQ1BJIE5vbi12b2xh
dGlsZSBTdG9yYWdlCjdlYjEyMDAwLTdlYjEyZmZmIDogU3lzdGVtIFJBTQo3ZWIxMzAwMC03ZWIx
M2ZmZiA6IEFDUEkgVGFibGVzCjdlYjE0MDAwLTdlYjI1ZmZmIDogQUNQSSBOb24tdm9sYXRpbGUg
U3RvcmFnZQo3ZWIyNjAwMC03ZWIzZWZmZiA6IHJlc2VydmVkCjdlYjNmMDAwLTdlYmY4ZmZmIDog
U3lzdGVtIFJBTQo3ZWJmOTAwMC03ZWMwMGZmZiA6IEFDUEkgTm9uLXZvbGF0aWxlIFN0b3JhZ2UK
N2VjMDEwMDAtN2VjMDlmZmYgOiBTeXN0ZW0gUkFNCjdlYzBhMDAwLTdlYzBhZmZmIDogcmVzZXJ2
ZWQKN2VjMGIwMDAtN2VjMTBmZmYgOiBTeXN0ZW0gUkFNCjdlYzExMDAwLTdlYzExZmZmIDogVW51
c2FibGUgbWVtb3J5CjdlYzEyMDAwLTdlYzEyZmZmIDogQUNQSSBUYWJsZXMKN2VjMTMwMDAtN2Vj
MTVmZmYgOiBVbnVzYWJsZSBtZW1vcnkKN2VjMTYwMDAtN2VjMTZmZmYgOiByZXNlcnZlZAo3ZWMx
NzAwMC03ZWMxN2ZmZiA6IFVudXNhYmxlIG1lbW9yeQo3ZWMxODAwMC03ZWMxYWZmZiA6IFN5c3Rl
bSBSQU0KN2VjMWIwMDAtN2VjMjlmZmYgOiBBQ1BJIE5vbi12b2xhdGlsZSBTdG9yYWdlCjdlYzJh
MDAwLTdlYzMzZmZmIDogU3lzdGVtIFJBTQo3ZWMzNDAwMC03ZWMzNGZmZiA6IHJlc2VydmVkCjdl
YzM1MDAwLTdlYzM2ZmZmIDogQUNQSSBOb24tdm9sYXRpbGUgU3RvcmFnZQo3ZWMzNzAwMC03ZWMz
YmZmZiA6IFN5c3RlbSBSQU0KN2VjM2MwMDAtN2VjM2NmZmYgOiBBQ1BJIE5vbi12b2xhdGlsZSBT
dG9yYWdlCjdlYzNkMDAwLTdlYzVmZmZmIDogU3lzdGVtIFJBTQo3ZWM2MDAwMC03ZWNlMGZmZiA6
IEFDUEkgTm9uLXZvbGF0aWxlIFN0b3JhZ2UKN2VjZTEwMDAtN2VjZmZmZmYgOiBTeXN0ZW0gUkFN
CjdlZDAwMDAwLTdlZDAxZmZmIDogQUNQSSBOb24tdm9sYXRpbGUgU3RvcmFnZQo3ZWQwMjAwMC03
ZWQ0OWZmZiA6IFN5c3RlbSBSQU0KN2VkNGEwMDAtN2VkNGFmZmYgOiByZXNlcnZlZAo3ZWQ0YjAw
MC03ZWRmYmZmZiA6IFN5c3RlbSBSQU0KN2VkZmMwMDAtN2VkZmNmZmYgOiByZXNlcnZlZAo3ZWRm
ZDAwMC03ZWRmZGZmZiA6IFN5c3RlbSBSQU0KN2VkZmUwMDAtN2VlMDhmZmYgOiBBQ1BJIE5vbi12
b2xhdGlsZSBTdG9yYWdlCjdlZTA5MDAwLTdlZWRlZmZmIDogU3lzdGVtIFJBTQo3ZWVkZjAwMC03
ZWVkZmZmZiA6IHJlc2VydmVkCjdlZWUwMDAwLTdlZWU1ZmZmIDogU3lzdGVtIFJBTQo3ZWVlNjAw
MC03ZWVlNmZmZiA6IHJlc2VydmVkCjdlZWU3MDAwLTdmMTZmZmZmIDogU3lzdGVtIFJBTQo3ZjE3
MDAwMC03ZjE3MWZmZiA6IFVudXNhYmxlIG1lbW9yeQo3ZjE3MjAwMC03ZjE3NGZmZiA6IFN5c3Rl
bSBSQU0KN2YxNzUwMDAtN2YxNzVmZmYgOiByZXNlcnZlZAo3ZjE3NjAwMC03ZjE4MGZmZiA6IFN5
c3RlbSBSQU0KN2YxODEwMDAtN2YxODFmZmYgOiBBQ1BJIFRhYmxlcwo3ZjE4MjAwMC03ZjE4NmZm
ZiA6IFN5c3RlbSBSQU0KN2YxODcwMDAtN2YxODhmZmYgOiBVbnVzYWJsZSBtZW1vcnkKN2YxODkw
MDAtN2YxOGZmZmYgOiBTeXN0ZW0gUkFNCjdmMTkwMDAwLTdmMTlmZmZmIDogQUNQSSBOb24tdm9s
YXRpbGUgU3RvcmFnZQo3ZjFhMDAwMC03ZjFhYmZmZiA6IFN5c3RlbSBSQU0KN2YxYWMwMDAtN2Yx
YjBmZmYgOiBBQ1BJIE5vbi12b2xhdGlsZSBTdG9yYWdlCjdmMWIxMDAwLTdmMWIzZmZmIDogU3lz
dGVtIFJBTQo3ZjFiNDAwMC03ZjFiNGZmZiA6IHJlc2VydmVkCjdmMWI1MDAwLTdmMWJmZmZmIDog
U3lzdGVtIFJBTQo3ZjFjMDAwMC03ZjFjMmZmZiA6IEFDUEkgTm9uLXZvbGF0aWxlIFN0b3JhZ2UK
N2YxYzMwMDAtN2YyMTlmZmYgOiBTeXN0ZW0gUkFNCjdmMjFhMDAwLTdmMjFhZmZmIDogVW51c2Fi
bGUgbWVtb3J5CjdmMjFiMDAwLTdmMjJjZmZmIDogcmVzZXJ2ZWQKN2YyMmQwMDAtN2YyNDVmZmYg
OiBTeXN0ZW0gUkFNCjdmMjQ2MDAwLTdmMjQ2ZmZmIDogcmVzZXJ2ZWQKN2YyNDcwMDAtN2YyNDdm
ZmYgOiBTeXN0ZW0gUkFNCjdmMjQ4MDAwLTdmMjQ5ZmZmIDogVW51c2FibGUgbWVtb3J5CjdmMjRh
MDAwLTdmMjRkZmZmIDogU3lzdGVtIFJBTQo3ZjI0ZTAwMC03ZjI0ZWZmZiA6IHJlc2VydmVkCjdm
MjRmMDAwLTdmMjRmZmZmIDogU3lzdGVtIFJBTQo3ZjI1MDAwMC03ZjI1MWZmZiA6IEFDUEkgTm9u
LXZvbGF0aWxlIFN0b3JhZ2UKN2YyNTIwMDAtN2YyNjZmZmYgOiBTeXN0ZW0gUkFNCjdmMjY3MDAw
LTdmMjY3ZmZmIDogVW51c2FibGUgbWVtb3J5CjdmMjY4MDAwLTdmMjZiZmZmIDogU3lzdGVtIFJB
TQo3ZjI2YzAwMC03ZjI3Y2ZmZiA6IHJlc2VydmVkCjdmMjdkMDAwLTdmMjdkZmZmIDogU3lzdGVt
IFJBTQo3ZjI3ZTAwMC03ZjI4NWZmZiA6IEFDUEkgTm9uLXZvbGF0aWxlIFN0b3JhZ2UKN2YyODYw
MDAtN2YyODhmZmYgOiBVbnVzYWJsZSBtZW1vcnkKN2YyODkwMDAtN2YyOGVmZmYgOiBTeXN0ZW0g
UkFNCjdmMjhmMDAwLTdmMjhmZmZmIDogcmVzZXJ2ZWQKN2YyOTAwMDAtN2Y2YmNmZmYgOiBTeXN0
ZW0gUkFNCjdmNmJkMDAwLTdmNmJkZmZmIDogcmVzZXJ2ZWQKN2Y2YmUwMDAtN2Y2YmZmZmYgOiBT
eXN0ZW0gUkFNCjdmNmMwMDAwLTdmNmM0ZmZmIDogVW51c2FibGUgbWVtb3J5CjdmNmM1MDAwLTdm
NmU5ZmZmIDogU3lzdGVtIFJBTQo3ZjZlYTAwMC03ZjZlYWZmZiA6IFVudXNhYmxlIG1lbW9yeQo3
ZjZlYjAwMC03ZjZlYmZmZiA6IHJlc2VydmVkCjdmNmVjMDAwLTdmYmI1ZmZmIDogU3lzdGVtIFJB
TQo3ZmJiNjAwMC03ZmJiNmZmZiA6IHJlc2VydmVkCjdmYmI3MDAwLTdmYmI5ZmZmIDogU3lzdGVt
IFJBTQo3ZmJiYTAwMC03ZmJiYWZmZiA6IHJlc2VydmVkCjdmYmJiMDAwLTdmYmZmZmZmIDogU3lz
dGVtIFJBTQo3ZmMwMDAwMC03ZmZmZmZmZiA6IHJlc2VydmVkCjgwMDAwMDAwLWZlMDAwMDAwIDog
UENJIEJ1cyAwMDAwOjAwCiAgODAwMDAwMDAtOGZmZmZmZmYgOiBQQ0kgQnVzIDAwMDA6MDEKICAg
IDgwMDAwMDAwLThmZmZmZmZmIDogUENJIEJ1cyAwMDAwOjAyCiAgICAgIDgwMDAwMDAwLThmZmZm
ZmZmIDogUENJIEJ1cyAwMDAwOjAzCiAgICAgICAgODAwMDAwMDAtOGZmZmZmZmYgOiAwMDAwOjAz
OjAwLjAKICAgICAgICAgIDgwMDEwMDAwLTgwMzBmZmZmIDogZWZpZmIKICA5MDAwMDAwMC05MGFm
ZmZmZiA6IFBDSSBCdXMgMDAwMDowMQogICAgOTAwMDAwMDAtOTA5ZmZmZmYgOiBQQ0kgQnVzIDAw
MDA6MDIKICAgICAgOTAwMDAwMDAtOTA4ZmZmZmYgOiBQQ0kgQnVzIDAwMDA6MDUKICAgICAgICA5
MDAwMDAwMC05MDNmZmZmZiA6IDAwMDA6MDU6MDAuMQogICAgICAgICAgOTAwMDAwMDAtOTAzZmZm
ZmYgOiBlMTAwMGUKICAgICAgICA5MDQwMDAwMC05MDdmZmZmZiA6IDAwMDA6MDU6MDAuMAogICAg
ICAgICAgOTA0MDAwMDAtOTA3ZmZmZmYgOiBlMTAwMGUKICAgICAgICA5MDgwMDAwMC05MDgxZmZm
ZiA6IDAwMDA6MDU6MDAuMQogICAgICAgICAgOTA4MDAwMDAtOTA4MWZmZmYgOiBlMTAwMGUKICAg
ICAgICA5MDgyMDAwMC05MDgzZmZmZiA6IDAwMDA6MDU6MDAuMAogICAgICAgICAgOTA4MjAwMDAt
OTA4M2ZmZmYgOiBlMTAwMGUKICAgICAgICA5MDg0MDAwMC05MDg0MGZmZiA6IDAwMDA6MDU6MDAu
NwogICAgICAgICAgOTA4NDAwMDAtOTA4NDAwMDIgOiBpcG1pX3NpCiAgICAgICAgOTA4NDEwMDAt
OTA4NDFmZmYgOiAwMDAwOjA1OjAwLjQKICAgICAgICAgIDkwODQxMDAwLTkwODQxMDAxIDogaXBt
aV9zaQogICAgICAgIDkwODUwMDAwLTkwODVmZmZmIDogMDAwMDowNTowMC4wCiAgICAgICAgOTA4
NjAwMDAtOTA4NmZmZmYgOiAwMDAwOjA1OjAwLjEKICAgICAgICA5MDg3MDAwMC05MDg3ZmZmZiA6
IDAwMDA6MDU6MDAuMgogICAgICA5MDkwMDAwMC05MDlmZmZmZiA6IFBDSSBCdXMgMDAwMDowMwog
ICAgICAgIDkwOTAwMDAwLTkwOTFmZmZmIDogMDAwMDowMzowMC4wCiAgICAgICAgOTA5MjAwMDAt
OTA5MmZmZmYgOiAwMDAwOjAzOjAwLjAKICAgIDkwYTAwMDAwLTkwYTAwZmZmIDogMDAwMDowMTow
MC4xCiAgOTBiMDAwMDAtOTBiZmZmZmYgOiBQQ0kgQnVzIDAwMDA6MGUKICAgIDkwYjAwMDAwLTkw
YjAzZmZmIDogMDAwMDowZTowYi4wCiAgICA5MGIwNDAwMC05MGIwNDdmZiA6IDAwMDA6MGU6MGIu
MAogICAgICA5MGIwNDAwMC05MGIwNDdmZiA6IGZpcmV3aXJlX29oY2kKICA5MGMwMDAwMC05MGNm
ZmZmZiA6IFBDSSBCdXMgMDAwMDowYwogICAgOTBjMDAwMDAtOTBjZmZmZmYgOiBQQ0kgQnVzIDAw
MDA6MGQKICAgICAgOTBjMDAwMDAtOTBjMGZmZmYgOiAwMDAwOjBkOjAyLjAKICAgICAgICA5MGMw
MDAwMC05MGMwZmZmZiA6IG1wdAogICAgICA5MGMxMDAwMC05MGMxM2ZmZiA6IDAwMDA6MGQ6MDIu
MAogICAgICAgIDkwYzEwMDAwLTkwYzEzZmZmIDogbXB0CiAgOTBkMDAwMDAtOTBkMDNmZmYgOiAw
MDAwOjAwOjFiLjAKICA5MGQwNDAwMC05MGQwNDNmZiA6IDAwMDA6MDA6MDguMAogICAgOTBkMDQw
MDAtOTBkMDQzZmYgOiBpb2F0ZG1hCiAgOTBkMDQ0MDAtOTBkMDQ3ZmYgOiAwMDAwOjAwOjFmLjIK
ICAgIDkwZDA0NDAwLTkwZDA0N2ZmIDogYWhjaQogIDkwZDA0ODAwLTkwZDA0YmZmIDogMDAwMDow
MDoxZC43CiAgICA5MGQwNDgwMC05MGQwNGJmZiA6IGVoY2lfaGNkCiAgOTBlMDAwMDAtOTBmZmZm
ZmYgOiBQQ0kgQnVzIDAwMDA6MGMKICAgIDkwZTAwMDAwLTkwZmZmZmZmIDogUENJIEJ1cyAwMDAw
OjBkCiAgICAgIDkwZTAwMDAwLTkwZmZmZmZmIDogMDAwMDowZDowMi4wCiAgZDAwMDAwMDAtZGZm
ZmZmZmYgOiBQQ0kgTU1DT05GSUcgMDAwMCBbYnVzIDAwLWZmXQogICAgZDAwMDAwMDAtZGZmZmZm
ZmYgOiBwbnAgMDA6MDEKZmU2MDAwMDAtZmU2ZmZmZmYgOiBwbnAgMDA6MDEKZmU3MDAwMDAtZmU3
MDAzZmYgOiBwbnAgMDA6MDEKZmVjMDAwMDAtZmVjMDAzZmYgOiBJT0FQSUMgMApmZWQwMDAwMC1m
ZWQwMDNmZiA6IEhQRVQgMApmZWQxYzAwMC1mZWQxZmZmZiA6IHBucCAwMDowMQpmZWUwMDAwMC1m
ZWVmZmZmZiA6IHBucCAwMDowMQogIGZlZTAwMDAwLWZlZTAwZmZmIDogTG9jYWwgQVBJQwpmZmY5
MDAwMC1mZmZiZmZmZiA6IHJlc2VydmVkCjEwMDAwMDAwMC0yN2ZmZmZmZmYgOiBTeXN0ZW0gUkFN
Cg==
--001517476a70a9235504a9259abb
Content-Type: application/octet-stream; name=lspci -d 808625F0 -v -xxx
Content-Disposition: attachment; filename=lspci -d 808625F0 -v -xxx
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gqo2sm601

MDA6MTAuMCBIb3N0IGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gNTAwMCBTZXJpZXMgQ2hpcHNl
dCBGU0IgUmVnaXN0ZXJzIChyZXYgMzEpCglTdWJzeXN0ZW06IEludGVsIENvcnBvcmF0aW9uIERl
dmljZSA4MDg2CglGbGFnczogZmFzdCBkZXZzZWwKCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBpNTAw
MF9lZGFjCglLZXJuZWwgbW9kdWxlczogaTUwMDBfZWRhYywgaTVrX2FtYiwgaTczMDBfaWRsZQow
MDogODYgODAgZjAgMjUgMDAgMDAgMDAgMDAgMzEgMDAgMDAgMDYgMDAgMDAgODAgMDAKMTA6IDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCjIwOiAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCA4NiA4MCA4NiA4MAozMDogMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKNDA6IDAwIDAwIGZmIDA3IDAwIDA4
IDAwIDAwIDAwIDAwIDAwIGZlIDAwIDAwIDAwIDAwCjUwOiAwMCAwMCAwMiAwMCA4YiAwMSAwNCAw
NCAwMCAzMCAzMyAzMyAzMyAzMyAzMyAzMwo2MDogMDAgMTIgMGYgMDggMDAgZDAgMDAgMDAgZmYg
ZmYgZmYgZmYgMDAgMDAgMDAgMDAKNzA6IDhjIGMwIGUyIDBmIDAwIDAwIDAwIDAwIDhjIGMwIGUy
IDBmIDAwIDAwIDAwIDAwCjgwOiAwMSAwMCA4MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMAo5MDogMDIgMDEgODAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAKYTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDA4IDA2IDgwIDAw
CmIwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwNCAwNyA4MCAwMApjMDog
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKZDA6IDAxIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDExIDAxIDAwIDAwCmUwOiAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMApmMDogN2MgN2YgNDAgMDAgMDYg
YTEgNTggMDEgZjQgMDggZDggMDMgODAgMDAgMDAgMDAKCjAwOjEwLjEgSG9zdCBicmlkZ2U6IElu
dGVsIENvcnBvcmF0aW9uIDUwMDAgU2VyaWVzIENoaXBzZXQgRlNCIFJlZ2lzdGVycyAocmV2IDMx
KQoJU3Vic3lzdGVtOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgODA4NgoJRmxhZ3M6IGZhc3Qg
ZGV2c2VsCglLZXJuZWwgbW9kdWxlczogaTUwMDBfZWRhYywgaTVrX2FtYiwgaTczMDBfaWRsZQow
MDogODYgODAgZjAgMjUgMDAgMDAgMDAgMDAgMzEgMDAgMDAgMDYgMDAgMDAgODAgMDAKMTA6IDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCjIwOiAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCA4NiA4MCA4NiA4MAozMDogMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKNDA6IGYwIDAxIDM0IDQ2IDAzIDAw
IDAwIDAwIDM3IDIzIDU0IDQ1IDMyIDU5IDAyIDAwCjUwOiBmZiBmZiBmZiBmZiBjOCAwMCAwNCAw
MCAxNiAxYSBkOCA3NiAwOCAwMCAwMCAwMAo2MDogMDAgMDAgMDAgMDAgMDAgMDAgNTQgMDMgMDAg
MDAgMDAgMDAgMDAgODAgMDAgMDAKNzA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwCjgwOiAwMyAwMiAwMCAwMCAwMCAwMiAwMCAwMCAwMCAwMiAwMCAwMCAw
MCAwMCAwMCAwMAo5MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMjAgMDAgMDAg
MDAgMDAKYTA6IDAwIDAwIDAwIDIwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDA3IDAwIDAwIDAw
CmIwOiBmZiA3ZiBmZiAwZiBmZiA3ZiBmZiAwZiBmOCA3ZiBmZiAwZiAwMCAwMCA5YiAxYgpjMDog
YTMgM2UgYjAgMDMgMDAgMDggMDAgMDAgMDAgMDAgMDAgZmYgMDAgMDAgZmYgZmYKZDA6IGZmIDAw
IGYwIGZmIGEwIDBhIDU0IGEwIGYwIGZmIGMwIDBmIGZmIDIzIGZhIGI5CmUwOiAwMCAwMCA5YiAx
YiBhMyAzZSBiMCAwMyAwMCAwOCAwMCAwMCBmZiBmZiBmZiBmZgpmMDogZjAgZmYgMDAgZjAgMDAg
MDAgZjAgZmYgMDAgZjAgZmYgMDAgZjAgZmYgYzAgMGYKCjAwOjEwLjIgSG9zdCBicmlkZ2U6IElu
dGVsIENvcnBvcmF0aW9uIDUwMDAgU2VyaWVzIENoaXBzZXQgRlNCIFJlZ2lzdGVycyAocmV2IDMx
KQoJU3Vic3lzdGVtOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgODA4NgoJRmxhZ3M6IGZhc3Qg
ZGV2c2VsCglLZXJuZWwgbW9kdWxlczogaTUwMDBfZWRhYywgaTVrX2FtYiwgaTczMDBfaWRsZQow
MDogODYgODAgZjAgMjUgMDAgMDAgMDAgMDAgMzEgMDAgMDAgMDYgMDAgMDAgODAgMDAKMTA6IDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCjIwOiAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCA4NiA4MCA4NiA4MAozMDogMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKNDA6IDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCjUwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMAo2MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAKNzA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwCjgwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMAo5MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAKYTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
CmIwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMApjMDog
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgZmYgMDAgMDAgMDAKZDA6IGZmIGZm
IGZmIGZmIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCmUwOiBlYyAwMCBiNCBj
OCAwMCAwMCAwMCAwMCAwMCAwMCAwMiAwMCAwMCAwMCAwMCAwMApmMDogMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKCg==
--001517476a70a9235504a9259abb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--001517476a70a9235504a9259abb--
