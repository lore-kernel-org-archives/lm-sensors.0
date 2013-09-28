From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 28 Sep 2013 00:06:24 +0000
Subject: Re: [lm-sensors] Sudden shutdown and wrong temperature reading (driver jc42)
Message-Id: <52461D80.8040009@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAA9rSiUf_zbJ-sZ99yRQpakmpZrBurzM613ra0RqWQe8bVEcmQ@mail.gmail.com>
In-Reply-To: <CAA9rSiUf_zbJ-sZ99yRQpakmpZrBurzM613ra0RqWQe8bVEcmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 09/27/2013 01:38 PM, Olavo Luppi Silva wrote:
> Hi Guenter,
> Thanks for replying.
> I didn't configure acpi_enforce_resources=lax in your boot command line. I just made the following steps to install lm-sensors:
>
Hi,

please don't top-post, and please don't drop the mailing list from your replies.

you would not see an error, but something like

ACPI Warning: 0x000000000000f040-0x000000000000f05f SystemIO conflicts with Region \_SB_.PCI0.SBUS.SMBI 1 (20130517/utaddress-251)
ACPI: This conflict may cause random problems and system instability
ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver

Let's assume you don't see that. Next question is if your system supports IPMI.
If it does, there is a slight chance that the IPMI controller accesses the SMBUs,
causing an access conflict.

> 1) $ sudo apt-get install lm-sensors
> 2) $ sudo sensors-detect
> 3) Paste the output of sensors-detect at the end of /etc/modprobe
>
> I didn't make any manual settings to temperature limits. I'm pasting the output of sensors -u of all three machines. Raphson is hotter than the others because is was running a computation when I probed the temperature. We can observe that some fields, have zero or negative temperatures.
>
> I don't know how to set "temp_crit" and "temp_crit_alarm" and even if the temperatures indicated in these field are correct. Processor datasheet with thermal specifications is at http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-5600-vol-1-datasheet.pdf but I can't understand what those tables and graphics mean.

The xeon datasheet only reflects the CPU temperatures;
temp_max and temp_crit can not be set but is hard-coded for each CPU type.
This applies to the "coretemp" values.

>
> Below you can find the attachment of sensors -u and dmesg | grep rror of the three machines.
>
> Regrads,
> Olavo
>
>
>
> ====================
> OUTPUT OF sensors -u AT RAPHSON WORKSTATION
> =====================
>
> olavo@raphson:~$ sensors -u
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:
>    temp2_input: 60.000
>    temp2_max: 79.000
>    temp2_crit: 89.000
>    temp2_crit_alarm: 0.000
> Core 1:
>    temp3_input: 59.000
>    temp3_max: 79.000
>    temp3_crit: 89.000
>    temp3_crit_alarm: 0.000
> Core 2:
>    temp4_input: 59.000
>    temp4_max: 79.000
>    temp4_crit: 89.000
>    temp4_crit_alarm: 0.000
> Core 8:
>    temp10_input: 57.000
>    temp10_max: 79.000
>    temp10_crit: 89.000
> Core 9:
>    temp11_input: 61.000
>    temp11_max: 79.000
>    temp11_crit: 89.000
> Core 10:
>    temp12_input: 60.000
>    temp12_max: 79.000
>    temp12_crit: 89.000
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 0:
>    temp2_input: 44.000
>    temp2_max: 79.000
>    temp2_crit: 89.000
>    temp2_crit_alarm: 0.000
> Core 1:
>    temp3_input: 48.000
>    temp3_max: 79.000
>    temp3_crit: 89.000
>    temp3_crit_alarm: 0.000
> Core 2:
>    temp4_input: 45.000
>    temp4_max: 79.000
>    temp4_crit: 89.000
>    temp4_crit_alarm: 0.000
> Core 8:
>    temp10_input: 44.000
>    temp10_max: 79.000
>    temp10_crit: 89.000
> Core 9:
>    temp11_input: 49.000
>    temp11_max: 79.000
>    temp11_crit: 89.000
> Core 10:
>    temp12_input: 43.000
>    temp12_max: 79.000
>    temp12_crit: 89.000
>
>
>
> ====================
> OUTPUT OF sensors -u AT GAUSS WORKSTATION
> =====================
> olavo@gauss:~$ sensors -u
> radeon-pci-0200
> Adapter: PCI adapter
> temp1:
>    temp1_input: 79.500
>

