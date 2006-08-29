From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 29 Aug 2006 11:35:58 +0000
Subject: [lm-sensors] [RFC] Improved sensors-detect output
Message-Id: <20060829133558.19eb6bb6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I am trying to make sensors-detect more user friendly. I made a first
pass this morning, which is already committed to SVN, with the
following changes:

* Kill the annoying blank space in front of half of the messages.
* Stop frightening the user with problems which might have happened some
  years ago, but are very rare nowadays.
* Skip some messages on 2.6 kernels where they do not apply.
* Don't even mention i2c-dev if it is already loaded or build into the
  kernel.
* Reword some messages.

These are relatively minor changes, but I hope that all these minor
changes together can contribute to making users less confused by
sensors-detect.

Now I have a second set of changes which make the output of
sensors-detect look really different. My goals were:

* Make the output more compact, as it has grown quite a bit over the
  past two years with the addition of Super-I/O chip detection and
  dozens of new chips.
* Make successful probes more visible, not only for the user but also
  for us when a user sends the output to us for investigation.
* Make I2C/SMBus, ISA and Super-I/O probes look more alike.

Here follows a sample output with my current changes applied.
Ergonomics being partly subjective, I am interested in feedback. In
other words, if someone thinks the new output is rather less clear than
the original one, please let me know before I commit my changes.

Thanks.

* * * * *

# sensors-detect revision 4120 (2006-08-29 11:17:56 +0200)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): 
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:11.0: VIA Technologies VT8237 South Bridge
Probe successfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-viapro' (say NO if built into your kernel)? (YES/no): n
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence value
in that case.
If you found that the adapter hung after probing a certain address, you
can specify that address to remain unprobed.

Next adapter: DC10plus[0]
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x2b
Handled by driver `adv7175' (already loaded), chip type `adv7176'
    (note: this is probably NOT a sensor chip!)
Client found at address 0x4e
Handled by driver `saa7110' (already loaded), chip type `saa7110'
    (note: this is probably NOT a sensor chip!)
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     Failed!
Probing for `Analog Devices ADM1034'...                     Failed!
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Probing for `EDID EEPROM'...                                Failed!
Probing for `Maxim MAX6900'...                              Failed!
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     Failed!
Probing for `Analog Devices ADM1034'...                     Failed!
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     Failed!
Probing for `Analog Devices ADM1034'...                     Failed!
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     Failed!
Probing for `Analog Devices ADM1034'...                     Failed!
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')

