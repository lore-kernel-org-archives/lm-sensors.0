From: support-squid@bfinance.fr (jonathan)
Date: Mon, 08 Aug 2005 14:17:28 +0000
Subject: [lm-sensors] bmcsensors and ipmi on Poweredge
Message-Id: <1123503404.3182.14.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,
I want to check CPU temperature of my dell's poweredge 1750 server,
running a debian.
I have recompiled my 2.6.10 kernel including IPMI and I2C modules.

I have installed lm-sensors but after a running sensors-detect and
setting modules.conf ... nothing output on sensors command: No sensors
found!


this is my sensors-detect output :

---------------------------------------------------------------------
This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to
all
questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): 
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:0f.0: ServerWorks CSB5 South Bridge
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-piix4' already loaded.
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

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): 
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
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8712F'
  Trying address 0x0290... Failed!
Probing for `ITE IT8705F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Success!
    (confidence 4, driver `bmcsensors')
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no):          
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0xee11)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0xee11)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0xee11)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'

  Failed! (0xee)
Probing for `Nat. Semi. PC87591 Super IO'
  Failed! (0xee)
Probing for `Nat. Semi. PC87371 Super IO'
  Failed! (0xee)
Probing for `Nat. Semi. PC97371 Super IO'
  Failed! (0xee)
Probing for `Nat. Semi. PC8739x Super IO'
  Failed! (0xee)
Probing for `Nat. Semi. PC8741x Super IO'
  Success... (no hardware monitoring capabilities)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47M172 Super IO'
  Failed! (0xee)
Probing for `SMSC LPC47B397-NC Super IO'
  Failed! (0xee)
Probing for `VT1211 Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0xee)
Probing for `Winbond W83L517D Super IO'Do you want to scan for secondary
Super I/O sensors? (YES/no):                                         
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue: 

Driver `bmcsensors' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0ca0 (Busdriver `i2c-isa')
    Chip `IPMI BMC KCS' (confidence: 4)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver
module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? 

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
i2c-isa
# You must also install and load the IPMI modules
i2c-ipmi
# I2C chip drivers
# Warning: the required module bmcsensors is not currently installed on
your system.
# For status of 2.6 kernel ports see
http://secure.netroedge.com/~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the
following line.
bmcsensors
#----cut here----
---------------------------------------------------------------------

lsmod output :

root@jaipur:/usr/src/linux# lsmod
Module                  Size  Used by
i2c_dev                15104  0 
i2c_piix4              14096  0 
i2c_isa                 6144  0 
i2c_core               29696  3 i2c_dev,i2c_piix4,i2c_isa
--------------

I have tried to modprobe the modules:

usr/src/linux# modprobe i2c-ipmi
FATAL: Module i2c_ipmi not found.
/usr/src/linux# modprobe bmcsensors
FATAL: Module bmcsensors not found.

why I have always a not found result ?:

/usr/src/linux# sensors  
No sensors found!


thanks for helping me



