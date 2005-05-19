From: warp-9.9@usa.net (Leif W)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support DB Entry 1770
Message-Id: <007901c4976a$ac5dc310$0a01a8c0@enterprise>
List-Id: <lm-sensors.vger.kernel.org>
References: <007201c49733$ef934970$0a01a8c0@enterprise>
In-Reply-To: <007201c49733$ef934970$0a01a8c0@enterprise>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

BTW Thanks a lot for the support!

> ----- Original Message ----- 
> From: "Jean Delvare" <khali@linux-fr.org>
> To: "Leif W" <warp-9.9@usa.net>
> Cc: <sensors@Stimpy.netroedge.com>
> Sent: Friday, September 10, 2004 10:20
> Subject: Re: Support DB Entry 1770
>

> On Fri, 10 Sep 2004 08:44:35 -0400, Leif W wrote
>
> > In "sensors.conf" I have tried 'chip "w83781d-*"' and 'chip
> > "w83781d-isa-*"', but running "sensors" says "No sensors found!".
>
> It shouldn't make any difference, both should work equally well (for
the ISA
> mode). However, note that the existence of these sections in the
configuration
> file is completely unrelated to the fact that "sensors" will find it
or not.

Ok, I tried with an empty conf file, and see the same information, but
not labelled, computed or ignored.  So if I mislabel something in the
config such that a matching chip or adapter is not found, sensors
(sensord, libsensors, etc.) will just display the raw data.
sensors.conf is more of an output format specifier, not a device access
configuration.  Understood.

> > Loaded modules are: w83781d, i2c_sensor, i2c_isa, i2c_core.
>
> Sounds OK.
>
> > I also tried with i2c_dev loaded, same result.
>
> No surprise. i2c-dev is meant for raw access to the busses from user
space.
> i2cdetect and i2cdump use it, but "sensors" doesn't (reads from
procfs/sysfs
> instead).

The procfs entries do not appear (maybe applied only to kernel 2.4), and
the sysfs entries are (I think, I can't remember) in a different
location than documented.  For me it's /sys/bus/i2c .

> > Do I need to reboot when switching between SMBus and ISA?
>
> No. This is Linux. You usually don't reboot unless upgrading kernels.

I know... But the thing is, the SMBus locks up and requires not only a
reboot, but a full power cycle.  Luckily it does not further require a
complete cycle of the ATX power supply (by switch on PS, or
unplug/replug).

Windows does require a reboot at least once a week (if you can make it
that long w/o crashing).  ;-)  With the frequent updates to Linux
kernel, and other software requiring a reboot such as init, or
(suggested) sshd, it seems to be about every 2-4 weeks (barring
configuration periods such as this, where it can be several times a day
until it's working satisfactorily).  Regardless, for me, uptimes are
less important than updates, until a hot-swappable kernel is ready.  :-)

I started using Unix (DEC Ultrix at college), and DOS 5/Win 3.x 11 years
ago, and started using Linux 7.5 years ago.  :-)  I just never seemed to
bother with sensors until I recently lost some 7200 RPM IDE drives due
to heat, despite excessive usage of fans.  Now I'd like my systems to
power off within a few seconds, and stay off until I am there, though it
would be cool if I could set the "power-up" BIOS options from within
Linux, after an adequate cool-down time or cooler time of day.

> I suspect some resource conflict. The w83781d driver will attempt to
reserve
> the ISA I/0 range 0x290-0x297. I suspect that it failed to do so.
Please make
> sure that your kernel was compiled with i2c debugging enabled.

Ok, reconfigured and recompiled with I2C Core debugging, I2C Algorithm
debugging, I2C Bus debugging and I2C Chip debugging enabled.

> Then try loading i2c-isa

Abbreviated identical messages reported in multiple logfiles with
regexp-like (log_1|log_b) notation and removed empty prompts between
command and tail output.

TAIL command: tail -f /var/log/messages /var/log/syslog /var/log/debug
/var/log/dmesg &

<defiant> [2004-09-10@10:51:19] ~ -> modprobe i2c-isa

=> /var/log/(debug|syslog) <=

Sep 10 10:51:33 defiant kernel: i2c_adapter i2c-0: registered as adapter
#0

Preloads i2c_core dependency.

<defiant> [2004-09-10@10:52:30] ~ -> lsmod
Module                  Size  Used by
i2c_isa                 1600  0
i2c_core               20560  1 i2c_isa

> and w83781d, in this order, and watch the logs
> (/var/log/syslog, /var/log/debug and dmesg) for hints. I'd expect to
see the
> w83781d driver complain it failed to reserve the I/O range.

