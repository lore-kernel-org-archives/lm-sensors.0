From: Ankit Chaturvedi <ankit.chaturvedi@gmail.com>
Date: Wed, 11 Apr 2007 02:54:21 +0000
Subject: Re: [lm-sensors] w83627ehf reporting ghost fan?
Message-Id: <461C4B0D.6080709@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <461C3562.2070006@gmail.com>
In-Reply-To: <461C3562.2070006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David Hubbard wrote:
> Hi Ankit,
> 
> Thank you for reporting this. This issue has been reported before, and
> I was unable to reproduce the error. I would like to track this down,
> although it might be a little difficult. Can you please provide the
> following information? (I am looking for the root cause)
> 
> Motherboard info: manufacturer, model number
> CPU: manufacturer, model, speed
> RAM installed
> Graphics Card
> 
> How often have you seen this problem? Is it reproducible?
> 
> Would you also be able to sign on to irc.freenode.net #linux-sensors
> on Saturday? (And if yes, what times?)
> 
> I have an Asus A8N-VM/CSM, with an AMD Athlon 64 X2 4400+, 1 Gb RAM,
> and no graphics card (I use the integrated nVidia 6150 on the
> A8N-VM/CSM).
> 
> Thanks,
> David
> 
---------------snip----------
Hi David,

	I have this problem as soon as w83627ehf module gets loaded at boot and
it occurs every time. My system specs are:

Motherboard: MSI K8NGM2-IL (link:
http://global.msi.com.tw/index.php?func=proddesc&prod_no"4)
CPU: AMD Athlon 3500+ (2.2GHz)
RAM: 1GB (256 MB shared video mem)
Graphics Card: Geforce 6100 Integrated
OS: Gentoo Linux

	On my earlier Mandriva setup with lm-sensors on the same system, this
problem never appeared. It has started out with Gentoo only. I am
attaching the sensors-detect log at the end. I will be on #linux-sensors
on Saturday since midnight(UTC) the whole time, I want to get to the
root at this too :) . Or you can decide a more favorable timeand let me
know.

sensors-detect log:
hunter ankit # sensors-detect
# sensors-detect revision 4171 (2006-09-24 03:37:01 -0700)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 0000:00:0a.1: nVidia Corporation
nForce4 SMBus (MCP51)

We will now try to load each adapter module in turn.
Load `i2c-nforce2' (say NO if built into your kernel)? (YES/no):
FATAL: Module i2c_nforce2 not found.
Loading failed... skipping.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: NVIDIA i2c adapter 2 at 0:05.0
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA i2c adapter 1 at 0:05.0
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA i2c adapter 0 at 0:05.0
Do you want to scan it? (YES/no/selectively):
Client found at address 0x37
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Probing for `EDID EEPROM'...                                Success!
    (confidence 8, driver `eeprom'), other addresses: 0x51 0x52 0x53
0x54 0x55 0x56 0x57
Probing for `Maxim MAX6900'...                              No
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Success!
    (confidence 1, driver `eeprom')
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
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
Probing for `Sony Vaio EEPROM'...                           No

Next adapter: SMBus nForce2 adapter at 6000
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x2f
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM78-J'...              No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `Analog Devices ADT7470'...                     No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83792D'...                            No
Probing for `Winbond W83793R/G'...                          No
Probing for `Winbond W83791SD'...                           No
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG'...                          No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Analog Devices ADM1029'...                     No
Probing for `ITE IT8712F'...                                No
Probing for `Fintek custom power control IC'...             No
Probing for `Winbond W83791D'...                            No

Next adapter: SMBus nForce2 adapter at 5000
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x50
Handled by driver `eeprom' (already loaded), chip type `eeprom'

Next adapter: saa7133[0]
Do you want to scan it? (YES/no/selectively):
Client found at address 0x47
Handled by driver `ir-kbd-i2c' (already loaded), chip type `Pinnacle PCTV'
    (note: this is probably NOT a sensor chip!)
Client found at address 0x4b
Handled by driver `tuner' (already loaded), chip type `tda8290+75a'
    (note: this is probably NOT a sensor chip!)
Client found at address 0x50
Handled by driver `eeprom' (already loaded), chip type `eeprom'

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Winbond W83627HF' at 0x290...                  No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `AMD K8 thermal sensors'...                     Success!
    (confidence 9, driver `k8temp')
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found `Winbond W83627EHF/EHG Super IO Sensors'              Success!
    (address 0xa10, driver `w83627ehf')

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `NVIDIA i2c adapter 0 at 0:05.0'
    Busdriver `UNKNOWN', I2C address 0x50 (and 0x51 0x52 0x53 0x54 0x55
0x56 0x57)
    Chip `EDID EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 5000'
    Busdriver `i2c-nforce2', I2C address 0x50
    Chip `eeprom' (confidence: 6)
  * Bus `saa7133[0]'
    Busdriver `UNKNOWN', I2C address 0x50
    Chip `eeprom' (confidence: 6)

  EEPROMs are *NOT* sensors! They are data storage chips commonly
  found on memory modules (SPD), in monitors (EDID), or in some
  laptops, for example.

Driver `k8temp' (should be inserted):
  Detects correctly:
  * ISA bus, undetermined address (Busdriver `i2c-isa')
    Chip `AMD K8 thermal sensors' (confidence: 9)

Driver `w83627ehf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0a10 (Busdriver `i2c-isa')
    Chip `Winbond W83627EHF/EHG Super IO Sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:


If you want to load the modules at startup, generate a config file
below and make sure lm_sensors gets started at boot time; e.g
$ rc-update add lm_sensors default
To make the sensors modules behave correctly, add these lines to
/etc/modules.d/lm_sensors and run modules-update:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is
working properly. Monitoring programs won't work until the needed
modules are loaded.

To load everything that is needed, execute the commands below...

#----cut here----
# I2C adapter drivers
# modprobe unknown adapter saa7133[0]
# modprobe unknown adapter NVIDIA i2c adapter 0 at 0:05.0
# modprobe unknown adapter NVIDIA i2c adapter 1 at 0:05.0
# modprobe unknown adapter NVIDIA i2c adapter 2 at 0:05.0
modprobe i2c-nforce2
# Chip drivers
# Warning: the required module eeprom is not currently installed
# on your system. For status of 2.6 kernel ports check
# http://www.lm-sensors.org/wiki/Devices. If driver is built
# into the kernel, or unavailable, comment out the following line.
modprobe eeprom
# Warning: the required module k8temp is not currently installed
# on your system. For status of 2.6 kernel ports check
# http://www.lm-sensors.org/wiki/Devices. If driver is built
# into the kernel, or unavailable, comment out the following line.
modprobe k8temp
modprobe w83627ehf
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----end cut here----

Do you want to overwrite /etc/conf.d/lm_sensors? Enter s to specify
other file name?
  (yes/NO/s):

----

	Feel free to contact if you need any information from my side.

Regards,
Ankit Chaturvedi

(PS: Sorry for the ill formatted last post :) )

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
