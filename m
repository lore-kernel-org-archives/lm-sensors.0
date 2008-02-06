From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 06 Feb 2008 13:46:19 +0000
Subject: Re: [lm-sensors] [PATCH] lm-sensors: add sch5027 support
Message-Id: <191fb4ca0802060546y7bccf289y22bc177a342fd18c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0801312242k123f20ffl2ccb85ff1416ee6b@mail.gmail.com>
In-Reply-To: <191fb4ca0801312242k123f20ffl2ccb85ff1416ee6b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Michal,


On Feb 6, 2008 5:43 AM, Michal Medveck=FD <michal@medvecky.net> wrote:
> Juerg Haefliger napsal(a):
> > Can you unload the lm85 driver before running sensors-detect?
> >
> here it comes
>
> # sensors-detect revision $Revision$
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no): Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7
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
> Next adapter: SMBus I801 adapter at 3000 (i2c-0)
> Do you want to scan it? (YES/no/selectively): Client found at address 0x2e
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
> Probing for `Analog Devices ADT7473'...                     No
> Probing for `Analog Devices ADT7475'...                     No
> Probing for `Analog Devices ADT7476'...                     No
> Probing for `Andigilog aSC7611'...                          No
> Probing for `Andigilog aSC7621'...                          No
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
> Probing for `Winbond W83L786NR/NG/R/G'...                   No
> Probing for `Winbond W83L785TS-S'...                        No
> Probing for `Analog Devices ADM9240'...                     No
> Probing for `Dallas Semiconductor DS1780'...                No
> Probing for `National Semiconductor LM81'...                No
> Probing for `Analog Devices ADM1026'...                     No
> Probing for `Analog Devices ADM1025'...                     No
> Probing for `Analog Devices ADM1029'...                     No
> Probing for `Analog Devices ADM1030'...                     No
> Probing for `Analog Devices ADM1031'...                     No
> Probing for `Analog Devices ADM1022'...                     No
> Probing for `Texas Instruments THMC50'...                   No
> Probing for `Analog Devices ADM1028'...                     No
> Probing for `ITE IT8712F'...                                No
> Probing for `SMSC DME1737'...                               No
> Probing for `SMSC SCH5027D-NW'...                           Success!
>     (confidence 6, driver `dme1737')

Works as advertised. The problem was that the lm85 driver was loaded
prior to running sensors-detect.
...juerg


> Probing for `Fintek F75373S/SG'...                          No
> Probing for `Fintek F75375S/SP'...                          No
> Probing for `Fintek F75387SG/RG'...                         No
> Probing for `Analog Devices ADM1024'...                     No
> Probing for `Winbond W83791D'...                            No
> Client found at address 0x44
> Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
> Client found at address 0x50
> Handled by driver `eeprom' (already loaded), chip type `eeprom'
>     (note: this is probably NOT a sensor chip!)
> Client found at address 0x52
> Handled by driver `eeprom' (already loaded), chip type `eeprom'
>     (note: this is probably NOT a sensor chip!)
>
> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no): Probing for `National Se=
miconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM78-J' at 0x290...     No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> Probing for `Silicon Integrated Systems SIS5595'...         No
> Probing for `VIA VT82C686 Integrated Sensors'...            No
> Probing for `VIA VT8231 Integrated Sensors'...              No
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
>
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): Probing for Super-I/=
O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found `SMSC SCH5027D-NW Super IO'
>     (hardware monitoring capabilities accessible via SMBus only)
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No
>
> Some CPUs or memory controllers may also contain embedded sensors.
> Do you want to scan for them? (YES/no): AMD K8 thermal sensors...        =
                           No
> AMD K10 thermal sensors...                                  No
> Intel Core family thermal sensor...                         Success!
>     (driver `coretemp')
> Intel AMB FB-DIMM thermal sensor...                         No
>
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
> Driver `dme1737' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus I801 adapter at 3000'
>     Busdriver `i2c-i801', I2C address 0x2e
>     Chip `SMSC SCH5027D-NW' (confidence: 6)
>
> Driver `coretemp' (should be inserted):
>   Detects correctly:
>   * Chip `Intel Core family thermal sensor' (confidence: 9)
>
> Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO): To load ever=
ything that is needed, add this to one of the system
> initialization scripts (e.g. /etc/rc.d/rc.local):
>
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-i801
> # Chip drivers
> # Warning: the required module dme1737 is not currently installed
> # on your system. For status of 2.6 kernel ports check
> # http://www.lm-sensors.org/wiki/Devices. If driver is built
> # into the kernel, or unavailable, comment out the following line.
> modprobe dme1737
> # Warning: the required module coretemp is not currently installed
> # on your system. For status of 2.6 kernel ports check
> # http://www.lm-sensors.org/wiki/Devices. If driver is built
> # into the kernel, or unavailable, comment out the following line.
> modprobe coretemp
> /usr/bin/sensors -s
> #----cut here----
>
> If you have some drivers built into your kernel, the list above will
> contain too many modules. Skip the appropriate ones! You really
> should try these commands right now to make sure everything is
> working properly. Monitoring programs won't work until the needed
> modules are loaded.
>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
