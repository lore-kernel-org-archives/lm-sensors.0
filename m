From: James Webb <jrwebb56@gmail.com>
Date: Sat, 06 Apr 2013 16:41:05 +0000
Subject: Re: [lm-sensors] IT8772E Test
Message-Id: <CAPUNBTQmF5qbH05brBUYF04uC2+ePvxwEh0HVwCrLt2QwKoSLA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2327020907433838729=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1365042247.19144.9.camel@janus>
In-Reply-To: <1365042247.19144.9.camel@janus>
To: lm-sensors@vger.kernel.org

--===============2327020907433838729==
Content-Type: multipart/alternative; boundary=f46d04083877af37d604d9b3dee1

--f46d04083877af37d604d9b3dee1
Content-Type: text/plain; charset=ISO-8859-1

It's ACPI:

it87: Found IT8772F chip at 0xa30, revision 0
ACPI Warning: 0x0000000000000a35-0x0000000000000a36 SystemIO conflicts with
Region \_SB_.PCI0.SBRG.LBAE 1 (20121018/utaddress-251)
ACPI: If an ACPI driver is available for this device, you should use it
instead of the native driver

No idea what this is. Will running acpid help?





On Wed, Apr 3, 2013 at 8:52 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Wed, Apr 03, 2013 at 07:24:07PM -0700, James Webb wrote:
> > Running a Dell XPS-8300
> > sensors-detect reports:
> > Found `ITE IT8772E Super IO Sensors'                        Success!
> >     (address 0xa30, driver `to-be-written')
> > Compiled standalone driver but either modprobe it87 or modprobe it87
> > force_id=0x8721 results in:
> > FATAL: Error inserting it87
> > (/lib/modules/3.8.5-gentoo/kernel/drivers/hwmon/it87.ko): Device or
> > resource busy
> >
> > Any suggestions?
> >
> Some other device has its io memory space reserved, or the io memory
> space is reserved by ACPI (which is more likely). In the latter case,
> you should see an acpi resource conflict message on the console
> (or with dmesg).  Otherwise, 'cat /proc/ioports' should give you
> an idea about the offending driver.
>
> Guenter
>

--f46d04083877af37d604d9b3dee1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It&#39;s ACPI:<div><div><br></div><div>it87: Found IT8772F=
 chip at 0xa30, revision 0</div><div>ACPI Warning: 0x0000000000000a35-0x000=
0000000000a36 SystemIO conflicts with Region \_SB_.PCI0.SBRG.LBAE 1 (201210=
18/utaddress-251)</div>
<div>ACPI: If an ACPI driver is available for this device, you should use i=
t instead of the native driver</div></div><div><br></div><div style>No idea=
 what this is. Will running acpid help?</div><div style><br></div><div styl=
e>
<br></div><div><br></div></div><div class=3D"gmail_extra"><br><br><div clas=
s=3D"gmail_quote">On Wed, Apr 3, 2013 at 8:52 PM, Guenter Roeck <span dir=
=3D"ltr">&lt;<a href=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@=
roeck-us.net</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Wed, Apr 03, 2013 at 07=
:24:07PM -0700, James Webb wrote:<br>
&gt; Running a Dell XPS-8300<br>
&gt; sensors-detect reports:<br>
&gt; Found `ITE IT8772E Super IO Sensors&#39; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0Success!<br>
&gt; =A0 =A0 (address 0xa30, driver `to-be-written&#39;)<br>
&gt; Compiled standalone driver but either modprobe it87 or modprobe it87<b=
r>
&gt; force_id=3D0x8721 results in:<br>
&gt; FATAL: Error inserting it87<br>
&gt; (/lib/modules/3.8.5-gentoo/kernel/drivers/hwmon/it87.ko): Device or<br=
>
&gt; resource busy<br>
&gt;<br>
&gt; Any suggestions?<br>
&gt;<br>
</div>Some other device has its io memory space reserved, or the io memory<=
br>
space is reserved by ACPI (which is more likely). In the latter case,<br>
you should see an acpi resource conflict message on the console<br>
(or with dmesg). =A0Otherwise, &#39;cat /proc/ioports&#39; should give you<=
br>
an idea about the offending driver.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Guenter<br>
</font></span></blockquote></div><br></div>

--f46d04083877af37d604d9b3dee1--


--===============2327020907433838729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2327020907433838729==--