That is a bit hot. Are you running a lot of graphics output on that ?
Does the graphics card have a fan, and is it running ?

> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:
>    temp2_input: 45.000
>    temp2_max: 79.000
>    temp2_crit: 89.000
>    temp2_crit_alarm: 0.000
> Core 1:
>    temp3_input: 45.000
>    temp3_max: 79.000
>    temp3_crit: 89.000
>    temp3_crit_alarm: 0.000
> Core 2:
>    temp4_input: 45.000
>    temp4_max: 79.000
>    temp4_crit: 89.000
>    temp4_crit_alarm: 0.000
> Core 8:
>    temp10_input: 45.000
>    temp10_max: 79.000
>    temp10_crit: 89.000
> Core 9:
>    temp11_input: 48.000
>    temp11_max: 79.000
>    temp11_crit: 89.000
> Core 10:
>    temp12_input: 45.000
>    temp12_max: 79.000
>    temp12_crit: 89.000
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 0:
>    temp2_input: 45.000
>    temp2_max: 79.000
>    temp2_crit: 89.000
>    temp2_crit_alarm: 0.000
> Core 1:
>    temp3_input: 43.000
>    temp3_max: 79.000
>    temp3_crit: 89.000
>    temp3_crit_alarm: 0.000
> Core 2:
>    temp4_input: 48.000
>    temp4_max: 79.000
>    temp4_crit: 89.000
>    temp4_crit_alarm: 0.000
> Core 8:
>    temp10_input: 40.000
>    temp10_max: 79.000
>    temp10_crit: 89.000
> Core 9:
>    temp11_input: 41.000
>    temp11_max: 79.000
>    temp11_crit: 89.000
> Core 10:
>    temp12_input: 40.000
>    temp12_max: 79.000
>    temp12_crit: 89.000
>
> jc42-i2c-8-18
> Adapter: SMBus I801 adapter at 3000
> temp1:
>    temp1_input: 50.500
>    temp1_max: 0.000
>    temp1_max_hyst: -3.000
>    temp1_min: 0.000
>    temp1_crit: 78.250
>    temp1_crit_hyst: 75.250
>    temp1_max_alarm: 0.000
>    temp1_min_alarm: 0.000
>    temp1_crit_alarm: 0.000
>
This shows that the maximum temperature is not configured, which also results in
the negative hysteresis temperature. Not necessarily a concern, though it is interesting
that there is no max_alarm. Maybe maximum temperature detection is disabled if temp1_max
is set to 0.

What sensor chip does sensors-detect report ? Maybe I can find some information
about this in the chip datasheet(s).

Other than that, the RAM on this system is running a bit hot. It is interesting that
it is warmer than the CPUs. Does the RAM temperature ever get close to the critical
temperature ?

Another thing to check might be the critical DRAM temperatures on raphson. It seems
like you have several types of DRAM in the systems with different critical temperatures,
and the maximum temperature is sometimes set and sometimes not.

Unfortunately, you did not include the DRAM sensor output from raphson, which would be
the most important to look at. Can you provide that information ? Just unload the driver
after you obtained the data; that should prevent any reboots.

Another question regarding the reboots: When this happened, did you have any code
running which is accessing the temperature sensors ? If so, do you have a log
of those temperatures at the time the system was rebooting ?
Also, do you by any chance see anything in syslog after the reboot showing
a reboot reason ?

Thanks,
Guenter

