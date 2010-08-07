From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 07 Aug 2010 11:23:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pc87360) Fix device resource
Message-Id: <AANLkTint+vH55bLWt=9aKjQ4_Fi3=hQVgLjFp-CvhSCk@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4111547539460121524=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20100707145841.58052281@hyperion.delvare>
In-Reply-To: <20100707145841.58052281@hyperion.delvare>
To: lm-sensors@vger.kernel.org

--===============4111547539460121524==
Content-Type: multipart/alternative; boundary=0016e65b569cc32e89048d3a020c

--0016e65b569cc32e89048d3a020c
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Jul 7, 2010 at 6:58 AM, Jean Delvare <khali@linux-fr.org> wrote:

> It's not OK to call platform_device_add_resources() multiple times
> in a row. Despite its name, this functions sets the resources, it
> doesn't add them. So we have to prepare an array with all the
> resources, and then call platform_device_add_resources() once.
>
> Before this fix, only the last I/O resource would be actually
> registered. The other I/O resources were leaked.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Jim Cromie <jim.cromie@gmail.com>
> Cc: stable@kernel.org
> ---
> Jim, do you still have your system with a PC8736x device? If you do,
> can you please test this fix and report? Thanks.
>
>
hi Jean,

I applied this patch, and it built w/o errors.
Howver I have some distro (voyage 0.6.5) vs kernel issues
to resolve before I have a solid testing env.
It looks like 2.6.35 doesnt like udev 145, which shipped along with 2.6.30
kernel

[   11.252182] udev: starting version 145
[   11.252232] <3>udev: missing sysfs features; please update the kernel or
disable the kernel's CONFIG_SYSFS_DEPRECATED option; udev may fail to work
correctly

and it does fail to work correctly;
voyage:~# modprobe pc87360
WARNING: Could not open 'kernel/drivers/hwmon/hwmon-vid.ko': No such file or
directory
FATAL: Could not open 'kernel/drivers/hwmon/pc87360.ko': No such file or
directory

I'll try to straighten this out, and follow up on hotplug ml if I need help.

In the meantime, it looks like res_count isnt initialized before 1st use.

jimc@harpo linux-2.6.git]$ grep -n res_count drivers/hwmon/pc87360.c
1614: int err, i, res_count;
1627: res[res_count].start = extra_isa[i];
1628: res[res_count].end = extra_isa[i] + PC87360_EXTENT - 1;
1629: res[res_count].name = "pc87360",
1630: res[res_count].flags = IORESOURCE_IO,
1632: err = acpi_check_resource_conflict(&res[res_count]);
1636: res_count++;
1639: err = platform_device_add_resources(pdev, res, res_count);

Oddly, gcc doesnt complain about this,
is this somehow hidden by zeroed memory due to __init on the function ??

Jim

--0016e65b569cc32e89048d3a020c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Jul 7, 2010 at 6:58 AM, Jean Del=
vare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linu=
x-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
It&#39;s not OK to call platform_device_add_resources() multiple times<br>
in a row. Despite its name, this functions sets the resources, it<br>
doesn&#39;t add them. So we have to prepare an array with all the<br>
resources, and then call platform_device_add_resources() once.<br>
<br>
Before this fix, only the last I/O resource would be actually<br>
registered. The other I/O resources were leaked.<br>
<br>
Signed-off-by: Jean Delvare &lt;<a href=3D"mailto:khali@linux-fr.org">khali=
@linux-fr.org</a>&gt;<br>
Cc: Jim Cromie &lt;<a href=3D"mailto:jim.cromie@gmail.com">jim.cromie@gmail=
.com</a>&gt;<br>
Cc: <a href=3D"mailto:stable@kernel.org">stable@kernel.org</a><br>
---<br>
Jim, do you still have your system with a PC8736x device? If you do,<br>
can you please test this fix and report? Thanks.<br>
<br></blockquote><div><br></div><div>hi Jean,</div><div><br></div><div>I ap=
plied this patch, and it built w/o errors.</div><div>Howver I have some dis=
tro (voyage 0.6.5) vs kernel issues=A0</div><div>to resolve=A0before=A0I ha=
ve a solid testing env.</div>
<div>It looks like 2.6.35 doesnt like udev 145,=A0which shipped along with =
2.6.30 kernel</div><div><br></div><div><div>[ =A0 11.252182] udev: starting=
 version 145</div><div>[ =A0 11.252232] &lt;3&gt;udev: missing sysfs featur=
es; please update the kernel or disable the kernel&#39;s CONFIG_SYSFS_DEPRE=
CATED option; udev may fail to work correctly</div>
</div><div><br></div><div>and it does fail to work correctly;</div><div><di=
v>voyage:~# modprobe pc87360</div><div>WARNING: Could not open &#39;kernel/=
drivers/hwmon/hwmon-vid.ko&#39;: No such file or directory</div><div>FATAL:=
 Could not open &#39;kernel/drivers/hwmon/pc87360.ko&#39;: No such file or =
directory</div>
</div><div><br></div><div>I&#39;ll try to straighten this out, and follow u=
p on hotplug ml if I need help.</div><div><br></div><div>In the meantime, i=
t looks like res_count isnt initialized before 1st use.</div><div><br></div=
>
<div><div>jimc@harpo linux-2.6.git]$ grep -n res_count drivers/hwmon/pc8736=
0.c=A0</div><div>1614:<span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span>int err, i, res_count;</div><div>1627:<span class=3D"Apple-tab-=
span" style=3D"white-space:pre">		</span>res[res_count].start =3D extra_isa=
[i];</div>
<div>1628:<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span=
>res[res_count].end =3D extra_isa[i] + PC87360_EXTENT - 1;</div><div>1629:<=
span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>res[res_co=
unt].name =3D &quot;pc87360&quot;,</div>
<div>1630:<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span=
>res[res_count].flags =3D IORESOURCE_IO,</div><div>1632:<span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">		</span>err =3D acpi_check_resource_=
conflict(&amp;res[res_count]);</div>
<div>1636:<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span=
>res_count++;</div><div>1639:<span class=3D"Apple-tab-span" style=3D"white-=
space:pre">	</span>err =3D platform_device_add_resources(pdev, res, res_cou=
nt);</div>
</div><div><br></div><div>Oddly, gcc doesnt complain about this,=A0</div><d=
iv>is this somehow hidden by zeroed memory due to __init on the function ??=
</div><div><br></div><div>Jim</div></div>

--0016e65b569cc32e89048d3a020c--


--===============4111547539460121524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4111547539460121524==--
