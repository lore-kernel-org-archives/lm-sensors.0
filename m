From: jeff.kosowsky@verizon.net (Jeffrey J. Kosowsky)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: lm_sensors for ASUS P4PE motherboard
Message-Id: <15863.62053.716766.112907@consult.pretender>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I can't seem to get lm_sensors to work on my new Asus P4PE
motherboard. According to the schematics this intel 845PE
chipset-based board uses an "Asus ASIC with Hardware Monitor".

I am running RH8.0/linux 2.4.8 with the Redhat rpm lm_sensors-2.6.3-2.

The following is my log of running sensors-detect:

I am having trouble getting lm_sensors to work for the P4PE under
Linux (RH8.0/2.4.18)

When I run, 'sensors_detect', I get lots of output (see below), but it
doesn't seem like anything is detected.

Any thoughts on how to make this work?
Thanks,
Jeff

-----------------------------------------------------

This program will help you to determine which I2C/SMBus modules you
need to
load to use lm_sensors most effectively.
You need to have done a `make install', issued a `depmod -a' and made
sure
`/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
module path before you can use some functions of this utility. Read
doc/modules for more information.
Also, you need to be `root', or at least have access to the
/dev/i2c[-/]* files
for some things. You can use prog/mkdev/mkdev.sh to create these /dev
files
if you do not have them already.
If you have patched your kernel and have some drivers built-in you can
safely answer NO if asked to load some modules. In this case, things
may
seem a bit confusing, but they will still work.

IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
IBM Thinkpads have a severely broken i2c/SMBus implementation, just
scanning
the bus will break your thinkpad forever!

We can start with probing for (PCI) I2C or SMBus adapters.
You do not need any special privileges for this.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Sorry, no PCI bus adapters found.

We will now try to load each adapter module in turn.
Do you now want to be prompted for non-detectable adapters? (yes/NO):
yes
Load `i2c-elektor' (say NO if built into your kernel)? (YES/no):
/lib/modules/2.4.18-17.8.0/kernel/drivers/i2c/i2c-elektor.o:
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
You may find more information in syslog or the output from dmesg
/lib/modules/2.4.18-17.8.0/kernel/drivers/i2c/i2c-elektor.o: insmod
/lib/modules/2.4.18-17.8.0/kernel/drivers/i2c/i2c-elektor.o failed
/lib/modules/2.4.18-17.8.0/kernel/drivers/i2c/i2c-elektor.o: insmod
i2c-elektor failed
Loading failed ()... skipping.
Load `i2c-elv' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
Load `i2c-philips-par' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
Load `i2c-velleman' (say NO if built into your kernel)? (YES/no):
/lib/modules/2.4.18-17.8.0/kernel/drivers/i2c/i2c-velleman.o:
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
You may find more information in syslog or the output from dmesg
/lib/modules/2.4.18-17.8.0/kernel/drivers/i2c/i2c-velleman.o: insmod
/lib/modules/2.4.18-17.8.0/kernel/drivers/i2c/i2c-velleman.o failed
/lib/modules/2.4.18-17.8.0/kernel/drivers/i2c/i2c-velleman.o: insmod
i2c-velleman failed
Loading failed ()... skipping.
To continue, we need module `i2c-dev' to be loaded.
If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

We are now going to do the adapter probings. Some adapters may hang
halfway
through; we can't really help that. Also, some chips will be double
detected;
we choose the one with the highest confidence value in that case.
If you found that the adapter hung after probing a certain address,
you can
specify that address to remain unprobed. That often
includes address 0x69 (clock chip).

Next adapter: ELV Parallel port adaptor (Bit-shift algorithm)
Do you want to scan it? (YES/no/selectively): no

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. Do you want to scan the ISA bus? (YES/no):
Probing for `National Semiconductor LM78'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
Trying address 0x0ca8... Failed!

Now follows a summary of the probes I have just done.
Just press ENTER to continue:


I will now generate the commands needed to load the I2C modules.
Sometimes, a chip is available both through the ISA bus and an I2C
bus.
ISA bus access is faster, but you need to load an additional driver
module
for it. If you have the choice, do you want to use the ISA bus or the
I2C/SMBus (ISA/smbus)?

WARNING! If you have some things built into your kernel, the
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
# I2C chip drivers
#----cut here----

To make the sensors modules behave correctly, add these lines to
either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----
