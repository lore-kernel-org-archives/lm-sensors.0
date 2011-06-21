From: krunal patel <krunal_smiles@yahoo.com>
Date: Tue, 21 Jun 2011 07:22:49 +0000
Subject: Re: [lm-sensors] sensor details for W83627HG-AW
Message-Id: <927002.8256.qm@web95808.mail.in.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5072082065387168479=="
List-Id: <lm-sensors.vger.kernel.org>
References: <838315.8004.qm@web95806.mail.in.yahoo.com>
In-Reply-To: <838315.8004.qm@web95806.mail.in.yahoo.com>
To: lm-sensors@vger.kernel.org

--===============5072082065387168479==
Content-Type: multipart/alternative; boundary="0-1633980143-1308640249=:8256"

--0-1633980143-1308640249=:8256
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Jean,
Its working now. Thank you very much for your patch.
dmesg output--------------------w83627hf: Found W83627HF chip at 0x290Using=
 6-bit VID table for VIA C7-D CPU

# sensors=A0--------------w83627hf-isa-0290Adapter: ISA adapterin0: =A0 =A0=
 =A0 =A0 =A0+0.69 V =A0(min =3D =A0+0.00 V, max =3D =A0+4.08 V)in1: =A0 =A0=
 =A0 =A0 =A0+1.06 V =A0(min =3D =A0+0.00 V, max =3D =A0+4.08 V)in2: =A0 =A0=
 =A0 =A0 =A0+3.30 V =A0(min =3D =A0+2.82 V, max =3D =A0+3.79 V)in3: =A0 =A0=
 =A0 =A0 =A0+2.99 V =A0(min =3D =A0+3.57 V, max =3D =A0+1.98 V) =A0ALARMin4=
: =A0 =A0 =A0 =A0 =A0+3.28 V =A0(min =3D =A0+1.98 V, max =3D =A0+4.05 V)in5=
: =A0 =A0 =A0 =A0 =A0+3.30 V =A0(min =3D =A0+3.57 V, max =3D =A0+3.30 V) =
=A0ALARMin6: =A0 =A0 =A0 =A0 =A0+3.33 V =A0(min =3D =A0+1.78 V, max =3D =A0=
+0.53 V) =A0ALARMin7: =A0 =A0 =A0 =A0 =A0+3.30 V =A0(min =3D =A0+0.77 V, ma=
x =3D =A0+2.29 V) =A0ALARMin8: =A0 =A0 =A0 =A0 =A0+3.52 V =A0(min =3D =A0+3=
.06 V, max =3D =A0+0.64 V) =A0ALARMfan1: =A0 =A0 =A0 =A0 =A0 0 RPM =A0(min =
=3D 13775 RPM, div =3D 2) =A0ALARMfan2: =A0 =A0 =A0 =A0 =A0 0 RPM =A0(min =
=3D =A0 -1 RPM, div =3D 2) =A0ALARMfan3: =A0 =A0 =A0 =A0 =A0 0 RPM =A0(min =
=3D 3515 RPM, div =3D 2) =A0ALARMtemp1: =A0 =A0 =A0 =A0+52.0 C =A0(high =3D=
 =A0+9.0 C, hyst =3D +32.0 C) =A0ALARM =A0sensor =3D thermistortemp2: =A0 =
=A0 =A0
 =A0+38.5 C =A0(high =3D +120.0 C, hyst =3D +115.0 C) =A0sensor =3D diodete=
mp3: =A0 =A0 =A0 =A0-48.0 C =A0(high =3D +120.0 C, hyst =3D +115.0 C) =A0se=
nsor =3D thermistorcpu0_vid: =A0 =A0+1.212 Vbeep_enable: enabled


I looked into driver code and hwmon related code. All sensor data is export=
ed to user space using sysfs.
One thing I understood is there is no interrupt mechanism in sensor chip so=
 we need to read data from chip's memory. So for=A0periodic data we need to=
 do polling at userspace (like sensord).=A0
