From: tnuro@yahoo.com.au (T Nuro)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: ticket 1415
Message-Id: <3F95168B.5040305@yahoo.com.au>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Here's the output from sensors -u as requested......not much output I'm 
afraid - ie. zero.....

fw:~# sensors -u
w83627thf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm


-- so -- I started tinkering again (i've been sick for a week, so 
haven't had a chance to experiment some more since my posting)
I've always noticed that when I run sensors-detect, it seems to almost 
always give me a different result each time I try it. Usually it bounces 
between saying that it detects the ITE, winbond w83627thf and lm75 in 
one case, and the next case would be only the winbond w83627thf and 
lm75. I've always ignored the ITE chip module since every info page I 
find on the net says that its got a winbond w83627thf......

Anyway, here's the output from the ITE. It make no sense, but it 
believes its getting valid data even though the results are not true.


it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +2.89 V  (min =  +1.53 V, max =  +1.87 V)   ALARM
VCore 2:   +3.15 V  (min =  +2.25 V, max =  +2.75 V)
+3.3V:     +6.46 V  (min =  +2.96 V, max =  +3.60 V)
+5V:       +5.02 V  (min =  +4.50 V, max =  +5.48 V)
+12V:     +12.48 V  (min = +11.36 V, max = +13.80 V)
-12V:     -13.40 V  (min = -15.86 V, max = -13.40 V)
-5V:      -13.64 V  (min = -10.13 V, max =  -9.44 V)
Stdby:     +0.69 V  (min =  +0.00 V, max =  +0.00 V)
VBat:      +4.08 V
fan1:     11250 RPM  (min = 3000 RPM, div = 2)          ALARM
fan2:     135000 RPM  (min = 6000 RPM, div = 1)          ALARM
fan3:     67500 RPM  (min = 3000 RPM, div = 2)          ALARM
Temp1/MB:    -18?C  (low =   +0?C, high =  +44?C)         ALARM
Temp2/CPU:    -1?C  (low =  +20?C, high =   +0?C)         ALARM
Temp3:        +0?C  (low =  +20?C, high =  +60?C)         ALARM




Here's the output from sensors-detect from one instance (an instance 
that it doesn't suggest it87)




fw:/lib/modules/2.4.18-20030923-2/kernel/drivers/i2c# sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built-in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

 BIOS vendor (ACPI): ACPIAM
 System vendor (DMI): To Be Filled By O.E.M.
 BIOS version (DMI): 1010.004
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double 
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at 0400 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x0d
Client found at address 0x2f
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x30
Client found at address 0x32
Client found at address 0x44
Client found at address 0x48
Probing for `National Semiconductor LM75'... Success!
    (confidence 4, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Maxim MAX6650/MAX6651'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x49
Probing for `National Semiconductor LM75'... Success!
    (confidence 4, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x61
Probing for `SMBus 2.0 ARP-Capable Device'... Success!
    (confidence 1, driver `smbus-arp')
Client found at address 0x69

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):
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
 this.  Do you want to scan for Super I/O sensors? (YES/no):
Probing for `SMSC 47M10x Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed!
Probing for `VT1211 Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83627THF Super IO Sensors'
  Success... found at address 0x0290
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x82)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `lm75' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0400' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x48
    Chip `National Semiconductor LM75' (confidence: 4)
  * Bus `SMBus I801 adapter at 0400' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x49
    Chip `National Semiconductor LM75' (confidence: 4)

Driver `pcf8591' (may not be inserted):
  Misdetects:
  * Bus `SMBus I801 adapter at 0400' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x48
    Chip `Philips Semiconductors PCF8591' (confidence: 1)
  * Bus `SMBus I801 adapter at 0400' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x49
    Chip `Philips Semiconductors PCF8591' (confidence: 1)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0400' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0400' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 8)

Driver `smbus-arp' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0400' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x61
    Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627THF Super IO Sensors' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-i801
modprobe i2c-isa
# I2C chip drivers
modprobe lm75
modprobe eeprom
modprobe smbus-arp
modprobe w83627hf
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO):

I've successfully install lm sensors on several other machines, but this 
one is the newest mobo by a long way out of the ones I've setup. 
Unfortunately its also the most physically inaccessible for me too :)  
(ie. its in a foreign country but I need to monitor it)

thanks!

-Trevor

