From: koko <citizenr@gmail.com>
Date: Sat, 31 Mar 2007 22:42:49 +0000
Subject: [lm-sensors] repost: read the spd on A7V133 | without UTF-8
Message-Id: <3df49b7b0703311542l79ea2595pcfd8546aab4b07ac@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

sorry, damn gmail defaults to UTF-8

rasz@capek:~$ cat /etc/modules
i2c-viapro
eeprom
w83781d
via686a

rasz@capek:~$ lsmod|grep i2
i2c_isa                 6272  2 via686a,w83781d
i2c_viapro             10260  0
i2c_core               23552  6 via686a,w83781d,i2c_isa,eeprom,i2c_viapro,n=
vidia

rasz@capek:~$ sensors
as99127f-i2c-0-2d
Adapter: SMBus Via Pro adapter at e200
VCore 1:   +1.65 V  (min =3D  +1.46 V, max =3D  +1.84 V)
VCore 2:   +0.10 V  (min =3D  +2.24 V, max =3D  +2.74 V)       ALARM
+3.3V:     +3.31 V  (min =3D  +2.96 V, max =3D  +3.62 V)
+5V:       +4.97 V  (min =3D  +4.49 V, max =3D  +5.48 V)
+12V:     +12.04 V  (min =3D  +9.12 V, max =3D +13.62 V)
-12V:     -12.65 V  (min =3D -14.37 V, max =3D  -9.60 V)
-5V:       -5.15 V  (min =3D  -6.00 V, max =3D  -4.00 V)
fan1:        0 RPM  (min =3D    0 RPM, div =3D 2)
fan2:        0 RPM  (min =3D 2836 RPM, div =3D 2)              ALARM
fan3:        0 RPM  (min =3D    0 RPM, div =3D 2)
M/B Temp:    +34=B0C  (high =3D  +105=B0C, hyst =3D    +0=B0C)
CPU Temp:  +50.0=B0C  (high =3D   +95=B0C, hyst =3D   +80=B0C)          (be=
ep)
temp3:     -31.5=B0C  (high =3D  +122=B0C, hyst =3D  +121=B0C)
vid:      +1.650 V  (VRM Version 9.0)
alarms:
beep_enable:
          Sound alarm enabled

rasz@capek:~$ dmesg|grep quir
[   26.785583] PCI quirk: region e200-e27f claimed by vt82c686 HW-mon
[   26.785639] PCI quirk: region e800-e80f claimed by vt82c686 SMB

rasz@capek:~$ cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : 0000:00:04.1
01f0-01f7 : 0000:00:04.1
0376-0376 : 0000:00:04.1
03c0-03df : vga+
03f6-03f6 : 0000:00:04.1
0cf8-0cff : PCI conf1
8000-803f : 0000:00:11.0
  8000-8007 : ide2
  8008-800f : ide3
  8010-803f : PDC20265
8400-8403 : 0000:00:11.0
8800-8807 : 0000:00:11.0
9000-9003 : 0000:00:11.0
  9002-9002 : ide2
9400-9407 : 0000:00:11.0
  9400-9407 : ide2
9800-98ff : 0000:00:0b.0
  9800-98ff : 8139too
a000-a007 : 0000:00:0a.1
a400-a41f : 0000:00:0a.0
  a400-a41f : EMU10K1
d000-d01f : 0000:00:04.3
  d000-d01f : uhci_hcd
d400-d41f : 0000:00:04.2
  d400-d41f : uhci_hcd
d800-d80f : 0000:00:04.1
e200-e27f : 0000:00:04.4
  e200-e207 : vt596_smbus
e400-e47f : motherboard
  e400-e403 : ACPI PM1a_EVT_BLK
  e404-e405 : ACPI PM1a_CNT_BLK
  e408-e40b : ACPI PM_TMR
  e420-e423 : ACPI GPE0_BLK
e800-e80f : 0000:00:04.4
  e800-e80f : motherboard
    e800-e80f : pnp 00:03

