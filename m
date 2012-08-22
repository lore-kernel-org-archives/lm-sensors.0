From: =?UTF-8?B?0JDQvdGC0L7QvSDQmtC+0YfQutC+0LI=?= <anton.kochkov@gmail.com>
Date: Wed, 22 Aug 2012 19:48:54 +0000
Subject: Re: [lm-sensors] lm-sensors and ITE IT8512
Message-Id: <CA+8M6wmjboMh-eB818PLJo24Kax5n9Jdk7fz+0ZKdnFgfQs0VQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2387043822063733949=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2387043822063733949==
Content-Type: multipart/alternative; boundary=e89a8f83a80b62da3604c7e008f2

--e89a8f83a80b62da3604c7e008f2
Content-Type: text/plain; charset=UTF-8

ITE IT8512 very similar to IT8502 one. Btw, you can see sources of
superiotool (http://coreboot.org/Superiotool ) to figure its registers.
Main issue with these chips that they are embedded controllers, and have
their own firmware, which can differ from one OEM/ODM to another. I have no
luck with interfacing to them yet :(

Best regards,
Anton Kochkov.



On Wed, Aug 22, 2012 at 11:41 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Wed, Aug 22, 2012 at 07:43:22PM +0200, Gianluigi Papia wrote:
> > Hi,
> >
> > First of all, sorry for my English but I'm french speaking.
> > I would like to control the speed of the CPU fan of my Dell Studio
> > 1555, but it seems that lm-sensors doesn't support my fan.
> > When I do sensors-detect, I have this:
> > Trying family `National Semiconductor/ITE'...               Yes
> > Found `ITE IT8512E/F/G Super IO'
> >     (no support yet)
> >
> > Driver `coretemp':
> >   * Chip `Intel digital thermal sensor' (confidence: 9)
> >
> > To load everything that is needed, add this to /etc/modules:
> > #----cut here----
> > # Chip drivers
> > coretemp
> > #----cut here----
> >
> > Of course, when I do pwmconfig, it doesn't work:
> > /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
> >
> > I've tried to force the loading of it87 module, but I've this error:
> > modprobe -v it87 force_id=0x8512
> > insmod /lib/modules/3.2.0-3-amd64/kernel/drivers/hwmon/it87.ko
> force_id=0x8512
> > ERROR: could not insert 'it87': No such device
> >
> You can not force the ID to the "real" id ... or at least it won't help.
>
> > I've also read that there are several issues because of acpi, so I've
> > added in /etc/default/grub:
> > GRUB_CMDLINE_LINUX_DEFAULT="quiet acpi_enforce_resources=lax"
> >
> > But, it still doesn't work. Is it dead for good because of ITE IT8512
> > which has no support, or is there another solution?
> >
> It is not supported. I looked into the data sheet; the chip is not related
> to
> the IT87 series, and would require a completely new driver.
>
> Guenter
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

--e89a8f83a80b62da3604c7e008f2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

ITE IT8512 very similar to IT8502 one. Btw, you can see sources of superiot=
ool (<a href=3D"http://coreboot.org/Superiotool">http://coreboot.org/Superi=
otool</a> ) to figure its registers. Main issue with these chips that they =
are embedded controllers, and have their own firmware, which can differ fro=
m one OEM/ODM to another. I have no luck with interfacing to them yet :(<br=
>
<br clear=3D"all">Best regards,<br>Anton Kochkov.<br><br>
<br><br><div class=3D"gmail_quote">On Wed, Aug 22, 2012 at 11:41 PM, Guente=
r Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:linux@roeck-us.net" target=
=3D"_blank">linux@roeck-us.net</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<div class=3D"im">On Wed, Aug 22, 2012 at 07:43:22PM +0200, Gianluigi Papia=
 wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; First of all, sorry for my English but I&#39;m french speaking.<br>
&gt; I would like to control the speed of the CPU fan of my Dell Studio<br>
&gt; 1555, but it seems that lm-sensors doesn&#39;t support my fan.<br>
&gt; When I do sensors-detect, I have this:<br>
&gt; Trying family `National Semiconductor/ITE&#39;... =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Yes<br>
&gt; Found `ITE IT8512E/F/G Super IO&#39;<br>
&gt; =C2=A0 =C2=A0 (no support yet)<br>
&gt;<br>
&gt; Driver `coretemp&#39;:<br>
&gt; =C2=A0 * Chip `Intel digital thermal sensor&#39; (confidence: 9)<br>
&gt;<br>
&gt; To load everything that is needed, add this to /etc/modules:<br>
&gt; #----cut here----<br>
&gt; # Chip drivers<br>
&gt; coretemp<br>
&gt; #----cut here----<br>
&gt;<br>
&gt; Of course, when I do pwmconfig, it doesn&#39;t work:<br>
&gt; /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed=
<br>
&gt;<br>
&gt; I&#39;ve tried to force the loading of it87 module, but I&#39;ve this =
error:<br>
&gt; modprobe -v it87 force_id=3D0x8512<br>
&gt; insmod /lib/modules/3.2.0-3-amd64/kernel/drivers/hwmon/it87.ko force_i=
d=3D0x8512<br>
&gt; ERROR: could not insert &#39;it87&#39;: No such device<br>
&gt;<br>
</div>You can not force the ID to the &quot;real&quot; id ... or at least i=
t won&#39;t help.<br>
<div class=3D"im"><br>
&gt; I&#39;ve also read that there are several issues because of acpi, so I=
&#39;ve<br>
&gt; added in /etc/default/grub:<br>
&gt; GRUB_CMDLINE_LINUX_DEFAULT=3D&quot;quiet acpi_enforce_resources=3Dlax&=
quot;<br>
&gt;<br>
&gt; But, it still doesn&#39;t work. Is it dead for good because of ITE IT8=
512<br>
&gt; which has no support, or is there another solution?<br>
&gt;<br>
</div>It is not supported. I looked into the data sheet; the chip is not re=
lated to<br>
the IT87 series, and would require a completely new driver.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Guenter<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
_______________________________________________<br>
lm-sensors mailing list<br>
<a href=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</a><=
br>
<a href=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" target=
=3D"_blank">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a><br>
</div></div></blockquote></div><br>

--e89a8f83a80b62da3604c7e008f2--


--===============2387043822063733949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2387043822063733949==--
