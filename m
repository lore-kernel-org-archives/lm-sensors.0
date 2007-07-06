From: Michael Whincup <mwhincup@blueyonder.co.uk>
Date: Fri, 06 Jul 2007 14:36:52 +0000
Subject: [lm-sensors] Starting up sensors: failed ,
Message-Id: <200707061536.52995.mwhincup@blueyonder.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello

I'm using OpenSuse 10.2 on a Core 2 Duo E4300 with a Gigabyte 965P-DSP.
=20
I've tried to get lm_sensors working by following the explanation given here

http://www.novell.com/coolsolutions/tip/16348.HTML

The problem...

> linux-home:~ # /etc/init.d/lm_sensors restart
> Shutting down sensors:                                              done
> Starting up sensors:                                                failed

Here is the output of sensors-detect

> linux-home:~ # sensors-detect
> # sensors-detect revision 4171 (2006-09-24 03:37:01 -0700)
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no): y
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 0000:00:1f.3: Intel ICH8
>
> We will now try to load each adapter module in turn.
> Module `i2c-i801' already loaded.
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
>
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
>
> Next adapter: SMBus I801 adapter at 0500
> Do you want to scan it? (YES/no/selectively): y
> Client found at address 0x08
> Client found at address 0x30
> Client found at address 0x32
> Client found at address 0x50
> Handled by driver `eeprom' (already loaded), chip type `eeprom'
> Client found at address 0x52
> Handled by driver `eeprom' (already loaded), chip type `eeprom'
> Client found at address 0x69
>
> Next adapter: NVIDIA i2c adapter 3 at 1:00.0
> Do you want to scan it? (YES/no/selectively): y
> Client found at address 0x0c
> Client found at address 0x2e
> Probing for `Myson MTP008'...                               No
> Probing for `National Semiconductor LM78'...                No
> Probing for `National Semiconductor LM78-J'...              No
> Probing for `National Semiconductor LM79'...                No
> Probing for `National Semiconductor LM80'...                No
> Probing for `National Semiconductor LM85 or LM96000'...     No
> Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... No
> Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'...        No
> Probing for `Analog Devices ADT7462'...                     No
> Probing for `Analog Devices ADT7467 or ADT7468'...          No
> Probing for `Analog Devices ADT7470'...                     No
> Probing for `Analog Devices ADT7473'...                     Success!
>     (confidence 5, driver `to-be-written')
> Probing for `Analog Devices ADT7475'...                     No
> Probing for `Analog Devices ADT7476'...                     No
> Probing for `National Semiconductor LM87'...                No
> Probing for `National Semiconductor LM93'...                No
> Probing for `Winbond W83781D'...                            No
> Probing for `Winbond W83782D'...                            No
> Probing for `Winbond W83792D'...                            No
> Probing for `Winbond W83793R/G'...                          No
> Probing for `Winbond W83791SD'...                           No
> Probing for `Winbond W83627HF'...                           No
> Probing for `Winbond W83627EHF'...                          No
> Probing for `Winbond W83627DHG'...                          No
> Probing for `Asus AS99127F (rev.1)'...                      No
> Probing for `Asus AS99127F (rev.2)'...                      No
> Probing for `Asus ASB100 Bach'...                           No
> Probing for `Winbond W83L785TS-S'...                        No
> Probing for `Analog Devices ADM9240'...                     No
> Probing for `Dallas Semiconductor DS1780'...                No
> Probing for `National Semiconductor LM81'...                No
> Probing for `Analog Devices ADM1026'...                     No
> Probing for `Analog Devices ADM1025'...                     No
> Probing for `Analog Devices ADM1024'...                     No
> Probing for `Analog Devices ADM1029'...                     No
> Probing for `Analog Devices ADM1030'...                     No
> Probing for `Analog Devices ADM1031'...                     No
> Probing for `Analog Devices ADM1022'...                     No
> Probing for `Texas Instruments THMC50'...                   No
> Probing for `Analog Devices ADM1028'...                     No
> Probing for `ITE IT8712F'...                                No
> Probing for `Fintek F75373S/SG'...                          No
> Probing for `Fintek F75375S/SP'...                          No
> Probing for `Fintek F75387SG/RG'...                         No
> Probing for `Winbond W83791D'...                            No
> Client found at address 0x70
> Probing for `Philips Semiconductors PCA9540'...             Success!
>     (confidence 1, driver `pca9540')
>
> Next adapter: NVIDIA i2c adapter 2 at 1:00.0
> Do you want to scan it? (YES/no/selectively): y
> Client found at address 0x37
> Client found at address 0x50
> Handled by driver `eeprom' (already loaded), chip type `eeprom'
> Client found at address 0x51
> Handled by driver `eeprom' (already loaded), chip type `eeprom'
> Client found at address 0x52
> Handled by driver `eeprom' (already loaded), chip type `eeprom'
> Client found at address 0x53
> Handled by driver `eeprom' (already loaded), chip type `eeprom'
> Client found at address 0x54
> Handled by driver `eeprom' (already loaded), chip type `eeprom'
> Client found at address 0x55
> Handled by driver `eeprom' (already loaded), chip type `eeprom'
> Client found at address 0x56
> Handled by driver `eeprom' (already loaded), chip type `eeprom'
> Client found at address 0x57
> Handled by driver `eeprom' (already loaded), chip type `eeprom'
>
> Next adapter: NVIDIA i2c adapter 1 at 1:00.0
> Do you want to scan it? (YES/no/selectively): y
>
> Next adapter: NVIDIA i2c adapter 0 at 1:00.0
> Do you want to scan it? (YES/no/selectively): y
>
> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no): y
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM78-J' at 0x290...     No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> Probing for `Winbond W83627HF' at 0x290...                  No
> Probing for `Silicon Integrated Systems SIS5595'...         No
> Probing for `VIA VT82C686 Integrated Sensors'...            No
> Probing for `VIA VT8231 Integrated Sensors'...              No
> Probing for `AMD K8 thermal sensors'...                     No
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
>
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): y
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `ITE'...                                      Yes
> Found `ITE IT8718F Super IO Sensors'                        Success!
>     (address 0x290, driver `it87')
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `ITE'...                                      No
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
>
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus I801 adapter at 0500'
>     Busdriver `i2c-i801', I2C address 0x50
>     Chip `eeprom' (confidence: 6)
>   * Bus `SMBus I801 adapter at 0500'
>     Busdriver `i2c-i801', I2C address 0x52
>     Chip `eeprom' (confidence: 6)
>   * Bus `NVIDIA i2c adapter 2 at 1:00.0'
>     Busdriver `UNKNOWN', I2C address 0x50
>     Chip `eeprom' (confidence: 6)
>   * Bus `NVIDIA i2c adapter 2 at 1:00.0'
>     Busdriver `UNKNOWN', I2C address 0x51
>     Chip `eeprom' (confidence: 6)
>   * Bus `NVIDIA i2c adapter 2 at 1:00.0'
>     Busdriver `UNKNOWN', I2C address 0x52
>     Chip `eeprom' (confidence: 6)
>   * Bus `NVIDIA i2c adapter 2 at 1:00.0'
>     Busdriver `UNKNOWN', I2C address 0x53
>     Chip `eeprom' (confidence: 6)
>   * Bus `NVIDIA i2c adapter 2 at 1:00.0'
>     Busdriver `UNKNOWN', I2C address 0x54
>     Chip `eeprom' (confidence: 6)
>   * Bus `NVIDIA i2c adapter 2 at 1:00.0'
>     Busdriver `UNKNOWN', I2C address 0x55
>     Chip `eeprom' (confidence: 6)
>   * Bus `NVIDIA i2c adapter 2 at 1:00.0'
>     Busdriver `UNKNOWN', I2C address 0x56
>     Chip `eeprom' (confidence: 6)
>   * Bus `NVIDIA i2c adapter 2 at 1:00.0'
>     Busdriver `UNKNOWN', I2C address 0x57
>     Chip `eeprom' (confidence: 6)
>
>   EEPROMs are *NOT* sensors! They are data storage chips commonly
>   found on memory modules (SPD), in monitors (EDID), or in some
>   laptops, for example.
>
> Driver `to-be-written' (should be inserted):
>   Detects correctly:
>   * Bus `NVIDIA i2c adapter 3 at 1:00.0'
>     Busdriver `UNKNOWN', I2C address 0x2e
>     Chip `Analog Devices ADT7473' (confidence: 5)
>
> Driver `pca9540' (should be inserted):
>   Detects correctly:
>   * Bus `NVIDIA i2c adapter 3 at 1:00.0'
>     Busdriver `UNKNOWN', I2C address 0x70
>     Chip `Philips Semiconductors PCA9540' (confidence: 1)
>
> Driver `it87' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `ITE IT8718F Super IO Sensors' (confidence: 9)
>
> I will now generate the commands needed to load the required modules.
> Just press ENTER to continue:
>
> To make the sensors modules behave correctly, add these lines to
> /etc/modprobe.conf:
>
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----cut here----
>
> To load everything that is needed, add this to some /etc/rc* file:
>
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-i801
> # modprobe unknown adapter NVIDIA i2c adapter 0 at 1:00.0
> # modprobe unknown adapter NVIDIA i2c adapter 1 at 1:00.0
> # modprobe unknown adapter NVIDIA i2c adapter 2 at 1:00.0
> # modprobe unknown adapter NVIDIA i2c adapter 3 at 1:00.0
> # Chip drivers
> modprobe eeprom
> # no driver for Analog Devices ADT7473 yet
> # Warning: the required module pca9540 is not currently installed
> # on your system. For status of 2.6 kernel ports check
> # http://www.lm-sensors.org/wiki/Devices. If driver is built
> # into the kernel, or unavailable, comment out the following line.
> modprobe pca9540
> modprobe it87
> # sleep 2 # optional
> /usr/bin/sensors -s # recommended
> #----cut here----
>
> If you have some drivers built into your kernel, the list above will
> contain too many modules. Skip the appropriate ones! You really
> should try these commands right now to make sure everything is
> working properly. Monitoring programs won't work until the needed
> modules are loaded.
>
> Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): n

I don't overwrite here because I've set /etc/sysconfig/lm_sensors myself as=
=20
follows...

> MODULE_0=3Di2c-i801
> MODULE_1=EEprom
> MODULE_2=3Dit87

I deleted pca9540 from the autogenerated list because it wasn't recognised =

when I tried to manually modprobe it. See below:

> linux-home:~ # modprobe pca9540
> FATAL: Module pca9540 not found.

Here is the result of the config check...

> linux-home:~ # chkconfig -a lm_sensors
> lm_sensors                0:off  1:off  2:on   3:on   4:off  5:on   6:off

I notice that my /etc/fancontrol is missing

Can anyone help please?!!!!



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