Next adapter: SMBus Via Pro adapter at 5000
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     Failed!
Probing for `Analog Devices ADM1034'...                     Failed!
Probing for `SPD EEPROM'...                                 Success!
    (confidence 8, driver `eeprom')
Probing for `EDID EEPROM'...                                Failed!
Probing for `Maxim MAX6900'...                              Failed!
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     Failed!
Probing for `Analog Devices ADM1034'...                     Failed!
Probing for `SPD EEPROM'...                                 Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69

Next adapter: crt2
Do you want to scan it? (YES/no/selectively): 

Next adapter: vga
Do you want to scan it? (YES/no/selectively): 

Next adapter: dvi
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     Failed!
Probing for `Analog Devices ADM1034'...                     Failed!
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Probing for `EDID EEPROM'...                                Success!
    (confidence 8, driver `eeprom'), other addresses: 0x51 0x52 0x53 0x54 0x55 0x56 0x57
Probing for `Maxim MAX6900'...                              Failed!
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     Failed!
Probing for `Analog Devices ADM1034'...                     Failed!
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     Failed!
Probing for `Analog Devices ADM1034'...                     Failed!
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     Failed!
Probing for `Analog Devices ADM1034'...                     Failed!
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Client found at address 0x54
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Client found at address 0x55
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Client found at address 0x56
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Client found at address 0x57
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Probing for `Sony Vaio EEPROM'...                           Failed!

Next adapter: monid
Do you want to scan it? (YES/no/selectively): n

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to do this. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): 
Probing for `National Semiconductor LM78' at 0x290...       Failed!
Probing for `National Semiconductor LM78-J' at 0x290...     Failed!
Probing for `National Semiconductor LM79' at 0x290...       Failed!
Probing for `Winbond W83781D' at 0x290...                   Failed!
Probing for `Winbond W83782D' at 0x290...                   Failed!
Probing for `Winbond W83627HF' at 0x290...                  Failed!
Probing for `Winbond W83627EHF' at 0x290...                 Failed!
Probing for `Winbond W83627DHG' at 0x290...                 Failed!
Probing for `Silicon Integrated Systems SIS5595'...         Failed!
Probing for `VIA VT82C686 Integrated Sensors'...            Failed!
Probing for `VIA VT8231 Integrated Sensors'...              Failed!
Probing for `AMD K8 thermal sensors'...                     Success!
    (confidence 9, driver `k8temp')
Probing for `IPMI BMC KCS' at 0xca0...                      Failed!
Probing for `IPMI BMC SMIC' at 0xca8...                     Failed!

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to do this. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): 
Probing for `ITE 8702F Sensors' at 0x2e...                  Failed!
Probing for `Nat. Semi. PC87351 Fan Sensors' at 0x2e...     Failed!
Probing for `SMSC 47B27x Fan Sensors' at 0x2e...            Failed!
Probing for `VT1211 Sensors' at 0x2e...                     Failed!
Probing for `Winbond W83627EHF/EHG Sensors' at 0x2e...      Failed!
Probing for `ITE 8702F Sensors' at 0x4e...                  Failed!
Probing for `Nat. Semi. PC87351 Fan Sensors' at 0x4e...     Failed!
Probing for `SMSC 47B27x Fan Sensors' at 0x4e...            Failed!
Probing for `VT1211 Sensors' at 0x4e...                     Failed!
    (found device ID 0x04)
Probing for `Winbond W83627HF Sensors' at 0x4e...           Failed!
Probing for `Winbond W83627THF Sensors' at 0x4e...          Failed!
Probing for `Winbond W83637HF Sensors' at 0x4e...           Failed!
Probing for `Winbond W83687THF Sensors' at 0x4e...          Failed!
Probing for `Winbond W83697HF Sensors' at 0x4e...           Failed!
Probing for `Winbond W83697SF/UF PWM' at 0x4e...            Failed!
Probing for `Winbond W83L517D' at 0x4e...                   Failed!
Probing for `Fintek F71805F/FG Sensors' at 0x4e...          Success!
    (address 0x295, driver `f71805f')
Probing for `Fintek F71872F/FG Sensors' at 0x4e...          Failed!
Probing for `Fintek F81218D' at 0x4e...                     Failed!
Probing for `Winbond W83627EHF/EHG Sensors' at 0x4e...      Failed!
    (found device ID 0x0406)
Probing for `Winbond W83627DHG Sensors' at 0x4e...          Failed!

Now follows a summary of the probes I have just done.
Just press ENTER to continue: 

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `DC10plus[0]'
    Busdriver `UNKNOWN', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `DC10plus[0]'
    Busdriver `UNKNOWN', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `DC10plus[0]'
    Busdriver `UNKNOWN', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `DC10plus[0]'
    Busdriver `UNKNOWN', I2C address 0x53
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `SMBus Via Pro adapter at 5000'
    Busdriver `i2c-viapro', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus Via Pro adapter at 5000'
    Busdriver `i2c-viapro', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `dvi'
    Busdriver `UNKNOWN', I2C address 0x50 (and 0x51 0x52 0x53 0x54 0x55 0x56 0x57)
    Chip `EDID EEPROM' (confidence: 8)

  EEPROMs are *NOT* sensors! They are data storage chips commonly
  found on memory modules (SPD), in monitors (EDID), or in some
  laptops, for example.

Driver `k8temp' (should be inserted):
  Detects correctly:
  * ISA bus, undetermined address (Busdriver `i2c-isa')
    Hint: Try forcing the chip address. Consult the documentation
          of particular chip for details and address value.
    Chip `AMD K8 thermal sensors' (confidence: 9)

Driver `f71805f' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0295 (Busdriver `i2c-isa')
    Chip `Fintek F71805F/FG Super IO Sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue: 

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
# modprobe unknown adapter monid
# modprobe unknown adapter dvi
# modprobe unknown adapter vga
# modprobe unknown adapter crt2
# modprobe unknown adapter DC10plus[0]
modprobe i2c-viapro
# Chip drivers
modprobe eeprom
modprobe k8temp
modprobe f71805f
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is
working properly. Monitoring programs won't work until the needed
modules are loaded.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): n


-- 
Jean Delvare