Can I implement timer in driver and do polling in Kernel?=A0
What I want to do is get userspace event only when Alarm is raised. If I im=
plement timer and netlink communication in driver will it be correct way to=
 do it? As I do not find any other way.
Best Regards,Krunal Patel

--- On Mon, 20/6/11, Jean Delvare <khali@linux-fr.org> wrote:

From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] sensor details for W83627HG-AW
To: "krunal patel" <krunal_smiles@yahoo.com>
Cc: lm-sensors@lm-sensors.org
Date: Monday, 20 June, 2011, 11:30 PM

Hi Krunal,

On Sat, 4 Jun 2011 13:08:18 +0200, Jean Delvare wrote:
> Brilly, Kary, can you help us here, please? Where can we get the VID pin
> codes -> Vcore voltage conversion table for VIA CPU family 6, model 13?
> This is needed to update drivers/hwmon/hwmon-vid.c.

I received information from VIA and was able to update hwmon-vid to
support your CPU. Patch below. I couldn't test it as I don't have the
hardware. I've also made the modified hwmon-vid driver available as a
standalone driver at:
=A0 http://khali.linux-fr.org/devel/misc/hwmon-vid/
with instructions at:
=A0 http://khali.linux-fr.org/devel/misc/INSTALL

Please test if you can, and report.


From: Jean Delvare <khali@linux-fr.org>
Subject: hwmon-vid: Add support for VIA C7-D

The VIA C7-D CPU (Eden 90 nm) can use two different VID tables, we
have to check the value of a MSR to decide which one to use.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/hwmon-vid.c |=A0=A0=A023 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- linux-3.0-rc3.orig/drivers/hwmon/hwmon-vid.c=A0=A0=A0 2011-06-20 13:43:=
24.000000000 +0200
+++ linux-3.0-rc3/drivers/hwmon/hwmon-vid.c=A0=A0=A0 2011-06-20 17:58:18.00=
0000000 +0200
@@ -206,10 +206,30 @@ static struct vrm_model vrm_models[] =3D {
 =A0=A0=A0 {X86_VENDOR_CENTAUR, 0x6, 0x9, ANY, 17},=A0=A0=A0 /* C3-M, Eden-=
N */
 =A0=A0=A0 {X86_VENDOR_CENTAUR, 0x6, 0xA, 0x7, 0},=A0=A0=A0 =A0=A0=A0 /* No=
 information */
 =A0=A0=A0 {X86_VENDOR_CENTAUR, 0x6, 0xA, ANY, 13},=A0=A0=A0 /* C7, Esther =
*/
+=A0=A0=A0 {X86_VENDOR_CENTAUR, 0x6, 0xD, ANY, 134},=A0=A0=A0 /* C7-D, Eden=
 (90 nm) */
=20
 =A0=A0=A0 {X86_VENDOR_UNKNOWN, ANY, ANY, ANY, 0}=A0=A0=A0 =A0=A0=A0 /* sto=
p here */
 };
=20
+/*
+ * Special case for VIA C7-D: there are two different possible
+ * VID tables, so we have to figure out first, which one must
+ * be used.
+ */
+static u8 get_via_c7d_vrm(void)
+{
+=A0=A0=A0 unsigned int eax, edx;
+
+=A0=A0=A0 rdmsr(0x198, eax, edx);
+=A0=A0=A0 if ((edx & 0xff) > 0x3f) {
+=A0=A0=A0 =A0=A0=A0 pr_info("Using %d-bit VID table for VIA C7-D CPU\n", 7=
);
+=A0=A0=A0 =A0=A0=A0 return 14;
+=A0=A0=A0 } else {
+=A0=A0=A0 =A0=A0=A0 pr_info("Using %d-bit VID table for VIA C7-D CPU\n", 6=
);
+=A0=A0=A0 =A0=A0=A0 return 13;
+=A0=A0=A0 }
+}
+
 static u8 find_vrm(u8 eff_family, u8 eff_model, u8 eff_stepping, u8 vendor=
)
 {
 =A0=A0=A0 int i =3D 0;
@@ -249,6 +269,9 @@ u8 vid_which_vrm(void)
 =A0=A0=A0 vrm_ret =3D find_vrm(eff_family, eff_model, eff_stepping, c->x86=
_vendor);
 =A0=A0=A0 if (vrm_ret =3D=3D 0)
 =A0=A0=A0 =A0=A0=A0 pr_info("Unknown VRM version of your x86 CPU\n");
+=A0=A0=A0 if (vrm_ret =3D=3D 134)
+=A0=A0=A0 =A0=A0=A0 vrm_ret =3D get_via_c7d_vrm();
+
 =A0=A0=A0 return vrm_ret;
 }
