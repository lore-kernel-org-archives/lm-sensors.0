From: chrls_test@yahoo.com (Charles Test)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: trouble with Epox 7KXA and via686a
Message-Id: <20050109213049.36364.qmail@web42108.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have an EPOX 7KXA mobo with an AMD Athlon processor.
There is an integrated via686a chip which I expect
would provide CPU temp information and other data. (My
BIOS has a screen where I can view CPU temp, so this
information is coming from somewhere.) I don't see any
via686a error messages in dmesg.

Trouble is, sensors gets me only:
main2:/# sensors
eeprom-i2c-0-51
Adapter: SMBus Via Pro adapter at 5000
Memory type:            SDR SDRAM DIMM
Memory size (MB):       64

eeprom-i2c-0-50
Adapter: SMBus Via Pro adapter at 5000
Memory type:            SDR SDRAM DIMM
Memory size (MB):       128

I have the following relevant modules loaded (a
snipped lsmod):

Module                  Size  Used by
via686a                20320  0
i2c_dev                10176  0
capability              4488  0
commoncap               7040  1 capability
eeprom                  8480  0
i2c_sensor              3776  2 via686a,eeprom
i2c_isa                 1984  0
i2c_viapro              7308  0
i2c_core               24016  6
via686a,i2c_dev,eeprom,i2c_sensor,i2c_isa,i2c_viapro

I suspect the problem is that I need to specify a
force_addr when modprobing. Unfortunately, I'm at a
loss to know what the address should be. My
motherboard (Epox 7KXA) manual is unhelpful in this
regard.

Any help would be appreciated. Below is the output of
the other commands asked for in the FAQ. (Except I'm
not sure what I should do for i2cdump.)

Thanks,

charles.

main2/# lspci -n
0000:00:00.0 0600: 1106:0391 (rev 02)
0000:00:01.0 0604: 1106:8391
0000:00:07.0 0601: 1106:0686 (rev 22)
0000:00:07.1 0101: 1106:0571 (rev 10)
0000:00:07.2 0c03: 1106:3038 (rev 10)
0000:00:07.3 0c03: 1106:3038 (rev 10)
0000:00:07.4 0600: 1106:3057 (rev 30)
0000:00:07.5 0401: 1106:3058 (rev 20)
0000:00:08.0 0280: 1814:0201 (rev 01)
0000:00:09.0 0104: 1095:0680 (rev 02)
0000:01:00.0 0300: 1002:5159


main2:/# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause
data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: UU UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX
main2:/# i2cdetect 1
Error: Can't use SMBus Quick Write command on this bus
(ISA bus?)

main2:/# uname -r
2.6.9-2-k7
(Debian unstable.)

main2:/# sensors -v
sensors version 2.9.0 with libsensors version 2.9.0

main2:/# sensors-detect

This program will help you determine which I2C/SMBus
modules you need to
load to use lm_sensors most effectively. You need to
have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access
to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers
built in, you can
safely answer NO if asked to load some modules. In
this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the
default answers to all
questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus
adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:07.4: VIA
Technologies VT82C686 Apollo ACPI
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-viapro' already loaded.
If you have undetectable or unsupported adapters, you
can have them
scanned by manually loading the modules before running
this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely
skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some
adapters may hang halfway
 through; we can't really help that. Also, some chips
will be double detected;
 we choose the one with the highest confidence value
in that case.
 If you found that the adapter hung after probing a
certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus Via Pro adapter at 5000
Do you want to scan it? (YES/no/selectively):
Client at address 0x50 can not be probed - unload all
client drivers first!
Client at address 0x51 can not be probed - unload all
client drivers first!
Client found at address 0x69

Some chips are also accessible through the ISA bus.
ISA probes are
typically a bit more dangerous, as we have to write to
I/O ports to do
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
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated
Sensors'
  Trying general detect... Success!
    (confidence 9, driver `via686a')
Probing for `VIA Technologies VT8231 Integrated
Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super
I/O probes are
typically a bit more dangerous, as we have to write to
I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)

Do you want to scan for secondary Super I/O sensors?
(YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `via686a' (should be inserted):
  Detects correctly:
  * ISA bus, undetermined address (Busdriver
`i2c-isa')
Hint: Try forcing the chip address. Consult the
documentation
of particular chip for details and address value.
    Chip `VIA Technologies VT82C686 Integrated
Sensors' (confidence: 9)


 I will now generate the commands needed to load the
I2C modules.
 Sometimes, a chip is available both through the ISA
bus and an I2C bus.
 ISA bus access is faster, but you need to load an
additional driver module
 for it. If you have the choice, do you want to use
the ISA bus or the
 I2C/SMBus (ISA/smbus)?

To make the sensors modules behave correctly, add
these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
i2c-isa
# I2C chip drivers
via686a
#----cut here----

Do you wan't to add these lines to /etc/modules
automatically? (yes/NO)

-eom-




		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250
