From: J.Kilb@gmx.de (Juergen Kilb)
Date: Sat, 26 Aug 2006 10:13:17 +0000
Subject: [lm-sensors] it8716 under 2.6
Message-Id: <200608261213.18043.J.Kilb@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060825084257.556030b7.khali@linux-fr.org>
In-Reply-To: <20060825084257.556030b7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, 
> > according to sensors output 	:903 RPM /
> > Bios output 			:1256 RPM
>
> Copy-n-paste typo for this last value?
you are right. Maybe it was to late.
>
> > i would beleive the BIOS values....
>
> Yep everyone seems to agree - I've updated my patch:
> http://jdelvare.pck.nerim.net/sensors/hwmon-it8716f-it8718f-v3-2.6.18.patch
> Fan readings for fan1 and fan2 should be OK now - not sure about fan3.
> Can you test and report?
>
Now it looks like:

snip =======

sensors
it8716-isa-0290
Adapter: ISA adapter
VCore:     +1.01 V  (min =  +0.00 V, max =  +4.08 V)
VDDR:      +3.22 V  (min =  +0.00 V, max =  +4.08 V)
+3.3V:     +0.00 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
+5V:       +4.81 V  (min =  +0.00 V, max =  +6.85 V)
+12V:     +11.46 V  (min =  +0.00 V, max = +16.32 V)
-12V:     -16.97 V  (min = -16.97 V, max =  +4.01 V)   ALARM
-5V:       -8.78 V  (min =  -8.78 V, max =  +4.05 V)   ALARM
5VSB:      +4.78 V  (min =  +0.00 V, max =  +6.85 V)
VBat:      +2.93 V
CPU_Fan:  2096 RPM  (min =    0 RPM)
CHA_Fan1: 1264 RPM  (min =    0 RPM)
PWR_Fan:   920 RPM  (min =    0 RPM)
CPU Temp:    +22?C  (low  =    -1?C, high =  +127?C)   sensor = diode
MB Temp:     +29?C  (low  =    -1?C, high =  +127?C)   sensor = thermistor
temp3:        -5?C  (low  =    -1?C, high =  +127?C)   sensor = thermistor
vid:       +0.30 V

k8temp-pci-00c3
Adapter: PCI adapter
temp1:       +30?C
temp3:       +22?C

snap======

The all fan speeds are now correct. Great work !

>
> Ah, hardware is too recent for lm_sensors 2.10.0's sensors-detect. Can
> you please pick SVN's version and try again?
>
> http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-dete
>ct?format=txt

OK, i have tried again with SVN version of "sensors-detect" and here is the 
output..

snip========prog/detect/sensors-detect
# sensors-detect revision 4112 (2006-08-25 21:59:29 +0200 (Fr, 25 Aug 2006))

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
 Do you want to probe now? (YES/no): yes
Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce4 SMBus 
(MCP55)
Probe successfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-nforce2' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Some chips are also accessible through the ISA I/O ports. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!

Do you want to scan the ISA I/O ports? (YES/no): yes
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
Probing for `Winbond W83627DHG'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `AMD K8 thermal sensors'
  Trying general detect... Success!
    (confidence 9, driver `k8temp')
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no): yes
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x8716)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x8716)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x8716)
Probing for `ITE IT8716F Super IO Sensors'
  Success... found at address 0x0290
Probing for `ITE IT8718F Super IO Sensors'
  Failed! (0x8716)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

Do you want to scan for secondary Super I/O sensors? (YES/no): yes
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

Driver `k8temp' (should be inserted):
  Detects correctly:
  * ISA bus, undetermined address (Busdriver `i2c-isa')
    Hint: Try forcing the chip address. Consult the documentation
          of particular chip for details and address value.
    Chip `AMD K8 thermal sensors' (confidence: 9)

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE IT8716F Super IO Sensors' (confidence: 9)


I will now generate the commands needed to load the required modules.

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
# Chip drivers
# Warning: the required module k8temp is not currently installed on your 
system.
# For status of 2.6 kernel ports see 
http://www.lm-sensors.org/wiki/SupportedDevices
# If driver is built-in to the kernel, or unavailable, comment out the 
following line.
modprobe k8temp
modprobe it87
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): n
snap ======

Btw.. do you have any idea, why "i2cdetect" doesnt detect anything.. like the 
EEPROMS at the memory modules...

Regards
Juergen

