From: Zhong <alex_jame_mick@yahoo.com>
Date: Wed, 24 Oct 2012 14:04:41 +0000
Subject: [lm-sensors] High pci adapter temperature
Message-Id: <66352E8F-0EC7-454E-91CB-296A1CA83DD5@yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2041127328165715166=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============2041127328165715166==
Content-Type: multipart/alternative;
	boundary=Apple-Mail-1--881868952
Content-Transfer-Encoding: 7bit


--Apple-Mail-1--881868952
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi,

I have recently installed Debian Squeeze on my Hp Pavilion dv6 dual booting w=
ith Windows 7, and am
experiencing heat problems with the temperature readings produced by
lm-sensors:=20

root at debian:/home/zhong# sensors -f
k10temp-pci-00c3
Adapter: PCI adapter
temp1:      +164.3=C2=B0F  (high =3D +158.0=C2=B0F, crit =3D +239.9=C2=B0F) =
=20

The problem never appears in Windows.


Here's the detection result:=20

root at debian:/home/zhong# sensors-detect
# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
# System: Hewlett-Packard HP Pavilion dv6 Notebook PC (laptop)
# Board: Hewlett-Packard 143F

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): y
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           Success!
    (driver `k10temp')
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         No
Intel Atom thermal sensor...                                No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): y
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): y
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): y
Using driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies Inc SB600=
/SB700/SB800 SMBus
Module i2c-dev loaded successfully.

Next adapter:  (i2c-0)
Do you want to scan it? (YES/no/selectively): y

Next adapter:  (i2c-1)
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x28
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG/W83667HG/W83677HG'...        No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Analog Devices ADM1029'...                     No
Probing for `ITE IT8712F'...                                No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 yNo
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)

Next adapter:  (i2c-2)
Do you want to scan it? (YES/no/selectively):=20

Now follows a summary of the probes I have just done.
Just press ENTER to continue:=20

Driver `k10temp' (autoloaded):
  * Chip `AMD Family 10h thermal sensors' (confidence: 9)

No modules to load, skipping modules configuration.

Unloading i2c-dev... OK

I've researched this issue multiple times and find varied possible solutions=
. However, when regarding about the open source radeon driver, people tend t=
o agree that the driver has poor power management and prefer switching to fg=
lrx. I, on the other hand would much co-reside on this driver if I can confi=
gure the device, but the xorg config  cannot be find due to Debian removing t=
his file on its release of Squeeze.=20

I'm just listing the most probable clues here, but like to hear what others w=
ould say.


--Apple-Mail-1--881868952
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><body bgcolor=3D"#FFFFFF"><span class=3D"Apple-style-span" style=3D"fo=
nt-family: Times; -webkit-tap-highlight-color: rgba(26, 26, 26, 0.296875); -=
webkit-composition-fill-color: rgba(175, 192, 227, 0.230469); -webkit-compos=
ition-frame-color: rgba(77, 128, 180, 0.230469); font-size: medium; "><pre s=
tyle=3D"white-space: pre-wrap; ">Hi,

I have recently installed Debian Squeeze on my Hp Pavilion dv6 dual booting w=
ith Windows 7, and am
experiencing heat problems with the temperature readings produced by
lm-sensors:&nbsp;

<a href=3D"http://lists.x.org/mailman/listinfo/xorg-driver-ati">root at debi=
an</a>:/home/zhong# sensors -f
k10temp-pci-00c3
Adapter: PCI adapter
temp1: &nbsp; &nbsp; &nbsp;+164.3=C2=B0F &nbsp;(high =3D +158.0=C2=B0F, crit=
 =3D +239.9=C2=B0F) &nbsp;

The problem never appears in Windows.


Here's the detection result:&nbsp;

<a href=3D"http://lists.x.org/mailman/listinfo/xorg-driver-ati">root at debi=
an</a>:/home/zhong# sensors-detect
# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
# System: Hewlett-Packard HP Pavilion dv6 Notebook PC (laptop)
# Board: Hewlett-Packard 143F

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): y
Silicon Integrated Systems SIS5595... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; No
VIA VT82C686 Integrated Sensors... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;No
VIA VT8231 Integrated Sensors... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;No
AMD K8 thermal sensors... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; No
AMD Family 10h thermal sensors... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Success!
&nbsp; &nbsp; (driver `k10temp')
AMD Family 11h thermal sensors... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; No
Intel Core family thermal sensor... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; No
Intel Atom thermal sensor... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;No
Intel AMB FB-DIMM thermal sensor... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; No
VIA C7 thermal sensor... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;No=

VIA Nano thermal sensor... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): y
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; No
Trying family `SMSC'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; No=

Trying family `VIA/Winbond/Nuvoton/Fintek'... &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; No
Trying family `ITE'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; No
Trying family `SMSC'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; No=

Trying family `VIA/Winbond/Nuvoton/Fintek'... &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; No
Trying family `ITE'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): y
Probing for `National Semiconductor LM78' at 0x290... &nbsp; &nbsp; &nbsp; N=
o
Probing for `National Semiconductor LM79' at 0x290... &nbsp; &nbsp; &nbsp; N=
o
Probing for `Winbond W83781D' at 0x290... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; No
Probing for `Winbond W83782D' at 0x290... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): y
Using driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies Inc SB600=
/SB700/SB800 SMBus
Module i2c-dev loaded successfully.

Next adapter: &nbsp;(i2c-0)
Do you want to scan it? (YES/no/selectively): y

Next adapter: &nbsp;(i2c-1)
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x28
Probing for `National Semiconductor LM78'... &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp;No
Probing for `National Semiconductor LM79'... &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp;No
Probing for `National Semiconductor LM80'... &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp;No
Probing for `Winbond W83781D'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;No
Probing for `Winbond W83782D'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;No
Probing for `Winbond W83627HF'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; No
Probing for `Winbond W83627EHF'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;No
Probing for `Winbond W83627DHG/W83667HG/W83677HG'... &nbsp; &nbsp; &nbsp; &n=
bsp;No
Probing for `Asus AS99127F (rev.1)'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;No
Probing for `Asus AS99127F (rev.2)'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;No
Probing for `Asus ASB100 Bach'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; No
Probing for `Analog Devices ADM1029'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; No
Probing for `ITE IT8712F'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;No
Client found at address 0x50
Probing for `Analog Devices ADM1033'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; No
Probing for `Analog Devices ADM1034'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; No
Probing for `SPD EEPROM'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; yNo
Probing for `EDID EEPROM'... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Yes
&nbsp; &nbsp; (confidence 8, not a hardware monitoring chip)

Next adapter: &nbsp;(i2c-2)
Do you want to scan it? (YES/no/selectively):&nbsp;

Now follows a summary of the probes I have just done.
Just press ENTER to continue:&nbsp;

Driver `k10temp' (autoloaded):
&nbsp; * Chip `AMD Family 10h thermal sensors' (confidence: 9)

No modules to load, skipping modules configuration.

Unloading i2c-dev... OK

I've researched this issue multiple times and find varied possible solutions=
. However, when regarding about the open source radeon driver, people tend t=
o agree that the driver has poor power management and prefer switching to fg=
lrx. I, on the other hand would much co-reside on this driver if I can confi=
gure the device, but the xorg config&nbsp; cannot be find due to Debian remo=
ving this file on its release of Squeeze.=20

I'm just listing the most probable clues here, but like to hear what others w=
ould say.
</pre><div><br></div></span><div><span></span></div></body></html>=

--Apple-Mail-1--881868952--


--===============2041127328165715166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2041127328165715166==--
