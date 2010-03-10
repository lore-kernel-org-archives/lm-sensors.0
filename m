From: lmsensorslist@nodivisions.com
Date: Wed, 10 Mar 2010 02:28:10 +0000
Subject: [lm-sensors] Wrong temperatures reported for Core2Duo CPU in Intel
Message-Id: <781687b2e6d2a27726f35a316f5bf821.squirrel@webmail.nodivisions.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

I have an Intel DG965WH motherboard with an Intel Core2Duo CPU which seems
to report incorrect core temperatures:

$ sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +74.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +73.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)

~75C is the idle temperature; when the CPU is busy it's more like 85C, and
sometimes even 90C+.  I think this is wrong because a) that just seems
insanely high; b) the CPU heatsink is warm, not hot, to the touch; and c)
it's been running like this almost 24/7 for about 3.5 years, which I doubt
it would have survived if it were really that hot.  I also have 2 hard
disks in this PC which report ~32C and ~41C (from the hddtemp command)
which seems much more reasonable.

I originally had the Intel heatsink+fan on there, and then I switched to a
Rosewill RCX-Z300, which is supposed to be cooler and quieter.  But either
way the reported temperature is super high.  I'm also confident that
there's good contact from the heatsink to the thermal compound to the CPU,
so I don't think that's an issue.

The main reason this bothers me is that the CPU fan is always running
really fast and thus is really loud.  This drives me crazy.  Over the
years I've tried several times to solve this, to no avail; and supposedly
something from Intel was always just around the corner -- is the new Intel
QST SDK something that might help?  The "sensors" output above is the full
output from that command, so I believe my motherboard/chipset is just not
well supported at all, which I gather is due to this heretofore-secret
Intel stuff.

I've also just tried the iasl command to check/fix any DSDT issues, but it
reported 0 errors and just 1 warning, so I don't think any of that is the
problem.

Here's some of my system info:

#

$ uname -a
Linux soma 2.6.31-20-generic #57-Ubuntu SMP Mon Feb 8 09:02:26 UTC 2010
x86_64 GNU/Linux

#

$ lspci
00:00.0 Host bridge: Intel Corporation 82P965/G965 Memory Controller Hub
(rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82G965 Integrated
Graphics Controller (rev 02)
00:03.0 Communication controller: Intel Corporation 82P965/G965 HECI
Controller (rev 02)
00:19.0 Ethernet controller: Intel Corporation 82566DC Gigabit Network
Connection (rev 02)
00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
Controller #4 (rev 02)
00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
Controller #5 (rev 02)
00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI
Controller #2 (rev 02)
00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio
Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express
Port 1 (rev 02)
00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express
Port 2 (rev 02)
00:1c.2 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express
Port 3 (rev 02)
00:1c.3 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express
Port 4 (rev 02)
00:1c.4 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express
Port 5 (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
Controller #3 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI
Controller #1 (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev f2)
00:1f.0 ISA bridge: Intel Corporation 82801HH (ICH8DH) LPC Interface
Controller (rev 02)
00:1f.2 IDE interface: Intel Corporation 82801H (ICH8 Family) 4 port SATA
IDE Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller
(rev 02)
00:1f.5 IDE interface: Intel Corporation 82801H (ICH8 Family) 2 port SATA
IDE Controller (rev 02)
02:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6101 single-port
PATA133 interface (rev b1)
06:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A
IEEE-1394a-2000 Controller (PHY/Link)

#

I'm running the latest BIOS (MQ96510J.86A.1754.2008.1117.0002), and there
hasn't been an update for over a year.

If anyone can shed any light on this, in particular how I can get the fan
to spin slower or (even better) get these temperatures to be correct, I
would really appreciate it.

Thanks,

--
Anthony DiSante
http://nodivisions.com/



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
