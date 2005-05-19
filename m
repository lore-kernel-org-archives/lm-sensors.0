From: matthias@hentges.net (Matthias Hentges)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: Ticket 1267
Message-Id: <1055028795.11422.50.camel@mhcln02>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi again,

> try adding 0x24d3 to the supported[] table in i2c-i801.c (2.7.0)
> or to the pci_device_id[] table (CVS, get most recent)
> let us know if it works, email us, ref. your ticket number.

Adding the ID to supported[] did the trick with loading the module.
At least for version 2.7.0, in CVS the modules loads, but the kernel
oopses when running sensors-detect:

Jun  8 00:56:58 mhcln01 kernel: i2c-i801 version 2.8.0-CVS (2003????)
Jun  8 00:56:58 mhcln01 kernel: i2c-dev.o: Registered '' as minor 0
Jun  8 00:57:05 mhcln01 kernel: Unable to handle kernel paging request at v=
irtua
l address 0004002c
Jun  8 00:57:05 mhcln01 kernel:  printing eip:
Jun  8 00:57:05 mhcln01 kernel: f8889b20
Jun  8 00:57:05 mhcln01 kernel: *pde =3D 00000000
Jun  8 00:57:05 mhcln01 kernel: Oops: 0000
Jun  8 00:57:05 mhcln01 kernel: CPU:    0
Jun  8 00:57:05 mhcln01 kernel: EIP:    0010:[<f8889b20>]    Tainted: P=20
Jun  8 00:57:05 mhcln01 kernel: EFLAGS: 00010286
Jun  8 00:57:05 mhcln01 kernel: eax: 00040004   ebx: 00000006   ecx: ffffff=
fb  =20
edx: f888bb3f
Jun  8 00:57:05 mhcln01 kernel: esi: f3282000   edi: 00000000   ebp: 000000=
00  =20
esp: f2833f44
Jun  8 00:57:05 mhcln01 kernel: ds: 0018   es: 0018   ss: 0018
Jun  8 00:57:05 mhcln01 kernel: Process sensors-detect (pid: 7759, stackpag=
e=F28
33000)
Jun  8 00:57:05 mhcln01 kernel: Stack: 00000000 00000c00 f3282000 00001000 =
fffff
fea 00001000 c040b9b4 c015d54a=20
Jun  8 00:57:05 mhcln01 kernel:        f3282000 f2833f98 00000000 00000c00 =
f2833
f94 00000000 00000000 f58c3200=20
:Jun  8 00:57:05 mhcln01 kernel:        ffffffea 00001000 f7188d80 00000000=
 00000
000 00000000 c013b047 f58c3200=20
Jun  8 00:57:05 mhcln01 kernel: Call Trace:    [<c015d54a>] [<c013b047>] [<=
c0108
9d3>]
Jun  8 00:57:05 mhcln01 kernel:=20
Jun  8 00:57:05 mhcln01 kernel: Code: 83 78 28 00 74 1a 83 78 24 00 74 0a 8=
3 c4=20
f8 68 40 bb 88 f8=20


On 2.7.0 sensors-detect finds several chips: two lm75, one pcf?? and two ee=
proms.
The eeprom driver seems to work, but the two lm75 and the pcf?? don't.

Output of sensors-detect:

Next adapter: SMBus I801 adapter at 0400 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):=20
Client found at address 0x08
Client found at address 0x2f
[...]
Client found at address 0x30
Client found at address 0x44
Client found at address 0x48
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x49
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x50
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x52
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x61
Probing for `SMBus 2.0 ARP-Capable Device'... Success!
    (confidence 1, driver `smbus-arp')
Client found at address 0x69

I have tried forcing the w83781d module:
modprobe w83781d force_w83627hf=3D0,0x2f

i2cdump 0 0x2f:

[...]

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 80 00 00 01 00 00 ff    .........?..?...
10: 00 00 7f 00 00 10 00 00 00 00 00 00 00 00 00 00    ..?..?..........
20: 08 02 0d bd 02 02 02 7e ff ff ff 00 00 00 00 e3    ???????~.......?
30: ba cc a8 d8 b2 31 15 40 2c 3c 7f e1 e1 e1 ff ff    ?????1?@,<????..
40: 01 10 00 00 00 00 00 5f 2f 11 01 44 41 95 00 a3    ??....._/??DA?.?
50: ff ff ff ff ff ff 00 00 72 70 ff 00 19 01 05 ff    ........rp..???.
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: 01 ff 01 ff 00 00 00 00 01 01 01 01 3c 3c 0a 0a    ?.?.....????<<??
90: 00 00 00 01 ff 00 00 00 01 01 3c 18 00 00 01 01    ...?....??<?..??
a0: ff ff ff 00 00 00 00 00 19 e7 6f 18 00 ff ff ff    ........??o?....
b0: bc f3 02 ff 30 08 00 03 00 08 ff ff 00 04 ff ff    ???.0?.?.?...?..
c0: 7e 80 00 32 00 3c 00 ff 7e 80 00 32 00 3c 00 ff    ~?.2.<..~?.2.<..
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff 00 ff 00 01 00 ff ff 02 ff 00 00 0d ff 1d    .....?...?...?.?

The driver loads and can be accessed via /proc/sys/dev/sensors/w83627hf-i2c=
-0-2f
but the values are all wrong.

> On the 627THF, I?ll see if it is different than the regular HF if
> I can find a datasheet.
> Try modprobing i2c-isa and w83627hf anyway and see what happens.

w83627hf can not be loaded (no such device).

Looks like the ISA bus can not be accessed.

Looks like i'm out of luck huh?

TIA
--=20

Matthias Hentges=20
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian Woody: Geek by Nature, Linux by Choice

