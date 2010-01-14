From: Karl Newman <siliconfiend@gmail.com>
Date: Thu, 14 Jan 2010 16:12:33 +0000
Subject: Re: [lm-sensors] ATK0110 on older Asus board
Message-Id: <52ae42fa1001140812i6b6cb5en3a66bad85d3a4e5a@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4326480725039454879=="
List-Id: <lm-sensors.vger.kernel.org>
References: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
In-Reply-To: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============4326480725039454879==
Content-Type: multipart/alternative; boundary=0016e64691829c40db047d2227e1

--0016e64691829c40db047d2227e1
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Jan 14, 2010 at 7:19 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Karl,
>
> On Thu, 14 Jan 2010 06:56:34 -0800, Karl Newman wrote:
> > I have a 4-year-old Asus A8N-VM CSM motherboard, which has a W83627EHG
> chip
> > for hardware monitoring. I recently upgraded to kernel 2.6.31 and ran
> into
> > the "Device or Resource busy" error when trying to load my existing
> > w83627ehf module. After some research, I discovered that I should use the
> > asus_atk0110 module instead. So, I updated my kernel config to build that
> > module and it will load with no problem, but "sensors" is ignoring it.
> When
> > I modprobe the module, it silently succeeds (it's listed in lsmod) but
> there
> > are no messages in dmesg or the syslog to indicate any activity from the
> > module, which makes me suspect that my board is not currently supported
> by
> > this module. I did confirm that it has the atk0110 chip (ls
> > /sys/bus/acpi/devices shows a ATK0110:00 entry). Am I doing something
> wrong,
> > or do you need a DSDT dump to support my motherboard, or...?
>
> Which version of lm-sensors are you running? "sensors -v" will tell
> you. Minimum version for asus_atk0110 support is 3.1.0, as documented
> on:
>  http://www.lm-sensors.org/wiki/Devices
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

Sorry, I forgot to mention that. I'm using 3.1.1 (sensors version 3.1.1 with
libsensors version 3.1.1), on Gentoo, along with kernel 2.6.31-gentoo-r6.

Karl

--0016e64691829c40db047d2227e1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Thu, Jan 14, 2010 at 7:19 AM, Jean Delvare <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.or=
g</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"borde=
r-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-le=
ft: 1ex;">
Hi Karl,<br>
<div><div></div><div class=3D"h5"><br>
On Thu, 14 Jan 2010 06:56:34 -0800, Karl Newman wrote:<br>
&gt; I have a 4-year-old Asus A8N-VM CSM motherboard, which has a W83627EHG=
 chip<br>
&gt; for hardware monitoring. I recently upgraded to kernel 2.6.31 and ran =
into<br>
&gt; the &quot;Device or Resource busy&quot; error when trying to load my e=
xisting<br>
&gt; w83627ehf module. After some research, I discovered that I should use =
the<br>
&gt; asus_atk0110 module instead. So, I updated my kernel config to build t=
hat<br>
&gt; module and it will load with no problem, but &quot;sensors&quot; is ig=
noring it. When<br>
&gt; I modprobe the module, it silently succeeds (it&#39;s listed in lsmod)=
 but there<br>
&gt; are no messages in dmesg or the syslog to indicate any activity from t=
he<br>
&gt; module, which makes me suspect that my board is not currently supporte=
d by<br>
&gt; this module. I did confirm that it has the atk0110 chip (ls<br>
&gt; /sys/bus/acpi/devices shows a ATK0110:00 entry). Am I doing something =
wrong,<br>
&gt; or do you need a DSDT dump to support my motherboard, or...?<br>
<br>
</div></div>Which version of lm-sensors are you running? &quot;sensors -v&q=
uot; will tell<br>
you. Minimum version for asus_atk0110 support is 3.1.0, as documented<br>
on:<br>
 =A0<a href=3D"http://www.lm-sensors.org/wiki/Devices" target=3D"_blank">ht=
tp://www.lm-sensors.org/wiki/Devices</a><br>
<font color=3D"#888888"><br>
--<br>
Jean Delvare<br>
<a href=3D"http://khali.linux-fr.org/wishlist.html" target=3D"_blank">http:=
//khali.linux-fr.org/wishlist.html</a><br>
</font></blockquote></div><br>Sorry, I forgot to mention that. I&#39;m usin=
g 3.1.1 (sensors version 3.1.1 with libsensors version 3.1.1), on Gentoo, a=
long with kernel 2.6.31-gentoo-r6.<br><br>Karl<br>

--0016e64691829c40db047d2227e1--


--===============4326480725039454879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4326480725039454879==--
