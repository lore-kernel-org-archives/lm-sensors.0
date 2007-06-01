From: "Juerg Haefliger" <juergh@gmail.com>
Date: Fri, 01 Jun 2007 15:59:32 +0000
Subject: Re: [lm-sensors] Intel SRSH4 Motherboard Sensors
Message-Id: <191fb4ca0706010859u3c573fb4sd2ac348c5f07244f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <465336B0.2030304@ucar.edu>
In-Reply-To: <465336B0.2030304@ucar.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Keith,

On 5/31/07, KEITH ROMBERG <k_romberg@msn.com> wrote:
> Hey Juerg,
>
> OK, I also loaded ipmi_msghandler as I was not loading it before.  I am n=
ot
> loading these modules in my rc.local file:
>
> i2c-piix4
> i2c-ipmi
> eeprom
> ipmisensors
> ipmi_msghandler
> hwmon

You should load ipmi_msghandler and hwmon first, ipmisensors depends on the=
m.


> in that order.  Looking at /sys/classes, it is empty.

That;s unlikely. There should be lots of stuff in /sys/classes. What
about /sys/classes/hwmon?


> When I manually load
> the modules, via rmmod & modprobe, and look at /var/log/messages the only
> entries are:
>
> May 31 15:01:26 smaug kernel: ipmi message handler version 39.1
> May 31 15:01:26 smaug kernel: ipmisensors - IPMI BMC sensors interface

Hmm... That doesn't look good. Can you try to just modprobe
ipmi_msghandler? You should see something like the following in the
log. It almost looks like ipmi doens't find a BMC on your system. And
could you please send the output of lsmod to the list?

May 30 14:51:54 clim1 kernel: ipmi message handler version 39.0
May 30 14:51:54 clim1 kernel: IPMI System Interface driver.
May 30 14:51:54 clim1 kernel: ipmi_si: Trying SMBIOS-specified KCS
state machine at I/O address 0xca2, slave address 0x20, irq 0
May 30 14:51:54 clim1 kernel: ipmi: Found new BMC (man_id: 0x00000b,
prod_id: 0x0000, dev_id: 0x11)
May 30 14:51:54 clim1 kernel:  IPMI KCS interface initialized
May 30 14:51:54 clim1 kernel: ipmi_si: Trying ACPI-specified KCS state
machine at memory address 0xca2, slave address 0x0, irq 0
May 30 14:51:54 clim1 kernel:  Could not set up I/O space
May 30 14:51:54 clim1 kernel: Trying to free nonexistent resource
<0000000000000ca2-0000000000000ca3>
May 30 14:51:54 clim1 kernel: Trying to free nonexistent resource
<0000000000000ca4-0000000000000ca5>
May 30 14:51:54 clim1 kernel: GSI 27 sharing vector 0xA2 and IRQ 27
May 30 14:51:54 clim1 kernel: ACPI: PCI Interrupt 0000:00:04.6[A] ->
GSI 46 (level, low) -> IRQ 162
May 30 14:51:54 clim1 kernel: ipmi_si: Trying PCI-specified KCS state
machine at memory address 0xf5ef0000, slave address 0x0, irq 162
May 30 14:51:54 clim1 kernel:   Using irq 162
May 30 14:51:54 clim1 kernel: ipmi: interfacing existing BMC (man_id:
0x00000b, prod_id: 0x0000, dev_id: 0x11)
May 30 14:51:54 clim1 kernel:  IPMI KCS interface initialized
May 30 14:51:54 clim1 kernel: ipmi device interface


>
> As I said before I am using 2.6.21 patched with the experimential ipmi
> patch.  Juerg what kernel are you using and do you also have a SRSH4 based
> system?  Any other pointers are things to try?

I'm running 2.6.20.9 with the experimental ipmisensors patch on an HP
DL385G2. This is not an SRSH4 based system.

...juerg