<defiant> [2004-09-10@10:52:31] ~ -> modprobe w83781d

=> /var/log/(debug|syslog) <=
Sep 10 10:55:40 defiant kernel: i2c-core: driver w83781d registered.
Sep 10 10:55:40 defiant kernel: i2c_adapter i2c-0: found normal isa
entry for adapter 9191, addr 0290

I see no complaints?

<defiant> [2004-09-10@10:55:47] ~ -> sensors
No sensors found!

> You may look in
> /proc/ioports to see who/what reserved it. I wouldn't be surprised if
ACPI or
> PNP drivers were involved. You may try to enable/disable ACPI and/or
PNP while
> configuring your kernel and see if it helps.

I see nothing listed (see "cat /proc/ioports" below) for 0290, nor any
range which includes 0290, which is odd, because the modprobe of w83781d
found an ISA entry.  I seem to have both ACPI and ISA PnP in use.  ACPI
lets me use the PowerNow! frequency scaling of the AMD K6-(2|III)+ (aka
K6-plus) processors.  I can disable ACPI for testing, and could probably
live without it, but would like to use it if at all possible.

In the system I have two ISA cards: SB AWE 32 PnP (sound card) and US
Robotics 56k D/V/F modem.  Neither modules are currently loaded, but
sound was loaded before the sensors.

Now compiling and testing results with multiple configurations of the
kernel with related components in parenthesis:

1) I2C (sensors), ACPI (CPUFreq), ISA  PnP (sound, modem)
2) I2C (sensors), ACPI (CPUFreq)
3) I2C (sensors), ISA PnP (sound, modem)
4) I2C (sensors)

Hmm, no joy with #1 or #4, even with all PM disabled (in BIOS as well),
all sound disabled, all PNP disabled (in BIOS as well).  #2 and #3
untested.

I'd like to use the sound card so I can play sounds triggered by
non-fatal sensor alarms.  I'd set up my own software (Perl at first,
maybe PHP or C later) to maintain an alarm structure with states ok,
warn and crit, where warn emails and plays audio file of any format, and
crit powers downall results stored in MySQL database.  States composed
of any combination of the actual sensor reading, and the sensor readings
of other devices.  A case fan may fail, yet the system may stay cool
enough: warn (email, sounds), unless the case temperature or CPU is also
warn: crit (shutdown).

Eventually I'd like to play with the modem for telecom tinkering
(answering machine, single and multi user voice mail, voice menu system,
fax send and recv).  Both can be completely removed from the system for
testing if needed, though I'd rather avoid that if possible.  Sound can
readily be replaced with a PCI card as I have a few on hand that are
well supported by the kernel and ALSA.  I have no PCI or external
modems.

I am already using two PCI slots for network cards
(gateway/NAT/MASQ/etc.).  With only 4 slots (and sometimes 5: 1 shared
with ISA), I'd like to use these two cards in the two ISA slots, so I
don't have to buy any new PCI or external modem (if it can be found
anymore) and reserve the free PCI slots (in case the AGP card dies and I
need to use a PCI card temporarily), or if I want to add a hard disk
expansion card, or some other card.

<defiant> [2004-09-10@10:58:21] ~ -> cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : ISAPnP
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
5c20-5c3f : 0000:00:03.0
b000-b00f : 0000:00:0f.0
  b000-b007 : ide0
  b008-b00f : ide1
b400-b47f : 0000:00:0b.0
  b400-b47f : 0000:00:0b.0
b800-b8ff : 0000:00:0a.0
  b800-b8ff : 8139too
d000-dfff : PCI Bus #01
  d800-d8ff : 0000:01:00.0
ec08-ec0b : ACPI timer
ec10-ec15 : ACPI CPU throttle
fff0-ffff : PowerNow!

> > sensors.conf contains only this text (excluding the END comment
> > below):
>
> No END comment as far as I can see...

Oops, rearranged the text so that the file was the last thing, and so
removed the comment, but forgot to remove that reference.  :-)  There
was no missing data.

Another odd note that I forgot.  sensors-detect seems to insist on
checking for i2c-ali1535 module, though this is definitely the ALi 1543
chip.  Out of curiousity I configured, compiled and loaded the ali1535
module, and sensors-detect found nothing for that.  Is this one of those
situations where boards used either chipset?  I know specifically for
the ASUS P5A board, that it did not use the ALi 1535 chip.  Is there a
way to detect which chip is present, and not bug about the other?

Leif

> -- 
> Jean Delvare
> http://khali.linux-fr.org/


