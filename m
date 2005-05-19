From: janl@langfeldt.net (Nicolai Langfeldt)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: lmsensors on Abit IC7-G
Message-Id: <3FBC0306.3010409@langfeldt.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FB92482.2070306@langfeldt.net>
In-Reply-To: <3FB92482.2070306@langfeldt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>># i2cdump 0 0x2e
>>(...)
>>That's very negative isn't it :-)
>
> Yes it is. I don't know what it is, but this is no LM80 for sure. We
> would need to enhance our detection routine so that doesn't fall in that
> kind of trap.
> 
> I'm curious. If you dump the chip again now, does it contain exactly the
> same data or not?

# i2cdump 0 0x2e
..
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 11 08 02 00 00 03 08 ff ff ff ff ff ff ff ff ff    ???..??.........
..

Yes.  That is exactly the same data.

> Could you provide the full output of sensors-detect (CVS version if
> possible)?
>> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect

OK.  Downloaded that and ran.  Assumptions:
- This is a pure PCI system, no ISA bus so no ISA probe, Intel ICH5 
chipset is correct.
- The ABIT mobo docs refers to this as a SMBus.

Here is the complete run:

# ./sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built-in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

  BIOS vendor (ACPI): IntelR
  We can start with probing for (PCI) I2C or SMBus adapters.
  You do not need any special privileges for this.
  Do you want to probe now? (YES/no): y
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5
Probe succesfully concluded.

  We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
  Do you now want to be prompted for non-detectable adapters? (yes/NO): no
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

Next adapter: SMBus I801 adapter at 0500 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): yes
Client found at address 0x08
Client at address 0x2e can not be probed - unload all client drivers first!
Client found at address 0x44
Client at address 0x50 can not be probed - unload all client drivers first!
Client at address 0x52 can not be probed - unload all client drivers first!
Client found at address 0x69

  Some chips are also accessible through the ISA bus. ISA probes are
  typically a bit more dangerous, as we have to write to I/O ports to do
  this.  Do you want to scan the ISA bus? (YES/no): no

  Some Super I/O chips may also contain sensors. Super I/O probes are
  typically a bit more dangerous, as we have to write to I/O ports to do
  this.  Do you want to scan for Super I/O sensors? (YES/no): no

  Sorry, no chips were detected.
  Either your sensors are not supported, or they are
  connected to an I2C bus adapter that we do not support.
  See doc/FAQ, doc/lm_sensors-FAQ.html, or
  http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html
  (FAQ #4.24.3) for further information.
  If you find out what chips are on your board, see
  http://secure.netroedge.com/~lm78/newdrivers.html for driver status.


This suggests some more addresses on the bus to dump:

root@roke /var/tmp # i2cdump 0 0x8
..
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

# i2cdump 0 0x44
..
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 0f 2a 00 00 00 00 00 00 00 00 00 00 00 00    ..?*............

# i2cdump 0 0x69
..
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
10: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
20: 0f 1f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
30: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

I also got this in dmesg:

i2c-dev.o: Registered 'SMBus I801 adapter at 0500' as minor 0
Intel Corp. 82801EB SMBus Controller: Bus collision! SMBus may be locked 
until next hard reset. (sorry!)

I then reran after unloading all i2c modules:

# ./sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built-in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

  BIOS vendor (ACPI): IntelR
  We can start with probing for (PCI) I2C or SMBus adapters.
  You do not need any special privileges for this.
  Do you want to probe now? (YES/no): yes
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5
Probe succesfully concluded.

  We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
  Do you now want to be prompted for non-detectable adapters? (yes/NO): no
  To continue, we need module `i2c-dev' to be loaded.
  If it is built-in into your kernel, you can safely skip this.
  i2c-dev is not loaded. Do you want to load it now? (YES/no): yes
  Module loaded succesfully.

  We are now going to do the adapter probings. Some adapters may hang 
halfway
  through; we can't really help that. Also, some chips will be double 
detected;
  we choose the one with the highest confidence value in that case.
  If you found that the adapter hung after probing a certain address, 
you can
  specify that address to remain unprobed. That often
  includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at 0500 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): ues

  Some chips are also accessible through the ISA bus. ISA probes are
  typically a bit more dangerous, as we have to write to I/O ports to do
  this.  Do you want to scan the ISA bus? (YES/no): yes
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
   Trying address 0x0290... Success!
     (confidence 8, driver `w83781d')
Probing for `Winbond W83697HF'
   Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
   Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
   Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
   Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
   Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
   Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
   Trying address 0x0ca8... Failed!

  Some Super I/O chips may also contain sensors. Super I/O probes are
  typically a bit more dangerous, as we have to write to I/O ports to do
  this.  Do you want to scan for Super I/O sensors? (YES/no): no

  Now follows a summary of the probes I have just done.
  Just press ENTER to continue:

Driver `w83781d' (should be inserted):
   Detects correctly:
   * ISA bus address 0x0290 (Busdriver `i2c-isa')
     Chip `Winbond W83627HF' (confidence: 8)


  I will now generate the commands needed to load the I2C modules.
  Sometimes, a chip is available both through the ISA bus and an I2C bus.
  ISA bus access is faster, but you need to load an additional driver module
  for it. If you have the choice, do you want to use the ISA bus or the
  I2C/SMBus (ISA/smbus)? smbus

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
modprobe w83781d
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): yes
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
root@roke /var/tmp # modprobe i2c-isa
root@roke /var/tmp # modprobe w83781d
# LD_LIBRARY_PATH=/usr/local/lib /usr/local/bin/sensors -s #>
No sensors found!

Try over again:

# rmmod i2c-i801 i2c-dev i2c-isa w83781d
# insmod i2c-isa
Using /lib/modules/2.4.22-ICH5II+lvm+i2c/kernel/drivers/i2c/i2c-isa.o
# insmod w83781d
Using /lib/modules/2.4.22-ICH5II+lvm+i2c/kernel/drivers/i2c/w83781d.o
# modprobe i2c-dev
# modprobe i2c-proc
# LD_LIBRARY_PATH=/usr/local/lib /usr/local/bin/sensors -s
No sensors found!

Regards,
   Nicolai
