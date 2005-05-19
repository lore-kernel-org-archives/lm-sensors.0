From: m.strong@tnsa.com.au (Mark Strong)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: fan speeds and temps no reading
Message-Id: <1105401666.15001.138.camel@tooheys.tnsa.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <1104907933.3003.195.camel@tooheys.tnsa.com.au>
In-Reply-To: <1104907933.3003.195.camel@tooheys.tnsa.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
	thanks for the reply.

Its an ASUS MB a NCL-DS with dual Xeons, and yes it does have hardware
monitoring in the bios (and some kind of smart fan control).  Its has
six fan headers on the MB.

The only chips I can see (the heatsinks on the Xeons cover up some
areas) that are likely candidate's is the W83627THF, and a W83792D
(there are also two W83601R's).

Here's the version
sensors version 2.9.0 with libsensors version 2.9.0


Thanks
Mark.

Here's the sensors-detect output
-----------------------------------
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at 0400
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x53
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x54
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x55
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x56
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x57
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `Sony Vaio EEPROM'... Failed!

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
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Success!
    (confidence 8, driver `it87')
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83627THF Super IO Sensors'
  Success... found at address 0x0290
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x82)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x82)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x82)

Do you want to scan for secondary Super I/O sensors? (YES/no):
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

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x53
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x54
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x55
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x56
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x57
    Chip `SPD EEPROM' (confidence: 8)

Driver `it87' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627THF Super IO Sensors' (confidence: 9)

On Mon, 2005-01-10 at 22:13 +0100, Jean Delvare wrote:
> Hi Mark, 
> 
> > Guys,
> > 	having a little trouble getting good readings
> > 
> > w83627thf-isa-0290
> > Adapter: ISA adapter
> > VCore:     +0.97 V  (min =  +0.96 V, max =  +0.96 V)              
> > +12V:      +6.63 V  (min = +10.82 V, max = +13.19 V)              
> > +3.3V:     +3.33 V  (min =  +3.14 V, max =  +3.47 V)              
> > +5V:       +4.96 V  (min =  +4.75 V, max =  +5.25 V)              
> > -12V:     -14.91 V  (min = -10.80 V, max = -13.18 V)              
> > V5SB:      +5.08 V  (min =  +4.76 V, max =  +5.24 V)              
> > VBat:      +1.70 V  (min =  +2.40 V, max =  +3.60 V)              
> > fan1:        0 RPM  (min = 8881 RPM, div = 2)                     
> > fan2:        0 RPM  (min = 5273 RPM, div = 2)                     
> > fan3:        0 RPM  (min = 10546 RPM, div = 2)                     
> > temp1:       -48?C  (high =    +9?C, hyst =    +0?C)   sensor > > thermistor           
> > temp2:    +127.5?C  (high =   +80?C, hyst =   +75?C)   sensor > > transistor   ALARM   
> > temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor > > thermistor           
> > vid:      +0.000 V  (VRM Version 9.0)
> > alarms:   Chassis intrusion detection                      ALARM
> > beep_enable:
> >           Sound alarm disabled
> 
> Admittedly no good. Some voltages might be correct but that's about it.
> 
> > The fans I've tried different "fan1_div" settings (tried 4 and 8) no
> > good, for the temps I've tried set sensor1,2 or 3435 (I can only get
> > -48C or +127C)
> > 
> > What can I try next (also where are the /proc values, or is it sysfs
> > these days?)
> 
> Do you have hardware monitoring information in the BIOS setup screen?
> 
> Did sensors-detect find any other chip? You may share the output with us
> in case we have an idea.
> 
> The W83627THF is a Super-I/O chip with more than just hardware
> monitoring, maybe that part isn't used. You should look at your
> motherboard manual and see if they mention the hardware monitoring
> capabilities at all. You could also look at the motherboard again and
> search for other Winbond, National Semiconductor, Analog Devices, Maxim
> etc... (even Asus) chips.
> 
> For 2.6 kernels the interface files are indeed in
> /sys/bus/i2c/devices/*/*.
> 