> jc42-i2c-8-19
> Adapter: SMBus I801 adapter at 3000
> temp1:
>    temp1_input: 48.500
>    temp1_max: 0.000
>    temp1_max_hyst: -3.000
>    temp1_min: 0.000:
>    temp1_crit: 78.500
>    temp1_crit_hyst: 75.500
>    temp1_max_alarm: 0.000
>    temp1_min_alarm: 0.000
>    temp1_crit_alarm: 0.000
>
> jc42-i2c-8-1a
> Adapter: SMBus I801 adapter at 3000
> temp1:
>    temp1_input: 51.000
>    temp1_max: 0.000
>    temp1_max_hyst: -3.000
>    temp1_min: 0.000
>    temp1_crit: 78.500
>    temp1_crit_hyst: 75.500
>    temp1_max_alarm: 0.000
>    temp1_min_alarm: 0.000
>    temp1_crit_alarm: 0.000
>
> jc42-i2c-8-1b
> Adapter: SMBus I801 adapter at 3000
> temp1:
>    temp1_input: 50.500
>    temp1_max: 0.000
>    temp1_max_hyst: -3.000
>    temp1_min: 0.000
>    temp1_crit: 78.500
>    temp1_crit_hyst: 75.500
>    temp1_max_alarm: 0.000
>    temp1_min_alarm: 0.000
>    temp1_crit_alarm: 0.000
>
> jc42-i2c-8-1c
> Adapter: SMBus I801 adapter at 3000
> temp1:
>    temp1_input: 51.000
>    temp1_max: 0.000
>    temp1_max_hyst: -3.000
>    temp1_min: 0.000
>    temp1_crit: 78.500
>    temp1_crit_hyst: 75.500
>    temp1_max_alarm: 0.000
>    temp1_min_alarm: 0.000
>    temp1_crit_alarm: 0.000
>
> jc42-i2c-8-1d
> Adapter: SMBus I801 adapter at 3000
> temp1:
>    temp1_input: 52.000
>    temp1_max: 0.000
>    temp1_max_hyst: -3.000
>    temp1_min: 0.000
>    temp1_crit: 78.250
>    temp1_crit_hyst: 75.250
>    temp1_max_alarm: 0.000
>    temp1_min_alarm: 0.000
>    temp1_crit_alarm: 0.000
>
>
>
> ====================
> OUTPUT OF sensors -u AT KALMAN WORKSTATION
> =====================
>
> olavo@kalman:~$ sensors -u
> nouveau-pci-0300
> Adapter: PCI adapter
> temp1:
>    temp1_input: 41.000
>    temp1_max: 100.000
>    temp1_crit: 110.000
>
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:
>    temp2_input: 41.000
>    temp2_max: 79.000
>    temp2_crit: 89.000
>    temp2_crit_alarm: 0.000
> Core 1:
>    temp3_input: 36.000
>    temp3_max: 79.000
>    temp3_crit: 89.000
>    temp3_crit_alarm: 0.000
> Core 2:
>    temp4_input: 35.000
>    temp4_max: 79.000
>    temp4_crit: 89.000
>    temp4_crit_alarm: 0.000
> Core 8:
>    temp10_input: 38.000
>    temp10_max: 79.000
>    temp10_crit: 89.000
> Core 9:
>    temp11_input: 39.000
>    temp11_max: 79.000
>    temp11_crit: 89.000
> Core 10:
>    temp12_input: 41.000
>    temp12_max: 79.000
>    temp12_crit: 89.000
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 0:
>    temp2_input: 43.000
>    temp2_max: 79.000
>    temp2_crit: 89.000
>    temp2_crit_alarm: 0.000
> Core 1:
>    temp3_input: 42.000
>    temp3_max: 79.000
>    temp3_crit: 89.000
>    temp3_crit_alarm: 0.000
> Core 2:
>    temp4_input: 41.000
>    temp4_max: 79.000
>    temp4_crit: 89.000
>    temp4_crit_alarm: 0.000
> Core 8:
>    temp10_input: 40.000
>    temp10_max: 79.000
>    temp10_crit: 89.000
> Core 9:
>    temp11_input: 41.000
>    temp11_max: 79.000
>    temp11_crit: 89.000
> Core 10:
>    temp12_input: 39.000
>    temp12_max: 79.000
>    temp12_crit: 89.000
>
> jc42-i2c-6-18
> Adapter: SMBus I801 adapter at 3000
> temp1:
>    temp1_input: 51.875
>    temp1_max: 0.000
>    temp1_max_hyst: -3.000
>    temp1_min: 0.000
>    temp1_crit: 74.000
>    temp1_crit_hyst: 71.000
>    temp1_max_alarm: 0.000
>    temp1_min_alarm: 0.000
>    temp1_crit_alarm: 0.000
>
> jc42-i2c-6-1a
> Adapter: SMBus I801 adapter at 3000
> temp1:
>    temp1_input: 48.875
>    temp1_max: 0.000
>    temp1_max_hyst: -3.000
>    temp1_min: 0.000
>    temp1_crit: 74.000
>    temp1_crit_hyst: 71.000
>    temp1_max_alarm: 0.000
>    temp1_min_alarm: 0.000
>    temp1_crit_alarm: 0.000
>
> jc42-i2c-6-1c
> Adapter: SMBus I801 adapter at 3000
> temp1:
>    temp1_input: 48.750
>    temp1_max: 0.000
>    temp1_max_hyst: -3.000
>    temp1_min: 0.000
>    temp1_crit: 74.000
>    temp1_crit_hyst: 71.000
>    temp1_max_alarm: 0.000
>    temp1_min_alarm: 0.000
>    temp1_crit_alarm: 0.000
>
>
> ====================
> $ less /etc/defaul/grub
>
> # If you change this file, run 'update-grub' afterwards to update
> # /boot/grub/grub.cfg.
> # For full documentation of the options in this file, see:
> #   info -f grub -n 'Simple configuration'
>
> GRUB_DEFAULT=0
> GRUB_HIDDEN_TIMEOUT=0
> GRUB_HIDDEN_TIMEOUT_QUIET=true
> GRUB_TIMEOUT
> GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
> GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
> GRUB_CMDLINE_LINUX=""
>
> # Uncomment to enable BadRAM filtering, modify to suit your needs
> # This works with Linux (no patch required) and with any kernel that obtains
> # the memory map information from GRUB (GNU Mach, kernel of FreeBSD ...)
> #GRUB_BADRAM="0x01234567,0xfefefefe,0x89abcdef,0xefefefef"
>
> # Uncomment to disable graphical terminal (grub-pc only)
> #GRUB_TERMINAL=console
>
> # The resolution used on graphical terminal
> # note that you can use only modes which your graphic card supports via VBE
> # you can see them in real GRUB with the command `vbeinfo'
> #GRUB_GFXMODEd0x480
>
> # Uncomment if you don't want GRUB to pass "root=UUID=xxx" parameter to Linux
> #GRUB_DISABLE_LINUX_UUID=true
>
> # Uncomment to disable generation of recovery mode menu entries
> #GRUB_DISABLE_RECOVERY="true"
>
> # Uncomment to get a beep at grub start
> #GRUB_INIT_TUNE="480 440 1"
>
>
>
>
> =================> olavo@raphson:~$ dmesg | grep rror
>
> [    2.792363] ACPI Error: Field [CPB3] at 96 exceeds Buffer [NULL] size 64 (bits) (20110623/dsopcode-236)
> [    2.792369] ACPI Error: Method parse/execution failed [\_SB_._OSC] (Node ffff880a30462ed8), AE_AML_BUFFER_LIMIT (20110623/psparse-536)
> [    2.924590] ERST: Error Record Serialization Table (ERST) support is initialized.
> [   12.864478] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
> [ 4275.337083] indicator-weath[2575]: segfault at 0 ip 00007f80e1f72bf1 sp 00007fff82e216c8 error 4 in libc-2.15.so <http://libc-2.15.so>[7f80e1e10000+1b5000]
>
> ==================
> olavo@gauss:~$ dmesg | grep rror
>
> [    2.791955] ACPI Error: Field [CPB3] at 96 exceeds Buffer [NULL] size 64 (bits) (20110623/dsopcode-236)
> [    2.791961] ACPI Error: Method parse/execution failed [\_SB_._OSC] (Node ffff880648462eb0), AE_AML_BUFFER_LIMIT (20110623/psparse-536)
> [    2.928526] ERST: Error Record Serialization Table (ERST) support is initialized.
> [   19.083332] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
> [25194.306241] nr[14648]: segfault at 20 ip 0000000000416d26 sp 00007fffdaf03a20 error 4 in nr[400000+1627000]
>
>
>
> =================
> olavo@kalman:~$ dmesg | grep rror
>
> [    2.773220] ACPI Error: Field [CPB3] at 96 exceeds Buffer [NULL] size 64 (bits) (20110623/dsopcode-236)
> [    2.773225] ACPI Error: Method parse/execution failed [\_SB_._OSC] (Node ffff880647866eb0), AE_AML_BUFFER_LIMIT (20110623/psparse-536)
> [    2.897234] ERST: Error Record Serialization Table (ERST) support is initialized.
> [    8.774739] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
>
>
>
> 2013/9/27 Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>>
>
>     On Fri, Sep 27, 2013 at 12:57:07PM -0300, Olavo Luppi Silva wrote:
>      > Hi dear lm-sensors developers,
>      >
>      > My name is Olavo, I am a newbie in this group and I am writing because I'm
>      > facing some problems that I suspect it could be a lm-sensors bug. If it's a
>      > bug I would be happy to help fixing it.
>      >
>      >
>      > SHORT STORY:
>      > The workstation suddenly shuts down, usually when performing intensive
>      > computation. Workaround: comment line jc42 at /etc/modules apparently
>      > solves the problem.
>      >
>      >
>      >
>      > LONG STORY:
>      > We have 3 Intel workstations with the specification described below,
>      > running linux ubuntu and lm-sensors installed. In June, one of the machines
>      > (raphson) started to shutdown suddenly during intensive computations, all
>      > processor in use during several hours. The shutdown events where becoming
>      > more and more frequent (a shutdown at each 5 minutes) and raphson were
>      > taken to technical assistance. They detected a hardware problem and
>      > replaced the motherboard which was in warranty period.
>      >
>      > Raphson returned but the shutdown events were still present at each 12h to
>      > 24h, roughly. Then I created a script to save sensors temperatures, which
>      > is pasted below, and monitored the workstation for many hours.  Ploting
>      > temperature of sensors jc42-i2c-8-1a, jc42-i2c-8-1b, etc, I noticed some
>      > spikes both down (0 Celsius degrees) and up (250 C).
>      > Then I disabled sensor jc42 commenting line jc42 at /etc/modules and it
>      > apparently solves the problem. Raphson is running without interruption
>      > performing intensive computations for 3 weeks now.
>      >
>      > I also performed the same temperature monitoring at the two other machines:
>      > kalman and gauss. Kalman temperature plots are ok, but Gauss's aren't. It
>      > presents the same spikes and sometimes produces the following error:
>      > ERROR: Can't get value of subfeature temp1_input:
>      > Kalman is running intensive computations without interruption for 2 weeks.
>      > Gauss was running intensive computations since last week but yesterday
>      > night and today morning it shutdown.
>      > Now I'm suspecting jc42 sensor is causing this problem.
>      >
>
>     Kind of unlikely. The sometimes wrong readings suggest that the i2c connection
>     to the memory chips may be flaky. Another question would be if you have
>     configured acpi_enforce_resources=lax in your boot command line to be able to
>     read the sensors. If so, there may be a conflict between the BIOS and the jc42
>     driver trying to access the sensors.
>
>     Secondary question is if temperature limits are set correctly, the value of
>     those limits, and if the temperature ever comes close to that limit. The only
>     "default" activity performed by the jc42 driver is to enable the sensors. If the
>     temperature limits are not set or not set correctly, and the alert output from
>     the sensor chip is connected to a board reset or NMI, you might well observe
>     shutdowns.
>
>     However, the occassional error in reading sensor information is a real concern.
>     Again, there is either a problem in the I2C connection between the sensor and
>     the i2c controller, or the sensor is accessed from multiple sources at the same
>     time (ie you configured acpi_enforce_resources=lax).
>
>     Please post any relevant dmesg output as well as output from the "sensors"
>     command. That might help us tracking down the problem.
>
>     Thanks,
>     Guenter
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
