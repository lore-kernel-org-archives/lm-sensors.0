From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Jun 2006 18:12:39 +0000
Subject: [lm-sensors] CPU Temp on ECS NFORCE3-A939
Message-Id: <20060618201239.7b8de2f2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c69295$f481af80$7001a8c0@parisi02>
In-Reply-To: <000f01c69295$f481af80$7001a8c0@parisi02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lou,

> > > The bios reads 1.37V for coreV but lm_sensors reads 1.07 consistently.
> > 
> > This can be explained easily. Your Athlon64 3000+ must have the
> > so-called "Cool'n'Quiet" feature, which lets it adjust voltage and
> > frequency depending on load. I have a similar processor (Athlon64
> > 3200+, socket 939) those voltage ranges from 1.1V (idle) to 1.4V (full
> > load.) This seems to be roughly the same for you.
> > 
> > You may try commenting out the following line in your configuration file
> > (in the it87-* section, of course):
> > #   ignore  vid
> > If the VID pins are properly wired on your system, this should report
> > the nominal voltage for your CPU and you should see it change depending
> > on the load.
> > 
> > So it's really only a matter of setting the proper limits for that kind
> > of CPU. Try the following:
> > 
> >    set in0_min 1.1 * 0.95
> >    set in0_max 1.4 * 1.05
> 
>                  I set the alarm values based on the CPU VCore reported in
> the bios.  Perhaps this is not correct, I'm not sure.  I checked and my
> processor does have the Cool'n'Quiet technology.

I guess that either the Cool'n'Quiet is disabled when in the BIOS
screen, or the BIOS is in a tight loop waiting for a key to be pressed
and this keeps the CPU busy. Either way this means that the highest
voltage is used.

>                                                   I have had the ignore VID
> uncommented but did not figure out how to use it in the sensors.conf.  Did a
> little more checking on the web and tried out a few more things.  Tried to
> read vid as per the docs:
> 	# cat /sys/bus/i2c/devices/0-0290/in0_ref
> 	cat: /sys/bus/i2c/devices/0-0290/in0_ref: No such file or directory

The file would in fact be named cpu0_vid (it changed in 2.6.9.)

> Listing of /sys/bus/i2c/devices/0-0290:
> # ls /sys/bus/i2c/devices/0-0290
> alarms        fan3_input  in2_max    in5_max    name         temp2_type
> detach_state  fan3_min    in2_min    in5_min    power        temp3_input
> fan1_div      in0_input   in3_input  in6_input  temp1_input  temp3_max
> fan1_input    in0_max     in3_max    in6_max    temp1_max    temp3_min
> fan1_min      in0_min     in3_min    in6_min    temp1_min    temp3_type
> fan2_div      in1_input   in4_input  in7_input  temp1_type
> fan2_input    in1_max     in4_max    in7_max    temp2_input
> fan2_min      in1_min     in4_min    in7_min    temp2_max
> fan3_div      in2_input   in5_input  in8_input  temp2_min

So it's not there, as if your chip was detected as an IT8705F instead
of an IT8712F. Are you certain you are running a 2.6.9 kernel? All
these hints suggest an older kernel.

> When I try to use vid in alarm setting in sensors.conf as below:
> 	set in0_min vid * 0.95
> 	set in0_max vid * 1.05
> 
> # sensors
> it87-isa-0290
> Adapter: ISA adapter
> CPU VCore: +1.07 V  (min =  +0.00 V, max =  +0.00 V)   ALARM

Because there is no vid reading, the value of the "vid" symbol is 0.
Anyway you shouldn't use "vid" in compute lines in this case, because
its value changes, and you want to allow the full range your CPU is
allowed to use.

> > What about temp3?
> 
> Temp3 gives consistently -7C when set to thermistor and consistent +94C when
> set to diode.  Perhaps temp3 is the correct one and just needs a correction
> factor.  I will try to get cpuburn running in the next few days and check to
> see if temp3 changes and send a new reply.

No, it's most certainly not correct either.

> Full output of sensors-detect:
> # sensors-detect
> # sensors-detect revision 1.413 (2006/01/19 20:28:00)
> (...)
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no): YES
> Probing for PCI bus adapters...
> Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce3
> 250Gb SMBus (MCP)
> Probe succesfully concluded.

Support for this chip was only added in 2.6.11, and although
sensors-detect knows which driver should be used (i2c-nforce2), the
driver doesn't know it should support your chip. As a result, if there
are sensor chips on this bus cannot be accessed.

As I guess you don't really want to upgrade to a more recent kernel,
you should be able to add support for your chip at run time by doing the
following (as root):

$ modprobe i2c-nforce2
$ echo "10de 00e4" > /sys/bus/pci/drivers/nForce2_smbus/new_id

Then run sensors-detect again, and report the results.

> > In kernel 2.6.9 your chip is identified by the driver as "it87" (see
> > the first line of "sensors"), but in later kernels it is better
> > identified as "it8712". We put both in the configuration file so that
> > the same file works with all kernels.

I take that back, 2.6.9 is actually the first kernel which should name
the chip it8712. I'm really surprised it doesn't. Unless you're in fact
using a 2.6.8 kernel.

-- 
Jean Delvare