=20


--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

--0-1633980143-1308640249=:8256
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><div><div>Hi Jean,</div><div><br></div><div>I=
ts working now. Thank you very much for your patch.</div><div><br></div><di=
v>dmesg output</div><div>--------------------</div><div>w83627hf: Found W83=
627HF chip at 0x290</div><div>Using 6-bit VID table for VIA C7-D CPU</div><=
/div><div><br></div><div><br></div><div># sensors&nbsp;</div><div>---------=
-----</div><div>w83627hf-isa-0290</div><div>Adapter: ISA adapter</div><div>=
in0: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;+0.69 V &nbsp;(min =3D &nbsp;+0.00 V=
, max =3D &nbsp;+4.08 V)</div><div>in1: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;+=
1.06 V &nbsp;(min =3D &nbsp;+0.00 V, max =3D &nbsp;+4.08 V)</div><div>in2: =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;+3.30 V &nbsp;(min =3D &nbsp;+2.82 V, max=
 =3D &nbsp;+3.79 V)</div><div>in3: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;+2.99 =
V &nbsp;(min =3D &nbsp;+3.57 V, max =3D &nbsp;+1.98 V) &nbsp;ALARM</div><di=
v>in4: &nbsp;
 &nbsp; &nbsp; &nbsp; &nbsp;+3.28 V &nbsp;(min =3D &nbsp;+1.98 V, max =3D &=
nbsp;+4.05 V)</div><div>in5: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;+3.30 V &nbs=
p;(min =3D &nbsp;+3.57 V, max =3D &nbsp;+3.30 V) &nbsp;ALARM</div><div>in6:=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;+3.33 V &nbsp;(min =3D &nbsp;+1.78 V, ma=
x =3D &nbsp;+0.53 V) &nbsp;ALARM</div><div>in7: &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp;+3.30 V &nbsp;(min =3D &nbsp;+0.77 V, max =3D &nbsp;+2.29 V) &nbsp;A=
LARM</div><div>in8: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;+3.52 V &nbsp;(min =
=3D &nbsp;+3.06 V, max =3D &nbsp;+0.64 V) &nbsp;ALARM</div><div>fan1: &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; 0 RPM &nbsp;(min =3D 13775 RPM, div =3D 2) &n=
bsp;ALARM</div><div>fan2: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0 RPM &nbsp;(m=
in =3D &nbsp; -1 RPM, div =3D 2) &nbsp;ALARM</div><div>fan3: &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; 0 RPM &nbsp;(min =3D 3515 RPM, div =3D 2) &nbsp;ALARM<=
/div><div>temp1: &nbsp; &nbsp; &nbsp; &nbsp;+52.0 C &nbsp;(high =3D &nbsp;+=
9.0 C, hyst =3D +32.0 C)
 &nbsp;ALARM &nbsp;sensor =3D thermistor</div><div>temp2: &nbsp; &nbsp; &nb=
