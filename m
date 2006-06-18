From: Lou@ParisiHome.net (Lou Parisi)
Date: Sun, 18 Jun 2006 15:54:09 +0000
Subject: [lm-sensors] CPU Temp on ECS NFORCE3-A939
Message-Id: <000001c692ef$72f2ed80$7001a8c0@parisi02>
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c69295$f481af80$7001a8c0@parisi02>
In-Reply-To: <000f01c69295$f481af80$7001a8c0@parisi02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you very much for the quick response and sorry for the html email.  I
have responded below to your questions and comments.  

Below I have provided:
* The complete output from my bios screen for monitored values
* My attempts to use the vid parameter
* Information on temp3 that was missing before
* Complete output of sensors-detect.

Thanks again for the help, it is very much appreciated.

-----Original Message-----
From: Jean Delvare [mailto:khali at linux-fr.org] 
Sent: Sunday, June 18, 2006 5:11 AM
To: Lou Parisi
Cc: LM Sensors
Subject: Re: [lm-sensors] CPU Temp on ECS NFORCE3-A939

Hi Lou,

First of all, I would suggest that you switch to a better e-mail
client. The one you use doesn't handle character encodings properly,
and generate very crappy HTML code.

> I am running CentOS 4 (uname -r 2.6.9-34.0.1.EL) with an ECS NFORCE3-939
MB
> and AMD Athlon64 3000+ processor
> 
> I am having problems with the CPU temp and core voltage value using
> lm-sensors.

> Had to adjust voltages computations for in5 and in6 from a post I found
> regarding a TYAN mb that had the same chip:    
> 
>     compute in5 (@ * (1+4.14)) - (4.096*4.14)  ,  (@ + (4.096*4.14)) /
(1+4.14)
> 
>     compute in6 (@ * (1+2.14)) - (4.096*2.14)  ,  (@ + (4.096*2.14)) /
(1+2.14)

These are very board-specific. What makes you think these lines are
correct for your board? Do the displayed values (and labels) match what
the BIOS displays? Many recent motherboards do not monitor negative
voltage lines anymore.

[Lou 18-JUN-2006] These values were not reasonable using the defaults.  I
searched the web for many configurations trying different ones and these
seem to output reasonable values but you are right my bios does not display
the negative voltages.  

My bios displays relatively consistent values with the following values and
labels reproduced from the bios screen below:
CPU VCore	1.37V
+1.5V		1.47V
+3.3V		3.31V
+5V		4.91V
+12V		11.71V
5VSB		5.02V
CPU Temp	53 C
System Temp	31 C
CPU Fan	3245
Sys Fan	992
Pwr Fan	0

> [root at web etc]# sensors
> it87-isa-0290
> Adapter: ISA adapter
> CPU VCore: +1.07 V  (min =  +1.28 V, max =  +1.42 V)   ALARM
> +1.5V:     +1.47 V  (min =  +1.42 V, max =  +1.57 V)
> +3.3V:     +3.31 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:       +4.92 V  (min =  +4.76 V, max =  +5.24 V)
> +12V:     +11.71 V  (min = +11.39 V, max = +12.61 V)
> -12V:     -12.11 V  (min = -12.60 V, max = -11.37 V)
> -5V:       -4.80 V  (min =  -5.25 V, max =  -4.75 V)
> Stdby:     +5.03 V  (min =  +4.76 V, max =  +5.24 V)
> VBat:      +2.94 V
> CPU Fan:  3245 RPM  (min = 3013 RPM, div = 8)
> Case Fan:  981 RPM  (min =  664 RPM, div = 8)
> Temp1:        +4?C  (low  =   +15?C, high =   +40?C)   sensor = thermistor
> Temp2:       +30?C  (low  =   +15?C, high =   +45?C)   sensor = thermistor
> 
> Everything looks good except the CPU core voltage and CPU temp.  
> 
> The bios reads 1.37V for coreV but lm_sensors reads 1.07 consistently.

This can be explained easily. Your Athlon64 3000+ must have the
so-called "Cool'n'Quiet" feature, which lets it adjust voltage and
frequency depending on load. I have a similar processor (Athlon64
3200+, socket 939) those voltage ranges from 1.1V (idle) to 1.4V (full
load.) This seems to be roughly the same for you.

