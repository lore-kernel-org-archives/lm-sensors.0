From: Karl Newman <siliconfiend@gmail.com>
Date: Fri, 15 Jan 2010 16:40:24 +0000
Subject: Re: [lm-sensors] ATK0110 on older Asus board
Message-Id: <52ae42fa1001150840j3c3bf8e0lf9f05a3602cb695d@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0776503938198968665=="
List-Id: <lm-sensors.vger.kernel.org>
References: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
In-Reply-To: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============0776503938198968665==
Content-Type: multipart/alternative; boundary=00504502e1ce061745047d36a907

--00504502e1ce061745047d36a907
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Jan 14, 2010 at 11:43 PM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Karl,
>
> On Thu, 14 Jan 2010 08:12:33 -0800, Karl Newman wrote:
> > On Thu, Jan 14, 2010 at 7:19 AM, Jean Delvare <khali@linux-fr.org>
> wrote:
> > > On Thu, 14 Jan 2010 06:56:34 -0800, Karl Newman wrote:
> > > > I have a 4-year-old Asus A8N-VM CSM motherboard, which has a
> W83627EHG
> > > > chip for hardware monitoring. I recently upgraded to kernel 2.6.31
> and
> > > > ran into the "Device or Resource busy" error when trying to load my
> > > > existing w83627ehf module. After some research, I discovered that I
> > > > should use the asus_atk0110 module instead. So, I updated my kernel
> > > > config to build that module and it will load with no problem, but
> > > > "sensors" is ignoring it. When I modprobe the module, it silently
> > > > succeeds (it's listed in lsmod) but there are no messages in dmesg or
> > > > the syslog to indicate any activity from the module, which makes me
> > > > suspect that my board is not currently supported by this module. I
> did
> > > > confirm that it has the atk0110 chip (ls /sys/bus/acpi/devices shows
> a
> > > > ATK0110:00 entry). Am I doing something wrong, or do you need a DSDT
> > > > dump to support my motherboard, or...?
> > >
> > > Which version of lm-sensors are you running? "sensors -v" will tell
> > > you. Minimum version for asus_atk0110 support is 3.1.0, as documented
> > > on:
> > >  http://www.lm-sensors.org/wiki/Devices
> >
> > Sorry, I forgot to mention that. I'm using 3.1.1 (sensors version 3.1.1
> with
> > libsensors version 3.1.1), on Gentoo, along with kernel 2.6.31-gentoo-r6.
>
> OK, that would be a kernel-side problem then. I guess that you don't
> have a /sys/class/hwmon/hwmon* directory created for the asus_atk0110?
>
> I'm adding Luca to Cc, your best chance is probably to send him your
> DSDT in private and let him investigate.
>
> If an updated BIOS exists for your motherboard, you may have to use it.
>
>
I have a /sys/class/hwmon/hwmon0 directory, but it's for the k8temp module.
If I unload k8temp and load asus_atk0110, there's no /sys/class/hwmon
directory. I can't use a new BIOS because the newest one breaks boot-time
USB support, so I'm using one version back. I had DSDT problems with this
board with early version of the BIOS (I had to load a custom table in the
kernel to fix the errors), but later BIOS versions fixed the problem. I'm
sending my DSDT to Luca in a separate mail. Thanks for your help!

Karl Newman

--00504502e1ce061745047d36a907
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Thu, Jan 14, 2010 at 11:43 PM, Jean Delvare <=
span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.o=
rg</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"bord=
er-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-l=
eft: 1ex;">
Hi Karl,<br>
<div class=3D"im"><br>
On Thu, 14 Jan 2010 08:12:33 -0800, Karl Newman wrote:<br>
&gt; On Thu, Jan 14, 2010 at 7:19 AM, Jean Delvare &lt;<a href=3D"mailto:kh=
ali@linux-fr.org">khali@linux-fr.org</a>&gt; wrote:<br>
</div><div class=3D"im">&gt; &gt; On Thu, 14 Jan 2010 06:56:34 -0800, Karl =
Newman wrote:<br>
&gt; &gt; &gt; I have a 4-year-old Asus A8N-VM CSM motherboard, which has a=
 W83627EHG<br>
&gt; &gt; &gt; chip for hardware monitoring. I recently upgraded to kernel =
2.6.31 and<br>
&gt; &gt; &gt; ran into the &quot;Device or Resource busy&quot; error when =
trying to load my<br>
&gt; &gt; &gt; existing w83627ehf module. After some research, I discovered=
 that I<br>
&gt; &gt; &gt; should use the asus_atk0110 module instead. So, I updated my=
 kernel<br>
&gt; &gt; &gt; config to build that module and it will load with no problem=
, but<br>
&gt; &gt; &gt; &quot;sensors&quot; is ignoring it. When I modprobe the modu=
le, it silently<br>
&gt; &gt; &gt; succeeds (it&#39;s listed in lsmod) but there are no message=
s in dmesg or<br>
&gt; &gt; &gt; the syslog to indicate any activity from the module, which m=
akes me<br>
&gt; &gt; &gt; suspect that my board is not currently supported by this mod=
ule. I did<br>
&gt; &gt; &gt; confirm that it has the atk0110 chip (ls /sys/bus/acpi/devic=
es shows a<br>
&gt; &gt; &gt; ATK0110:00 entry). Am I doing something wrong, or do you nee=
d a DSDT<br>
&gt; &gt; &gt; dump to support my motherboard, or...?<br>
&gt; &gt;<br>
&gt; &gt; Which version of lm-sensors are you running? &quot;sensors -v&quo=
t; will tell<br>
&gt; &gt; you. Minimum version for asus_atk0110 support is 3.1.0, as docume=
nted<br>
&gt; &gt; on:<br>
&gt; &gt; =A0<a href=3D"http://www.lm-sensors.org/wiki/Devices" target=3D"_=
blank">http://www.lm-sensors.org/wiki/Devices</a><br>
&gt;<br>
</div><div class=3D"im">&gt; Sorry, I forgot to mention that. I&#39;m using=
 3.1.1 (sensors version 3.1.1 with<br>
&gt; libsensors version 3.1.1), on Gentoo, along with kernel 2.6.31-gentoo-=
r6.<br>
<br>
</div>OK, that would be a kernel-side problem then. I guess that you don&#3=
9;t<br>
have a /sys/class/hwmon/hwmon* directory created for the asus_atk0110?<br>
<br>
I&#39;m adding Luca to Cc, your best chance is probably to send him your<br=
>
DSDT in private and let him investigate.<br>
<br>
If an updated BIOS exists for your motherboard, you may have to use it.<br>
<br></blockquote></div><br>I have a /sys/class/hwmon/hwmon0 directory, but =
it&#39;s for the k8temp module. If I unload k8temp and load asus_atk0110, t=
here&#39;s no /sys/class/hwmon directory. I can&#39;t use a new BIOS becaus=
e the newest one breaks boot-time USB support, so I&#39;m using one version=
 back. I had DSDT problems with this board with early version of the BIOS (=
I had to load a custom table in the kernel to fix the errors), but later BI=
OS versions fixed the problem. I&#39;m sending my DSDT to Luca in a separat=
e mail. Thanks for your help!<br>
<br>Karl Newman<br>

--00504502e1ce061745047d36a907--


--===============0776503938198968665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0776503938198968665==--
