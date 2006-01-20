From: adobin@gmail.com (Alexander Dobin)
Date: Fri, 20 Jan 2006 03:33:52 +0000
Subject: [lm-sensors] wrong readings for w83627ehf on p5mt-m
Message-Id: <aaa5cd0c0601191933h7bf5061eh887f0bc950cfdbde@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <aaa5cd0c0601131819j5692f460yb447692c03341732@mail.gmail.com>
In-Reply-To: <aaa5cd0c0601131819j5692f460yb447692c03341732@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, Jean,

thanks a lot for your help!
No good news, I am afraid.

Here are some outputs you requested:

isadump -k 0x87,0x87 0x2e 0x2f 0xb

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff 0b ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 88 54 ff 00 44 00 00 ff 50 04 00 00 fb 21 00 ff
30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: 02 90 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: 11 3f ff ff ff ff ff ff ff ff ff ff ff ff ff ff
I have added settings for fans in the sensors.config file, but to no avail:
w83627ehf-isa-0290
Adapter: ISA adapter
fan1:        0 RPM  (min = 1004 RPM, div = 16)
fan2:        0 RPM  (min = 1004 RPM, div = 16)
fan3:        0 RPM  (min = 1004 RPM, div = 16)
fan4:        0 RPM  (min = 1004 RPM, div = 16)
temp1:       -48?C  (high =    +0?C, hyst =   +64?C)
temp2:     -48.0?C  (high = +80.0?C, hyst = +75.0?C)
temp3:     -48.0?C  (high = +80.0?C, hyst = +75.0?C)
I have two fans, CPU Fan1 and CPU Fan2, with
BIOS reporting 2500 and 2300 rpms.

Oddly, when I run 'sensors' consequently the min and div values change until
they saturate on th 4th time:
fan1:        0 RPM  (min = 1054 RPM, div = 128)
fan2:        0 RPM  (min = 1054 RPM, div = 128)
fan3:        0 RPM  (min = 1054 RPM, div = 128)
fan4:        0 RPM  (min = 1054 RPM, div = 128)
temp1:       -48?C  (high =    +0?C, hyst =   +64?C)
temp2:     -48.0?C  (high = +80.0?C, hyst = +75.0?C)
temp3:     -48.0?C  (high = +80.0?C, hyst = +75.0?C)

Also tried:
isaset 0x295 0x296 0x4e 0x00
isaset 0x295 0x296 0x59 0x00
1st line went in OK, for the second I got:
Data mismatch, wrote 0x00, read 0xff back.
I still tried sensors after that:

fan1:        0 RPM  (min = 1004 RPM, div = 32)
fan2:        0 RPM  (min = 1004 RPM, div = 32)
fan3:        0 RPM  (min = 1004 RPM, div = 32)
fan4:        0 RPM  (min = 1004 RPM, div = 32)
temp1:       -48?C  (high =    +0?C, hyst =   +64?C)
temp2:     -48.0?C  (high = +80.0?C, hyst = +75.0?C)
temp3:     -48.0?C  (high = +80.0?C, hyst = +75.0?C)

Also tried:
isaset 0x295 0x296 0x5d 0x07
Got:
Data mismatch, wrote 0x07, read 0xff back.
This changed the sensors output like this:
fan1:        0 RPM  (min = 16071 RPM, div = 4)
fan2:        0 RPM  (min = 16071 RPM, div = 4)
fan3:        0 RPM  (min = 16071 RPM, div = 4)
fan4:        0 RPM  (min = 1004 RPM, div = 64)
temp1:      +127?C  (high =    +0?C, hyst =   +64?C)
temp2:    +127.5?C  (high = +80.0?C, hyst = +75.0?C)
temp3:     -48.0?C  (high = +80.0?C, hyst = +75.0?C)
In this configuration, weirdly, as I put some load on, the temps did not
change, however the min and div values for fans jumped around.