You may try commenting out the following line in your configuration file
(in the it87-* section, of course):
#   ignore  vid
If the VID pins are properly wired on your system, this should report
the nominal voltage for your CPU and you should see it change depending
on the load.

So it's really only a matter of setting the proper limits for that kind
of CPU. Try the following:

   set in0_min 1.1 * 0.95
   set in0_max 1.4 * 1.05

[Lou 18-JUN-2006] I set the alarm values based on the CPU VCore reported in
the bios.  Perhaps this is not correct, I'm not sure.  I checked and my
processor does have the Cool'n'Quiet technology.  I have had the ignore VID
uncommented but did not figure out how to use it in the sensors.conf.  Did a
little more checking on the web and tried out a few more things.  Tried to
read vid as per the docs:
	# cat /sys/bus/i2c/devices/0-0290/in0_ref
	cat: /sys/bus/i2c/devices/0-0290/in0_ref: No such file or directory

Listing of /sys/bus/i2c/devices/0-0290:
# ls /sys/bus/i2c/devices/0-0290
alarms        fan3_input  in2_max    in5_max    name         temp2_type
detach_state  fan3_min    in2_min    in5_min    power        temp3_input
fan1_div      in0_input   in3_input  in6_input  temp1_input  temp3_max
fan1_input    in0_max     in3_max    in6_max    temp1_max    temp3_min
fan1_min      in0_min     in3_min    in6_min    temp1_min    temp3_type
fan2_div      in1_input   in4_input  in7_input  temp1_type
fan2_input    in1_max     in4_max    in7_max    temp2_input
fan2_min      in1_min     in4_min    in7_min    temp2_max
fan3_div      in2_input   in5_input  in8_input  temp2_min

When I try to use vid in alarm setting in sensors.conf as below:
	set in0_min vid * 0.95
	set in0_max vid * 1.05

# sensors
it87-isa-0290
Adapter: ISA adapter
CPU VCore: +1.07 V  (min =  +0.00 V, max =  +0.00 V)   ALARM


> The bios for temps: MB = 31 and CPU = 52.  Both are pretty consistent in
the
> bios.
> 
> The CPU temperature in lm_sensors fluctuates between -5 and 50.  I have
> tried using the diode for both temp1 and temp2 and ignoring different
> combinations with no success.  If the temperature was consistent I would
> feel better like a correction factor was needed but it is all over the
> place.

What about temp3?
[Lou 18-JUN-2006]
Temp3 gives consistently -7C when set to thermistor and consistent +94C when
set to diode.  Perhaps temp3 is the correct one and just needs a correction
factor.  I will try to get cpuburn running in the next few days and check to
see if temp3 changes and send a new reply.

Or there could be an additional temperature sensor on the board. Can we
see the full output of sensors-detect?

[Lou 18-JUN-2006] Full output of sensors-detect:
# sensors-detect
# sensors-detect revision 1.413 (2006/01/19 20:28:00)

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to all
questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce3
250Gb SMBus (MCP)
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-nforce2' (say NO if built into your kernel)? (YES/no): YES
Module loaded succesfully.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): YES
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): YES
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627EHF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8712F'
  Trying address 0x0290... Success!
    (confidence 8, driver `it87')
Probing for `ITE IT8705F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no): YES
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x8712)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x8712)
Probing for `ITE 8712F Super IO Sensors'
  Success... found at address 0x0290
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

Do you want to scan for secondary Super I/O sensors? (YES/no): YES
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE 8712F Super IO Sensors' (confidence: 9)


I will now generate the commands needed to load the I2C modules.

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# I2C chip drivers
modprobe it87
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): YES
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.

>         Also the chip designation in sensors.conf is 
> 
> chip "it87-*" "it8712-*"
> 
> If I have just "it8712-*" it does not detect the configuration in the
> sensors.conf and uses all defaults.

In kernel 2.6.9 your chip is identified by the driver as "it87" (see
the first line of "sensors"), but in later kernels it is better
identified as "it8712". We put both in the configuration file so that
the same file works with all kernels.

[Lou 18-JUN-2006] Thank you for the explanation on this.

-- 
Jean Delvare