> Thanks,
> Keith
>
> >
> >Keith,
> >
> >Make sure you have the ipmisensors and ipmi_msghandler modules
> >installed. Check if there are any entries under /sys/class/hwmon.
> >Check /var/log/messages, it should read something like the following
> >after loading the ipmisensors module:
> >
> >May 30 14:37:54 clim1 kernel: ipmisensors - IPMI BMC sensors interface
> >May 30 14:37:54 clim1 kernel: ipmisensors: Registered IPMI 2.0 BMC
> >over interface 0
> >May 30 14:37:54 clim1 kernel: ipmisensors: Skipping SDR type 0xc0
> >May 30 14:37:54 clim1 kernel: ipmisensors: Skipping SDR type 0x8
> >May 30 14:37:54 clim1 kernel: ipmisensors: skipping non-threshold sensor
> >"Fan 1"
> >May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor
> >"Fan 2"
> >May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor
> >"Fan 3"
> >May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor
> >"Fan 4"
> >May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor
> >"Fan 5"
> >May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor
> >"Fan 6"
> >May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor
> >"Fan 7"
> >May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor
> >"Fan 8"
> >May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor
> >"Fan 9"
> >May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold
> >sensor "Fan 10"
> >May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold
> >sensor "Fan 11"
> >May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold
> >sensor "Fan 12"
> >May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor
> >"Fans"
> >May 30 14:37:55 clim1 kernel: ipmisensors: Skipping SDR type 0x8
> >May 30 14:37:55 clim1 kernel: ipmisensors: all sensors detected
> >May 30 14:37:55 clim1 kernel: ipmisensors: registering sensor 27:
> >(type 0x01) (fmt=3D0; m=3D1; b=3D0; k1=3D0; k2=3D0; cap=3D0xc9; mask=3D0=
x0030)
> >May 30 14:37:55 clim1 kernel: ipmisensors: sensors.conf: label temp1 "Te=
mp
> >6"
> >May 30 14:37:55 clim1 kernel: ipmisensors: using upper critical
> >threshold for upper limit
> >May 30 14:37:55 clim1 kernel: ipmisensors: registering sensor 26:
> >(type 0x01) (fmt=3D0; m=3D1; b=3D0; k1=3D0; k2=3D0; cap=3D0xc9; mask=3D0=
x0030)
> >May 30 14:37:55 clim1 kernel: ipmisensors: sensors.conf: label temp2 "Te=
mp
> >5"
> >May 30 14:37:55 clim1 kernel: ipmisensors: using upper critical
> >threshold for upper limit
> >May 30 14:37:55 clim1 kernel: ipmisensors: registering sensor 25:
> >(type 0x01) (fmt=3D0; m=3D1; b=3D0; k1=3D0; k2=3D0; cap=3D0xc9; mask=3D0=
x0030)
> >May 30 14:37:55 clim1 kernel: ipmisensors: sensors.conf: label temp3 "Te=
mp
> >4"
> >May 30 14:37:55 clim1 kernel: ipmisensors: using upper critical
> >threshold for upper limit
> >May 30 14:37:55 clim1 kernel: ipmisensors: registering sensor 24:
> >(type 0x01) (fmt=3D0; m=3D1; b=3D0; k1=3D0; k2=3D0; cap=3D0xc9; mask=3D0=
x0030)
> >May 30 14:37:55 clim1 kernel: ipmisensors: sensors.conf: label temp4 "Te=
mp
> >3"
> >May 30 14:37:55 clim1 kernel: ipmisensors: using upper critical
> >threshold for upper limit
> >May 30 14:37:55 clim1 kernel: ipmisensors: registering sensor 23:
> >(type 0x01) (fmt=3D0; m=3D1; b=3D0; k1=3D0; k2=3D0; cap=3D0xc9; mask=3D0=
x0030)
> >May 30 14:37:55 clim1 kernel: ipmisensors: sensors.conf: label temp5 "Te=
mp
> >2"
> >May 30 14:37:55 clim1 kernel: ipmisensors: using upper critical
> >threshold for upper limit
> >May 30 14:37:55 clim1 kernel: ipmisensors: registering sensor 22:
> >(type 0x01) (fmt=3D0; m=3D1; b=3D0; k1=3D0; k2=3D0; cap=3D0xc9; mask=3D0=
x0030)
> >May 30 14:37:55 clim1 kernel: ipmisensors: sensors.conf: label temp6 "Te=
mp
> >1"
> >May 30 14:37:55 clim1 kernel: ipmisensors: using upper critical
> >threshold for upper limit
> >May 30 14:37:55 clim1 kernel: ipmisensors: registered 6 temp, 0 volt,
> >0 current, 0 fan sensors
> >
> >
> >Running sensors works fine for me:
> >
> >clim1:~# sensors
> >bmc-isa-0000
> >Adapter: ISA adapter
> >temp1:      +0.0=B0C  (high =3D    +7=B0C, hyst =3D    +0=B0C)
> >temp2:     +44.0=B0C  (high =3D    +6=B0C, hyst =3D    +0=B0C)
> >temp3:     +40.0=B0C  (high =3D    +6=B0C, hyst =3D    +0=B0C)
> >temp4:     +31.0=B0C  (high =3D   +10=B0C, hyst =3D    +0=B0C)
> >temp5:      +0.0=B0C  (high =3D   +10=B0C, hyst =3D    +0=B0C)
> >temp6:     +18.0=B0C  (high =3D    +4=B0C, hyst =3D    +0=B0C)
> >
> >
> >...juerg
> >
> >
> >
>
>
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