I rebooted to get to the initial state.
and now while idling: isadump 0x295 0x296
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 bf 01 bf 01 00 00 00 01 01 01 01 3c 3c 0a 0a
10: 01 bf 00 00 00 01 01 3c 43 00 ff ff 24 32 00 de
20: db a5 d4 d3 c7 c5 ef d0 ff ff ff e7 00 08 00 04
30: 02 00 80 90 48 29 00 01 02 00 40 0a 0a 0a 0a ff
40: 03 cf 0f de ff 00 03 f4 2d 44 01 c4 90 95 00 a3
50: ff ff 80 ff ff ff 00 80 88 73 ff ff 19 e0 ff 05
60: db a5 d4 d3 c7 c5 ef d0 ff ff ff e7 00 08 00 04
70: 02 00 80 90 48 29 00 01 02 00 40 0a 0a 0a 0a ff
80: 01 bf 01 bf 01 00 00 00 01 01 01 01 3c 3c 0a 0a
90: 01 bf 00 00 00 01 01 3c 43 00 ff ff 24 32 00 de
a0: db a5 d4 d3 c7 c5 ef d0 ff ff ff e7 00 08 00 04
b0: 02 00 80 90 48 29 00 01 02 00 40 0a 0a 0a 0a ff
c0: 03 00 00 de ff 00 03 f4 2d 44 01 c4 90 95 00 a3
d0: ff ff 80 ff ff ff 00 80 88 73 ff ff 19 e0 ff 05
e0: db a5 d4 d3 c7 c5 ef d0 ff ff ff e7 00 08 00 04
f0: 02 00 80 90 48 29 00 01 02 00 40 0a 0a 0a 0a ff
At full load:
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 bf 01 bf 01 00 00 00 01 01 01 01 3c 3c 0a 0a
10: 01 bf 00 00 00 01 01 3c 43 00 ff ff 24 32 00 de
20: d9 a3 d4 d2 c6 c3 ed d0 ff ff ff e7 00 08 00 04
30: 02 00 80 90 48 29 00 01 02 00 40 0a 0a 0a 0a ff
40: 03 00 00 de ff 00 03 f4 2d 44 01 c4 90 95 00 a3
50: ff ff 80 ff ff ff 00 80 88 73 ff ff 19 e0 ff 05
60: d9 a3 d4 d2 c6 c3 ed d0 ff ff ff e7 00 08 00 04
70: 02 00 80 90 48 29 00 01 02 00 40 0a 0a 0a 0a ff
80: 01 bf 01 bf 01 00 00 00 01 01 01 01 3c 3c 0a 0a
90: 01 bf 00 00 00 01 01 3c 43 00 ff ff 24 32 00 de
a0: d9 a3 d4 d2 c6 c3 ed d0 ff ff ff e7 00 08 00 04
b0: 02 00 80 90 48 29 00 01 02 00 40 0a 0a 0a 0a ff
c0: 03 00 00 de ff 00 03 f4 2d 44 01 c4 90 95 00 a3
d0: ff ff 80 ff ff ff 00 80 88 73 ff ff 19 e0 ff 05
e0: d9 a3 d4 d2 c6 c3 ed d0 ff ff ff e7 00 08 00 04
f0: 02 00 80 90 48 29 00 01 02 00 40 0a 0a 0a 0a ff

I had to get rid of Windows - will put it back and report SpeedFan and ASUS
numbers hopefully tomorrow.
The BIOS actually supports ACPI and SpeedFan could only report CPU and MB
temperature, so it could have been ACPI - will check tomorrow.
ACPI under Linux does not work apparently - no information on T or fans.
The BIOS reports:

CPU Temp
MB  Temp

CPU Fan1
CPU Fan2
Front Fan1
Front Fan2
Rear Fan1
Rear Fan2

Smart Fan Disabled

VCORE
3.3V
5V
5VSB
VBA
12V

I will be happy to try the patch for voltages or any other things you
suggest,
but I will need instructions since I am not fluent in this stuff.

Thanks a lot again for your interest and help,

Have a good weekend,
Alex


8/06, Jean Delvare <khali at linux-fr.org> wrote:
> Hi Alexander,
>
> > I have kernel 2.6.14 and have installed lm_sensors 2.9.2
> >
> > sensors-detect find the chip (see the output below), and after all the
> > suggested steps,
> > sensors output is apparently nothing for fans and temps (see below).
> >
> > I will be happy to quickly provide any additional information if any of
> > developers decide to resolve this problem.
>
> Please provide the output of:
> isadump -k 0x87,0x87 0x2e 0x2f 0xb
>
> I want to check the value of registers 0x22, which may be used to shut
> down the hardware monitoring part of the device, and 0x30, which may
> disable that part. I guess that you wouldn't even be able to dump the
> device contents if it was shut down or disabled, but it doesn't hurt to
> make sure.
>
> > sensors output:
> >
> > w83627ehf-isa-0290
> > Adapter: ISA adapter
> > fan1:        0 RPM  (min = 10546 RPM, div = 128)
> > fan2:        0 RPM  (min =    0 RPM, div = 128)
> > fan3:        0 RPM  (min =    0 RPM, div = 128)
> > fan4:        0 RPM  (min = 10546 RPM, div = 128)
> > temp1:       -48?C  (high =    +0?C, hyst =   +64?C)
> > temp2:     -48.0?C  (high = +80.0?C, hyst = +75.0?C)
> > temp3:     -48.0?C  (high = +80.0?C, hyst = +75.0?C)
>
> For fans, try setting the limits to something reasonable like 1000 RPM.
> It might help.
>
> For temperatures, try:
> isaset 0x295 0x296 0x4e 0x00
> isaset 0x295 0x296 0x59 0x00
> This will change the diode measurement type from Pentium II to 2N3904.
> Maybe you'll have different readings after that. If it doesn't help,
> try:
> isaset 0x295 0x296 0x5d 0x07
> This will change the measurement mode from diode to thermistor. This
> should change the reported values, although I can't promise the new
> values will make more sense than the old ones.
>
> Ideally, the driver should at least report the currently selected
> thermal sensor type, and may even let the user change it to workaround
> broken BIOSes. The w83627ehf driver is still in a preliminary stage
> though.
>
> We have a patch floating around which adds voltage input support to the
> driver. Do you want to give it a try? Maybe you'll be more lucky with
> voltages than with fans and temperatures. The dump you provided
> elsewhere in this thread shows that at least some voltage values make
> sense.
>
> --
> Jean Delvare
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060120/482acef9/attachment-0001.html
