From: Stevie Trujillo <stevie.trujillo@gmail.com>
Date: Wed, 11 Jul 2012 14:16:21 +0000
Subject: [lm-sensors] (no subject)
Message-Id: <CAJiZuY2YWfcsapHc+rbfc4Lqb7CoTjExva4fqx6xuxB8SVQrAA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200703231349.l2NDnj1q025087@whb1.seed.net.tw>
In-Reply-To: <200703231349.l2NDnj1q025087@whb1.seed.net.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello, thank you for helping me! I'm sorry that I was so slow. My
loglevel was wrong so I started messing with netconsole.

I tested this with 3.4.4 kernel. I realized that your module seems to
be from git version of kernel, it compiled without errors tho. I can
try compile git kernel if that's better!

On 2012-07-11 15:26, Jean Delvare wrote:
> On Tue, 10 Jul 2012 16:24:55 +0200, Stevie Trujillo wrote:
>> I have a Gigabyte GA-Z77X-UD3H motherboard with a 3570k CPU and 32GiB ra=
m.
>>   * ISA bus, address 0xa30
>>     Chip `ITE IT8728F Super IO Sensors' (confidence: 9)
>>
>> I run Gentoo with linux-3.4.4, if I do "modprobe it87" the system freeze=
s.
>> I was told GA-Z77X-D3H (not UD3H) works in Debian Squeeze with 3.2
>> kernel from Debian backports.
>> I installed Squeeze, for me it freezes there too:
>>
>> # modprobe it87
>> it87: Found IT8728F chip at 0xa30, revision 1
>> it87: Beeping is supported
>> * here it froze*
>
> Very odd. I think this is the first report of that kind. You are not
> booting with acpi_enforce_resources=3Dlax or =3Dno, are you?

I only have root=3D and ro
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-3.4.4 root=3D/dev/... ro

But I forgot to mention these lines
[    6.634492] ACPI Warning: 0x000000000000f040-0x000000000000f05f
SystemIO conflicts with Region \_SB_.PCI0.SBUS.SMBI 1
(20120320/utaddress-251)
[    6.634496] ACPI: If an ACPI driver is available for this device,
you should use it instead of the native driver

and that i tried booting with something like "noacpi acpi=3Doff", but it
still froze.

>> How can I fix/debug this?
>
> I have no immediate idea. Please check in /proc/ioports if you see
> anything suspicious at address 0xa30.

$ cat /proc/ioports
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0064-0064 : keyboard
  0070-0077 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  0200-020f : pnp 00:05
  03c0-03df : vga+
  0400-0453 : pnp 00:05
    0400-0403 : ACPI PM1a_EVT_BLK
    0404-0405 : ACPI PM1a_CNT_BLK
    0408-040b : ACPI PM_TMR
    0410-0415 : ACPI CPU throttle
    0420-042f : ACPI GPE0_BLK
    0450-0450 : ACPI PM2_CNT_BLK
  0454-0457 : pnp 00:07
  0458-047f : pnp 00:05
  04d0-04d1 : pnp 00:09
  0500-057f : pnp 00:05
  0680-069f : pnp 00:05
  0a00-0a0f : pnp 00:08
  0a20-0a2f : pnp 00:08
  0a30-0a3f : pnp 00:08
    0a35-0a36 : it87
      0a35-0a36 : it87
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  164e-164f : pnp 00:05
  c000-cfff : PCI Bus 0000:07
    c000-c00f : 0000:07:00.0
      c000-c00f : ahci
    c010-c013 : 0000:07:00.0
      c010-c013 : ahci
    c020-c027 : 0000:07:00.0
      c020-c027 : ahci
    c030-c033 : 0000:07:00.0
      c030-c033 : ahci
    c040-c047 : 0000:07:00.0
      c040-c047 : ahci
  d000-dfff : PCI Bus 0000:06
    d000-d07f : 0000:06:00.0
      d000-d07f : atl1c
  e000-efff : PCI Bus 0000:02
    e000-e01f : 0000:02:00.0
  f000-f03f : 0000:00:02.0
  f040-f05f : 0000:00:1f.3
  f060-f07f : 0000:00:1f.2
    f060-f07f : ahci
  f080-f083 : 0000:00:1f.2
    f080-f083 : ahci
  f090-f097 : 0000:00:1f.2
    f090-f097 : ahci
  f0a0-f0a3 : 0000:00:1f.2
    f0a0-f0a3 : ahci
  f0b0-f0b7 : 0000:00:1f.2
    f0b0-f0b7 : ahci
  ffff-ffff : pnp 00:05
    ffff-ffff : pnp 00:05

>
> I have added a module parameter to the it87 driver. The updated driver
> is here:
>   http://khali.linux-fr.org/devel/misc/it87/
> Build instructions are at:
>   http://khali.linux-fr.org/devel/misc/INSTALL
>
> You can load this it87 driver with write=3D0 to disable all register
> writes. This will tell us if at least the driver works when not writing
> to registers (I expect so.)

You are correct! No freeze and the values looks kinda sane.
# sensors
coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +37.0=B0C  (high =3D +85.0=B0C, crit =3D +105.0=B0C)
Core 0:         +36.0=B0C  (high =3D +85.0=B0C, crit =3D +105.0=B0C)
Core 1:         +37.0=B0C  (high =3D +85.0=B0C, crit =3D +105.0=B0C)
Core 2:         +34.0=B0C  (high =3D +85.0=B0C, crit =3D +105.0=B0C)
Core 3:         +36.0=B0C  (high =3D +85.0=B0C, crit =3D +105.0=B0C)

acpitz-virtual-0
Adapter: Virtual device
temp1:        +27.8=B0C  (crit =3D +106.0=B0C)
temp2:        +29.8=B0C  (crit =3D +106.0=B0C)

it8728-isa-0a30
Adapter: ISA adapter
in0:          +1.06 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in1:          +2.05 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in2:          +2.03 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in3:          +1.99 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in4:          +0.00 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in5:          +0.84 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in6:          +1.51 V  (min =3D  +0.00 V, max =3D  +3.06 V)
3VSB:         +3.38 V  (min =3D  +0.00 V, max =3D  +6.12 V)
Vbat:         +3.26 V
fan1:         982 RPM  (min =3D    0 RPM)
fan2:           0 RPM  (min =3D    0 RPM)
fan3:           0 RPM  (min =3D    0 RPM)
fan4:           0 RPM  (min =3D    0 RPM)
fan5:           0 RPM  (min =3D    0 RPM)
temp1:        +35.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D
thermistor
temp2:        +44.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D
thermistor
temp3:        +30.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D
disabled
intrusion0:  ALARM

> If that works, then please unload the driver and reload with write=3D2.
> This will log every register write right before it happens. So the last
> message logged is likely to point to a register write which is
> inappropriate for your device/board.

I only see these lines:
[  265.408976] it87: Found IT8728F chip at 0xa30, revision 1
[  265.410655] it87: Beeping is supported
[  265.411583] it87: Writing value 0x37 to register 0x0c
[  265.423124] it87: Writing value 0x13 to register 0x00

--
Stevie Trujillo

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
