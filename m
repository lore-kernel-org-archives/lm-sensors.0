From: J.Kilb@gmx.de (Juergen Kilb)
Date: Fri, 25 Aug 2006 19:45:03 +0000
Subject: [lm-sensors] it8716 under 2.6
Message-Id: <200608252145.03504.J.Kilb@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060825084257.556030b7.khali@linux-fr.org>
In-Reply-To: <20060825084257.556030b7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Freitag, 25. August 2006 08:42 schrieb Jean Delvare:
Hi Jean,
>
> You have the same problem as was reported to me by someone else, i.e.
> fan speed readings are twice as much as what the BIOS says. Now, the
> values reported by the BIOS are quite low... Do you know what is the
> expected speed for these three fans? If you have the opportunity to
> test one of them in another machine and compare what the two BIOSes
> say, I'd appreciate.
>
I gues the expected speed for the fans are:
CPU-Fan:
Arctic Cooling Alpine 64 : 
expected speed			:2000 RPM
according to sensors output 	:4179 RPM
Bios output 				:2096 RPM

CHA_FAN 1 is an  
Revoltec AirGuard 120mm, 23.94 dBA 
expected speed			:1200 RPM
according to sensors output 	:2494 RPM 
Bios output 				:1256 RPM

PWR_FAN:
Enermax Liberty EL500AWT 120mm Fan
expected speed			:??? RPM
according to sensors output 	:903 RPM / 
Bios output 				:1256 RPM

i would beleive the BIOS values....
> Do the voltages match what the BIOS says if you use the default
> configuration file?
>
Voltages:
			Bios			Sensors with default config
Vcore		1,31V		1,01V (maybe the BIOS value is so high after power up)
3,3V			3,41V		3,22V (i think it is the voltage called VDDR)
5V			5,13V		4,78V
12V			12,3V		11,46V
CPU-Temp	26?			24?
MB-Temp		28?			31?

I think, it doesn't look too bad. Should it be better ?

> > Output of /var/log/messages:
> > =======
> > Aug 24 22:27:19 deepthought2 kernel: it87: Found IT8716F chip at 0x290,
> > revision 0
>
> So this is an IT7616F and not IT8718F contrary to what your original
> subject line said... Fixed.
>
Oops my fault ;-)
> > Aug 24 22:27:19 deepthought2 kernel: it87: in3 is VCC (+5V)
> > Aug 24 22:27:19 deepthought2 kernel: it87: in7 is VCCH (+5V)
> > Aug 24 22:27:19 deepthought2 kernel: it87: fan4 is enabled
> > Aug 24 22:27:19 deepthought2 kernel: it87: fan5 is enabled
> > ======> >
> > What do you think ? How can the BIOS tell me soemthing about 6 FANS..
> > I thought the ITE8716 has only 5 tachometer inputs....
>
> Very good question, I don't really know. I even had a report of a board
> with 7 fans using this chip (Asus M2N32-SLI). Could either be a second
> chip on the board, or multiplexed fan lines (would be bad.) Can you
> please provide the complete output of sensors-detect for this system?
>
> Thanks,
Sure here is the complete output of "sensors detect"
====================sensors-detect
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
 Do you want to probe now? (YES/no): yes
Probing for PCI bus adapters...
Sorry, no PCI bus adapters found.

We will now try to load each adapter module in turn.
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

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): yes
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

Do you want to scan for Super I/O sensors? (YES/no): yes
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x8716)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x8716)
Probing for `ITE 8712F Super IO Sensors'
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

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE IT8712F' (confidence: 8)


I will now generate the commands needed to load the I2C modules.

To make the sensors modules behave correctly, add these lines to
/etc/modprobe.conf:

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
/usr/bin/sensors -s # recommended
#----cut here----
=============
btw, i have also an 

vendor_id       	: AuthenticAMD
cpu family      	: 15
model           	: 75
model name     : AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ 

65Watt Type....

==

Juergen

