From: warp-9.9@usa.net (Leif W)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support DB Entry 1770
Message-Id: <001501c49b4b$33566910$0a01a8c0@enterprise>
List-Id: <lm-sensors.vger.kernel.org>
References: <007201c49733$ef934970$0a01a8c0@enterprise>
In-Reply-To: <007201c49733$ef934970$0a01a8c0@enterprise>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> ----- Original Message ----- 
> From: "Jean Delvare" <khali@linux-fr.org>
> To: "Leif W" <warp-9.9@usa.net>
> Cc: <sensors@Stimpy.netroedge.com>
> Sent: Sunday, September 12, 2004 04:31
> Subject: Re: Support DB Entry 1770
>
> regiesters belong to a so-called "auto-increment" range. This
basically
> means that reading any register in this range will automatically
> increase the address pointer, those value we are reading from I/O
> address 0x295.
>
> I think I am now starting to understand what's going on. Something
else
> is trying to access the chip at the very moment we are, most probably
> the BIOS. Why it does, I don't know. I thought that Asus started to
> implement such silly behaviors only recently, but it seems not. The
> SMBus locks you were experiencing speak for themselves.

:-\  Ahh well, I always thought they did a pretty good job in other
regards.  Fabrication of the boards was always nice, not sloppy looking
like some other boards at the time.  This particular board supports
everything from early Pentiums up to the AMD K6-III+/450, and can even
overclock it to 600 MHz as I did.  It supports CPU Core voltages from
2.0 up to 3.5, and documented as well, rare for the day.

> So, first of all, I have to tell you know that you should expect
> problems if you go on with using the w83781d driver on your system. It
> is likely that from times to times some readings will be completely
> wrong (BIOS reads interfering with yours). You could also experiment
> random reboots/halts (your reads interfering with the BIOSes).

Another thing happened last night: the system started "chirping".  Not
full beeps, variable intervals, variable durations but not long enough
to make a recognizable "beep" sound, about the same volume and tone
though, except the volume was sometimes less due to very short beep
duration.  The beeps were of very short duration, and I hadn't noticed
them for some time (due to other noises in the area like TV and music).
The beeps seemed to coincide with application execution when I did a
controlled shutdown today.

When I first started hearing them I thought I was imagining something.
Probably similar to those gag devices you buy at a joke store and put in
concealed locations in someone else's home or workplace, preferably with
an concealed video camera and microphone, and watch them slowly start to
go insane and tear the place apart looking for the noise.  :-)

I was trying to sleep so I power-cycled the system immediately and it
went away.  I didn't bother to see if unloading the driver would stop
the chirps.  I suspected that the hardware was in some funky state and
might not fix itself, and was too inpatient to test.  I'll try it today.
.. As I suspected, the module is unloaded, and the chirping continues.
:D  Rebooting clears it, so at least power cycling is not required.

> Why the sensors-detect script doesn't seem to be affected is above me.
> It didn't fail to detect the chip once, did it?

I've run it several times in a row, from immediately after a reboot and
a module load, to after a both successful and failed module loads and
then sensors attempt.  Never failed to detect it.

I've got a suggestion for "sensors-detect".  Command-line options for
the specific tests to perform or skip would be cool, so I could run one
command line.  Otherwise, I've got to use an input file with my
prompt-answers, run a command to take the file as input, run another
command to dump STDOUT and STDERR to a file, and run another command to
read the output file.  For example this is what I'd use for this
testing:

sensors-detect --pci-no --isa-yes --superio-no --summary-yes --commands-
no

> > Actually, the data "appears" to be read correctly but temp2 is not
> > correct.  Also an ALARM where there should be none (in3).  A result
of
> > forcing?
>
> This is just a guess, but the problem with temp2 could be caused by
the
> BIOS concurent accesses.
>
> The ALARM bits stay up until read, so you can usually see them once
> after the cause has disappeared. This is by chip design. If it does
not
> disappear after one more read, then there is something wrong (possibly
> the BIOS breaking things when reading in our back again.

At first in0-in3 have ALARMs, after subsequent read in0-in2 ALARMs go
away, but in3 remains.

> You may want to check in the BIOS setup screen if there is some option
> to disable "active hardware monitoring" or whatever they called that.
> You may also want to upgrade BIOSes and see if it helps.

The BIOS is the latest and final official beta available for this
mainboard (1105 Beta 005), required for proper AMD K6-plus
identification in the BIOS and reportedly for full utilization of the
AMD K6-plus cache.  The only way to go is put an older, slower processor
in the board, downgrade the BIOS, and see what happens.  Everything else
works.  So I'll probably have to skip any sanity checks with sensors if
I can't get this to work.

The closest thing to "active hardware monitoring" is in the "POWER
MANAGEMENT SETUP" menu.  Fan, thermal and voltage monitoring within the
BIOS can be ignored, but ignoring does not help.  :-(

Under the "CHIPSET FEATURES SETUP" there are two settings related to the
ISA bus: "Passive Release" and "Delayed Transaction"; both are enabled
(manual quoted below).  In the mainboard manual, it says "The onboard
hardware monitor uses the address 290H-297H so legacy ISA cards must not
use this address or else conflicts will occur."  It says this twice in
different locations, so it must be important.  I'm going to try
disabling each and then both of these settings, if necessary I'll double
check my ISA cards and then remove all of them and see if the problems
go away.

"Passive Release (Enabled)
This is a mechanism that allows concurrency of CPU-to-ISA cycles.  When
this feature is enabled, it will be possible to re-arbitrate the PCI bus
and allow the CPU to access PCI even when the M1543C has been granted
the ISA bus.

Delayed Transaction (Disabled)
If Enabled, this frees the PCI Bus during CPU accessing of 8-bit ISA
cards that normally consume about 50-60 PCI Clocks without PCI delayed
transaction.  If PCI Bus Masters cannot use the PCI Bus, leave this on
the default setting of Disabled for some ISA cards that are not PCI 2.1
compliant."

Disabling "Delayed Transaction" seems to fix the problems.  in3 has no
persistent ALARM, temp2 is read correctly, temp2_over and temp2_hyst are
connect, no chirping.  The cost is a performance hit of 50-60 PCI clocks
during ISA access (sensors, maybe modem and sound card).  Funny they
don't clearly state that enabling "Delayed Transaction" will break ISA
access to the "Health Monitoring".  "sensors" and "sensord" appear to
work fine.  No force or force_w83781d required.  I'm going to take the
latest patch and apply it the kernel, and enable my ACPI and then ISA
PnP one by one, then both.

The only odd looking thing at this point is the "registering" annd
"Detect" lines.  It reports "0-0290", but should it be 9191-0290?

<SHELL>

<defiant> [2004-09-12@13:41:07] ~ -> modprobe w83781d

=> /var/log/syslog <=
Sep 12 13:41:13 defiant kernel: i2c-core: driver w83781d registered.
Sep 12 13:41:13 defiant kernel: i2c_adapter i2c-0: found normal isa
entry for adapter 9191, addr 0290
Sep 12 13:41:13 defiant kernel: i2c_adapter i2c-0: client [w83781d]
registered to adapter
Sep 12 13:41:13 defiant kernel: registering 0-0290
Sep 12 13:41:13 defiant kernel: w83781d 0-0290: Detect OK

</SHELL>

Bottom line: Unless you use ISA only and disable the "Delayed
Transaction" as described above, both the I2C (SMBus) and ISA busses are
broken, making the sensor chip unusable.

Leif