sp; &nbsp;+38.5 C &nbsp;(high =3D +120.0 C, hyst =3D +115.0 C) &nbsp;sensor=
 =3D diode</div><div>temp3: &nbsp; &nbsp; &nbsp; &nbsp;-48.0 C &nbsp;(high =
=3D +120.0 C, hyst =3D +115.0 C) &nbsp;sensor =3D thermistor</div><div>cpu0=
_vid: &nbsp; &nbsp;+1.212 V</div><div>beep_enable: enabled</div><div><br></=
div><div><br></div><div><br></div>I looked into driver code and hwmon relat=
ed code. All sensor data is exported to user space using sysfs.<div><br></d=
iv><div>One thing I understood is there is no interrupt mechanism in sensor=
 chip so we need to read data from chip's memory. So for&nbsp;periodic data=
 we need to do polling at userspace (like sensord).&nbsp;</div><div><br></d=
iv><div>Can I implement timer in driver and do polling in Kernel?&nbsp;</di=
v><div><br></div><div>What I want to do is get userspace event only when Al=
arm is raised. If I implement timer and netlink communication in driver wil=
l it be
 correct way to do it? As I do not find any other way.</div><div><br></div>=
<div><div><p><font face=3D"courier, monaco, monospace, sans-serif">Best Reg=
ards,</font></p><p><font face=3D"courier, monaco, monospace, sans-serif">Kr=
unal Patel</font></p><br><br>--- On <b>Mon, 20/6/11, Jean Delvare <i>&lt;kh=
ali@linux-fr.org&gt;</i></b> wrote:<br><blockquote style=3D"border-left: 2p=
x solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"><br>From: J=
ean Delvare &lt;khali@linux-fr.org&gt;<br>Subject: Re: [lm-sensors] sensor =
details for W83627HG-AW<br>To: "krunal patel" &lt;krunal_smiles@yahoo.com&g=
t;<br>Cc: lm-sensors@lm-sensors.org<br>Date: Monday, 20 June, 2011, 11:30 P=
M<br><br><div class=3D"plainMail">Hi Krunal,<br><br>On Sat, 4 Jun 2011 13:0=
8:18 +0200, Jean Delvare wrote:<br>&gt; Brilly, Kary, can you help us here,=
 please? Where can we get the VID pin<br>&gt; codes -&gt; Vcore voltage con=
version table for VIA CPU family 6, model 13?<br>&gt; This is needed to
 update drivers/hwmon/hwmon-vid.c.<br><br>I received information from VIA a=
nd was able to update hwmon-vid to<br>support your CPU. Patch below. I coul=
dn't test it as I don't have the<br>hardware. I've also made the modified h=
wmon-vid driver available as a<br>standalone driver at:<br>&nbsp; <a href=
=3D"http://khali.linux-fr.org/devel/misc/hwmon-vid/" target=3D"_blank">http=
://khali.linux-fr.org/devel/misc/hwmon-vid/</a><br>with instructions at:<br=
>&nbsp; <a href=3D"http://khali.linux-fr.org/devel/misc/INSTALL" target=3D"=
_blank">http://khali.linux-fr.org/devel/misc/INSTALL</a><br><br>Please test=
 if you can, and report.<br><br><br>From: Jean Delvare &lt;<a ymailto=3D"ma=
ilto:khali@linux-fr.org" href=3D"/mc/compose?to=3Dkhali@linux-fr.org">khali=
@linux-fr.org</a>&gt;<br>Subject: hwmon-vid: Add support for VIA C7-D<br><b=
r>The VIA C7-D CPU (Eden 90 nm) can use two different VID tables, we<br>hav=
e to check the value of a MSR to decide which one to use.<br><br>Signed-off=
-by: Jean
 Delvare &lt;<a ymailto=3D"mailto:khali@linux-fr.org" href=3D"/mc/compose?t=