rasz@capek:~$ dmesg|grep i2
[   39.886944] i2c_adapter i2c-9191: sensors disabled - enable with
force_addr=3D0xe200
[   57.766149] **WARNING** I2C adapter driver [NVIDIA i2c adapter 0 at
1:00.0] forgot to specify physical device; fix it!
[   57.766478] **WARNING** I2C adapter driver [NVIDIA i2c adapter 1 at
1:00.0] forgot to specify physical device; fix it!
[   57.766510] **WARNING** I2C adapter driver [NVIDIA i2c adapter 2 at
1:00.0] forgot to specify physical device; fix it!

rasz@capek:~$ ls -l /sys/bus/i2c/drivers/eeprom/
total 0
lrwxrwxrwx 1 root root    0 2007-03-25 22:53 2-0050 ->
../../../../devices/platform/i2c-2/2-0050
--w------- 1 root root 4096 2007-03-25 22:53 bind
lrwxrwxrwx 1 root root    0 2007-03-25 22:53 module -> ../../../../module/e=
eprom
--w------- 1 root root 4096 2007-03-25 22:53 unbind

2-0050 shows ONLY after I rmmod & modprobe eeprom again, its not there
after a boot. Reading anything from i2c-2/2-0050 =3D system hangs, I
suspect its the nvidia thingie or some martian memory space.

So where is my SPD data? :(
Is it under e800? do I have to force_addr=3D0xe800 some module? and which o=
ne?

EDIT: ok, after more investigation.
Under Windows XP reading spd also doesnt work for most programs
(cpu-z, spdtool, Thaiphoon) but works in some others (Everest from
2003, sandra from 2003).  And here comes the magic. I obtained the
newest Everest Ultimate 5.50, ran it, and 'puff smoke sparks fairies
and santa clause'  every program mentioned earlier as non working
started to work after using Everest (I narrowed it to "overclock" tab
in Everest - it reads timings and spd info, suspiciously opening only
"spd" tab will not trigger 'global spd enable' function).

I made registry dumps in cpu-z before and after, there are 3 diffs:

- =3D not working spd
+ =3D working spd

PCI to PCI Bridge
bus 0 (0x00), device 0 (0x00), function 0 (0x00)
Common header
        Vendor ID               0x1106
        Model ID                0x0305
Dump
-       00   06 11 05 03 06 00 10 A2 03 00 00 06 00 00 00 00
+       00   06 11 05 03 06 00 10 22 03 00 00 06 00 00 00 00

this is
[07:7]=DEtected Parity Error    0=3Dno error  1=3Derror
no idea why its set, seems irrelevant to spd bug

PCI to ISA Bridge
bus 0 (0x00), device 4 (0x04), function 0 (0x00)
Common header
        Vendor ID               0x1106
        Model ID                0x0686
Dump

-       40   08 41 00 00 00 80 62 E6 01 01 44 00 00 00 00 F3
+       40   08 41 00 00 00 80 62 EE 01 00 44 00 00 00 00 F3

I dont have prc file for this one

USB Controller (UHCI)
bus 0 (0x00), device 4 (0x04), function 3 (0x03)
Common header
        Vendor ID               0x1106
        Model ID                0x3038
Dump
-       40   00 12 03 00 C2 00 30 0C 00 00 00 00 00 00 00 00
+       40   00 12 03 00 C6 00 30 0C 00 00 00 00 00 00 00 00

seems irrelevant.

Another clue - Thaiphoon has "detect all i2c devices" option, running
it before gives bogus
>hardware sensor at 2Dh
>hardware sensor at 48h
>hardware sensor at 49h
after running everest and 'enabling' spd with 'magic' it gives correct
>hardware sensor at 50h
>hardware sensor at 51h
>hardware sensor at 52h

Is there a way to hijack Everest i2c actions and listen in to see what
is that 'magic' it applies to i2c on my board? BTW Everest can run in
Wine, maybe I could somehow emulate i2c for it in wine and listen in?
What can I do to debug /investigate it further? I really want a
working spd. It seems really strange that some programs work while
others dont

--
Who logs in to gdm? Not I, said the duck.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
