From: kevin.c.williams3@boeing.com (Williams, Kevin C)
Date: Fri, 10 Feb 2006 20:12:43 +0000
Subject: [lm-sensors] Can't load smsc47m1: no such device
Message-Id: <34919D5FCCAB494F97265DA64D1D703001AFCDF0@XCH-SW-1V1.sw.nos.boeing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

My fan speed is at the highest possible speed when booted into linux on
this system(same as speed during POST).  Load is 0.00 and x-windows is
not installed. Winxp has a no audible fan noise unless doing high
computation but never as high as with linux.  So, I decided to figure
out how to tweak the fan speed.

'sensors-detect' found SMSC 47M15x/192 and I found that in the drivers
section of the website, I(think) can use the 'smsc47m1' driver.  So I
tried it:
~]# modprobe smsc47m1 force_addr=0x0800
FATAL: Error inserting smsc47m1
(/lib/modules/2.6.11-1.1369_FC4smp/kernel/drivers/i2c/chips/smsc47m1.ko)
: No such device

'dmesg' has no reference of the smsc47m1 device, but it was found at
0x800 by sensors-detect with a cofidence of 9. Output of sensors-detect
is below.  I should mention that I had  run it before and 2 modules are
already loaded but they are just give me info about my RAM.  


~]# /usr/sbin/sensors-detect

This program will help you determine which I2C/SMBus modules

<snip>

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): y
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at 0500
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x08
Client found at address 0x2d

<snip - failed probings>

Client at address 0x50 can not be probed - unload all client drivers
first!
Client at address 0x52 can not be probed - unload all client drivers
first!
Client found at address 0x68
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): y
<snip - failed probings>

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no): y

<snip failed probings>

Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Success... found at address 0x0800

<snip failed probings>

Do you want to scan for secondary Super I/O sensors? (YES/no): y

<snip failed probings>

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0800 (Busdriver `i2c-isa')
    Chip `SMSC 47M15x/192 Super IO Fan Sensors' (confidence: 9)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver
module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? ISA

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
# no driver for SMSC 47M15x/192 Super IO Fan Sensors yet
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really
should
try these commands right now to make sure everything is working
properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): y
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.

'sensors' output:
 ~]# sensors
eeprom-i2c-0-52
Adapter: SMBus I801 adapter at 0500
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 0500
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

-Kevin