o=3Dkhali@linux-fr.org">khali@linux-fr.org</a>&gt;<br>---<br> drivers/hwmon=
/hwmon-vid.c |&nbsp;&nbsp;&nbsp;23 +++++++++++++++++++++++<br> 1 file chang=
ed, 23 insertions(+)<br><br>--- linux-3.0-rc3.orig/drivers/hwmon/hwmon-vid.=
c&nbsp;&nbsp;&nbsp; 2011-06-20 13:43:24.000000000 +0200<br>+++ linux-3.0-rc=
3/drivers/hwmon/hwmon-vid.c&nbsp;&nbsp;&nbsp; 2011-06-20 17:58:18.000000000=
 +0200<br>@@ -206,10 +206,30 @@ static struct vrm_model vrm_models[] =3D {<=
br> &nbsp;&nbsp;&nbsp; {X86_VENDOR_CENTAUR, 0x6, 0x9, ANY, 17},&nbsp;&nbsp;=
&nbsp; /* C3-M, Eden-N */<br> &nbsp;&nbsp;&nbsp; {X86_VENDOR_CENTAUR, 0x6, =
0xA, 0x7, 0},&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* No information */<br>=
 &nbsp;&nbsp;&nbsp; {X86_VENDOR_CENTAUR, 0x6, 0xA, ANY, 13},&nbsp;&nbsp;&nb=
sp; /* C7, Esther */<br>+&nbsp;&nbsp;&nbsp; {X86_VENDOR_CENTAUR, 0x6, 0xD, =
ANY, 134},&nbsp;&nbsp;&nbsp; /* C7-D, Eden (90 nm) */<br> <br>
 &nbsp;&nbsp;&nbsp; {X86_VENDOR_UNKNOWN, ANY, ANY, ANY, 0}&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; /* stop here */<br> };<br> <br>+/*<br>+ * Special case=
 for VIA C7-D: there are two different possible<br>+ * VID tables, so we ha=
ve to figure out first, which one must<br>+ * be used.<br>+ */<br>+static u=
8 get_via_c7d_vrm(void)<br>+{<br>+&nbsp;&nbsp;&nbsp; unsigned int eax, edx;=
<br>+<br>+&nbsp;&nbsp;&nbsp; rdmsr(0x198, eax, edx);<br>+&nbsp;&nbsp;&nbsp;=
 if ((edx &amp; 0xff) &gt; 0x3f) {<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; pr_info("Using %d-bit VID table for VIA C7-D CPU\n", 7);<br>+&nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; return 14;<br>+&nbsp;&nbsp;&nbsp; } else {<br>+&n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; pr_info("Using %d-bit VID table for VIA=
 C7-D CPU\n", 6);<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return 13;<br>+=
&nbsp;&nbsp;&nbsp; }<br>+}<br>+<br> static u8 find_vrm(u8 eff_family, u8 ef=
f_model, u8 eff_stepping, u8 vendor)<br> {<br> &nbsp;&nbsp;&nbsp;
 int i =3D 0;<br>@@ -249,6 +269,9 @@ u8 vid_which_vrm(void)<br> &nbsp;&nbsp=
;&nbsp; vrm_ret =3D find_vrm(eff_family, eff_model, eff_stepping, c-&gt;x86=
_vendor);<br> &nbsp;&nbsp;&nbsp; if (vrm_ret =3D=3D 0)<br> &nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; pr_info("Unknown VRM version of your x86 CPU\n");<br>=
+&nbsp;&nbsp;&nbsp; if (vrm_ret =3D=3D 134)<br>+&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; vrm_ret =3D get_via_c7d_vrm();<br>+<br> &nbsp;&nbsp;&nbsp; retur=
n vrm_ret;<br> }<br> <br><br><br>-- <br>Jean Delvare<br><a href=3D"http://k=
hali.linux-fr.org/wishlist.html" target=3D"_blank">http://khali.linux-fr.or=
g/wishlist.html</a><br></div></blockquote></div></div></td></tr></table>
--0-1633980143-1308640249=:8256--


--===============5072082065387168479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5072082065387168479==--
