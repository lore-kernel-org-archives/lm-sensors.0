From: Sergio Cipolla <secipolla@gmail.com>
Date: Sat, 04 Feb 2012 18:24:20 +0000
Subject: [lm-sensors] it87 chip and kernel 3.2.2 issue.
Message-Id: <CANLOsR7+rDwQ6o=UUysYj2bUQmq8aRK6C+khMqAxasyzQZCbLg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6677560175387006103=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============6677560175387006103==
Content-Type: multipart/alternative; boundary=e89a8f646729e42a7704b8278ac2

--e89a8f646729e42a7704b8278ac2
Content-Type: text/plain; charset=ISO-8859-1

Hello, I have a K7VTA3 mobo with an it87 monitoring chip. In spite of
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31
,
sensors work fine here up until kernel 3.2.1 (reporting voltage, all temps
and fans). As soon as the kernel was upgraded to 3.2.2 sensors stopped
working.
I use Debian sid with Debian's 686-pae kernel.
The kernel message for working sensors (up until kernel 3.2.1) says:

Feb  2 08:09:55 debian kernel: [   11.269884] it87: Found IT8705F chip at
0x290, revision 2
Feb  2 08:09:55 debian kernel: [   11.269895] it87: Beeping is supported
Feb  2 08:09:55 debian kernel: [   11.270045] it87 it87.656: Detected
broken BIOS defaults, disabling PWM interface

Then after upgrade to kernel 3.2.2, which break sensors, it says:

Feb  2 13:01:54 debian kernel: [   11.022946] it87: Found IT8705F chip at
0x290, revision 2
Feb  2 13:01:54 debian kernel: [   11.022956] it87: Beeping is supported
Feb  2 13:01:54 debian kernel: [   11.023011] ACPI: resource it87 [io
 0x0295-0x0296] conflicts with ACPI region IP__ [io 0x295-0x296]
Feb  2 13:01:54 debian kernel: [   11.023017] ACPI: If an ACPI driver is
available for this device, you should use it instead of the native driver

This last state seems to match that issue introduced with kernel 2.6.31.
I wrote to the debian-kernel list (
http://lists.debian.org/debian-kernel/2012/02/msg00063.html ) and the
maintainer said no different configuration was introduced and suggested
that I wrote to you.

Do you know why this only showed up with this latest kernel version?
Is it possible for me to re-enable that behaviour which disabled 'PWM
interface' as in the kernel messages from working kernels?
If yes, should I need to recompile it? Or is that the same as the solution
offered in the FAQ (add: "acpi_enforce_resources=lax" to the kernel
cmdline)?

From what I know, the ACPI daemon by default here only monitors the case
power button and it works the same in either kernel 3.2.2 (the one with
it87 disabled) or the earlier ones (I just tested with 3.1.8 that I have
here too).

Any consideration on this subject will be very welcome.

Thank you.

--e89a8f646729e42a7704b8278ac2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello, I have a=A0K7VTA3 mobo with an it87 monitoring chip. In spite of=A0<=
a href=3D"http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedw=
orkinginkernel2.6.31" target=3D"_blank">http://www.lm-sensors.org/wiki/FAQ/=
Chapter3#Mysensorshavestoppedworkinginkernel2.6.31</a>=A0, sensors work fin=
e here up until kernel 3.2.1 (reporting voltage, all temps and fans). As so=
on as the kernel was upgraded to 3.2.2 sensors stopped working.<div>


I use Debian sid with Debian&#39;s 686-pae kernel.</div><div>The kernel mes=
sage for working sensors (up until kernel 3.2.1) says:</div><div><br></div>=
<div><div>Feb =A02 08:09:55 debian kernel: [ =A0 11.269884] it87: Found IT8=
705F chip at 0x290, revision 2</div>


<div>Feb =A02 08:09:55 debian kernel: [ =A0 11.269895] it87: Beeping is sup=
ported</div><div>Feb =A02 08:09:55 debian kernel: [ =A0 11.270045] it87 it8=
7.656: Detected broken BIOS defaults, disabling PWM interface</div></div><d=
iv>

<br>
</div><div>Then after upgrade to kernel 3.2.2, which break sensors, it says=
:</div><div><br></div><div><div>Feb =A02 13:01:54 debian kernel: [ =A0 11.0=
22946] it87: Found IT8705F chip at 0x290, revision 2</div><div>Feb =A02 13:=
01:54 debian kernel: [ =A0 11.022956] it87: Beeping is supported</div>


<div>Feb =A02 13:01:54 debian kernel: [ =A0 11.023011] ACPI: resource it87 =
[io =A00x0295-0x0296] conflicts with ACPI region IP__ [io 0x295-0x296]</div=
><div>Feb =A02 13:01:54 debian kernel: [ =A0 11.023017] ACPI: If an ACPI dr=
iver is available for this device, you should use it instead of the native =
driver</div>


</div><div><br></div><div>This last state seems to match that issue introdu=
ced with kernel 2.6.31.</div><div>I wrote to the debian-kernel list (=A0<a =
href=3D"http://lists.debian.org/debian-kernel/2012/02/msg00063.html" target=
=3D"_blank">http://lists.debian.org/debian-kernel/2012/02/msg00063.html</a>=
=A0) and the maintainer said no different configuration was introduced and =
suggested that I wrote to you.</div>


<div><br></div><div>Do you know why this only showed up with this latest ke=
rnel version?</div><div>Is it possible for me to re-enable that behaviour w=
hich disabled &#39;PWM interface&#39; as in the kernel messages from workin=
g kernels?</div>


<div>If yes, should I need to recompile it? Or is that the same as the solu=
tion offered in the FAQ (add: &quot;acpi_enforce_resources=3Dlax&quot; to t=
he kernel cmdline)?</div><div><br></div><div>From what I know, the ACPI dae=
mon by default here only monitors the case power button and it works the sa=
me in either kernel 3.2.2 (the one with it87 disabled) or the earlier ones =
(I just tested with 3.1.8 that I have here too).</div>

<div><br></div><div>Any consideration on this subject will be very welcome.=
</div><div><br></div><div>Thank you.</div>

--e89a8f646729e42a7704b8278ac2--


--===============6677560175387006103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6677560175387006103==--
