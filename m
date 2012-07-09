From: Mohsen Jamali <mohsen.aria@gmail.com>
Date: Mon, 09 Jul 2012 12:31:03 +0000
Subject: Re: [lm-sensors] ACPI: I/O resource dme1737 [0xa70-0xa71] conflicts with ACPI region RNTR [0xa00-0xa
Message-Id: <CAOi8JQxcbXFGFDK-CKofDLYD0uPrznsVaqmmiPuya1n=nbn9ug@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2768306283387014274=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOi8JQyxPWqc4=w+NorQSWQfVyY3Mswmkf0wQ58BTvH0qKFFhg@mail.gmail.com>
In-Reply-To: <CAOi8JQyxPWqc4=w+NorQSWQfVyY3Mswmkf0wQ58BTvH0qKFFhg@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============2768306283387014274==
Content-Type: multipart/alternative; boundary=20cf303dd5a4c7435704c4649fc5

--20cf303dd5a4c7435704c4649fc5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

the same problem again!

On Mon, Jul 9, 2012 at 8:20 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Sun, Jul 08, 2012 at 12:18:23PM +0430, Mohsen Jamali wrote:
> > *1Hi guys :)*
> > im using Debian squeeze on this machine :
> >
> http://www.advantech.com/products/PCM-9363/mod_235FB6C7-A605-4230-B8DA-33=
F5B4F6A1AA.aspx
> > *
> > this machine have a hardware watchdog that i want to use it on Debian.
> > these are the output of some command that i think is useful to know:
> > *
> > root@dhcppc2:/home/p# acpi -V
> > No support for device type: power_supply
> > No support for device type: power_supply
> > Cooling 0: Processor 0 of 0
> > Cooling 1: Processor 0 of 0
> >
> > root@dhcppc2:/home/p# modprobe dme1737
> > FATAL: Error inserting dme1737
> > (/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/dme1737.ko): Device o=
r
> > resource busy
> >
> > root@dhcppc2:/home/p# sensors
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Core 0:      +45.0=B0C  (crit =3D +100.0=B0C)
> >
> >
> > *and here is the output of dmesg:*
> > [  403.388163] ACPI: I/O resource dme1737 [0xa70-0xa71] conflicts with
> ACPI
> > region RNTR [0xa00-0xa7f]
> > [  403.388175] ACPI: If an ACPI driver is available for this device, yo=
u
> > should use it instead of the native driver
> >
> > *and when i uncomment this line of /etc/watchdog.conf the machine
> restarts!*
> > #watchdog-device        =3D /dev/watchdog
> >
> > *what's the solution of this problem?
> > thanks :)*
>
> Please see
>
> http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkingin=
kernel2.6.31
>
> Guenter
>

--20cf303dd5a4c7435704c4649fc5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<font color=3D"#000066"><font><font face=3D"tahoma,sans-serif">the same pro=
blem again!</font></font></font><br><br><div class=3D"gmail_quote">On Mon, =
Jul 9, 2012 at 8:20 AM, Guenter Roeck <span dir=3D"ltr">&lt;<a href=3D"mail=
to:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt;</span> =
wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On Sun, Jul 08, 2012 at 12:18:23PM +0430, Mo=
hsen Jamali wrote:<br>
&gt; *1Hi guys :)*<br>
<div class=3D"im">&gt; im using Debian squeeze on this machine :<br>
&gt; <a href=3D"http://www.advantech.com/products/PCM-9363/mod_235FB6C7-A60=
5-4230-B8DA-33F5B4F6A1AA.aspx" target=3D"_blank">http://www.advantech.com/p=
roducts/PCM-9363/mod_235FB6C7-A605-4230-B8DA-33F5B4F6A1AA.aspx</a><br>
&gt; *<br>
&gt; this machine have a hardware watchdog that i want to use it on Debian.=
<br>
&gt; these are the output of some command that i think is useful to know:<b=
r>
&gt; *<br>
&gt; root@dhcppc2:/home/p# acpi -V<br>
&gt; No support for device type: power_supply<br>
&gt; No support for device type: power_supply<br>
&gt; Cooling 0: Processor 0 of 0<br>
&gt; Cooling 1: Processor 0 of 0<br>
&gt;<br>
&gt; root@dhcppc2:/home/p# modprobe dme1737<br>
&gt; FATAL: Error inserting dme1737<br>
&gt; (/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/dme1737.ko): Device =
or<br>
&gt; resource busy<br>
&gt;<br>
&gt; root@dhcppc2:/home/p# sensors<br>
&gt; coretemp-isa-0000<br>
&gt; Adapter: ISA adapter<br>
&gt; Core 0: =A0 =A0 =A0+45.0=B0C =A0(crit =3D +100.0=B0C)<br>
&gt;<br>
&gt;<br>
</div>&gt; *and here is the output of dmesg:*<br>
&gt; [ =A0403.388163] ACPI: I/O resource dme1737 [0xa70-0xa71] conflicts wi=
th ACPI<br>
<div class=3D"im">&gt; region RNTR [0xa00-0xa7f]<br>
&gt; [ =A0403.388175] ACPI: If an ACPI driver is available for this device,=
 you<br>
&gt; should use it instead of the native driver<br>
&gt;<br>
</div>&gt; *and when i uncomment this line of /etc/watchdog.conf the machin=
e restarts!*<br>
&gt; #watchdog-device =A0 =A0 =A0 =A0=3D /dev/watchdog<br>
&gt;<br>
&gt; *what&#39;s the solution of this problem?<br>
&gt; thanks :)*<br>
<br>
Please see<br>
<a href=3D"http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestopped=
workinginkernel2.6.31" target=3D"_blank">http://www.lm-sensors.org/wiki/FAQ=
/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Guenter<br>
</font></span></blockquote></div><br>

--20cf303dd5a4c7435704c4649fc5--


--===============2768306283387014274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2768306283387014274==--
