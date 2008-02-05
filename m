From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 05 Feb 2008 07:31:49 +0000
Subject: Re: [lm-sensors] SMSC Super I/O: unknown chip with ID 0x8902 (was:
Message-Id: <191fb4ca0802042331j29f4af85va2bb13f2b2b9dab1@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_6770_22556584.1202196709342"
List-Id: <lm-sensors.vger.kernel.org>
References: <004e01c856bc$6f975c10$0204a8c0@IT>
In-Reply-To: <004e01c856bc$6f975c10$0204a8c0@IT>
To: lm-sensors@vger.kernel.org

------=_Part_6770_22556584.1202196709342
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Andrew,

Can you please give the attached driver a try? It should recognize
your chip properly.
Please send the relevant output of /var/log/syslog and 'ls -l
/sys/class/hwmon/hwmon*/device/' to the list.

Thanks
...juerg


On Jan 30, 2008 11:08 AM, Andrew Voznytsa <andrew.voznytsa@gmail.com> wrote:
> Hi Juerg,
>
> It is easy (around 1 min to compile kernel, so why not?). New output is
> below. Quick summary - works as you said.
>
> # sensors-detect revision 5108 (2008-01-22 04:22:47 -0800)
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7
>
> We will now try to load each adapter module in turn.
> Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
> FATAL: Module i2c_i801 not found.
> Loading failed... skipping.
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
> Do you want to scan it? (YES/no/selectively):
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
> Probing for `Fintek F75373S/SG'...                          No
> Probing for `Fintek F75375S/SP'...                          No
> Probing for `Fintek F75387SG/RG'...                         No
> Probing for `Analog Devices ADM1024'...                     No
> Probing for `Winbond W83791D'...                            No
>
> Client found at address 0x44
> Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
> Client found at address 0x51
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
> Client found at address 0x52
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
> Client found at address 0x53
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
>
>
> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no):
> Probing for `National Semiconductor LM78' at 0x290...       No
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
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
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
> Do you want to scan for them? (YES/no):
> AMD K8 thermal sensors...                                   No
> AMD K10 thermal sensors...                                  No
> Intel Core family thermal sensor...                         Success!
>     (driver `coretemp')
> Intel AMB FB-DIMM thermal sensor...                         No
>
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>
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
> Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO):
> To load everything that is needed, add this to one of the system
> initialization scripts (e.g. /etc/rc.d/rc.local):
>
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-i801
> # Chip drivers
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
> Best regards,
> Andrew Voznytsa
>
>
>
> > -----Original Message-----
> > From: Juerg Haefliger [mailto:juergh@gmail.com]
>
> > Sent: Wednesday, January 30, 2008 8:20 PM
> > To: Andrew Voznytsa
> > Cc: lm-sensors@lm-sensors.org
> > Subject: Re: [lm-sensors] SMSC Super I/O: unknown chip with ID 0x8902
> > (was: lm85 in Intel S3000AH case)
> >
> > Hi Andrew,
> >
> >
> > On Jan 30, 2008 9:29 AM, Andrew Voznytsa <andrew.voznytsa@gmail.com>
> > wrote:
> > > # sensors-detect revision 5108 (2008-01-22 04:22:47 -0800)
> > >
> > > This program will help you determine which kernel modules you need
> > > to load to use lm_sensors most effectively. It is generally safe
> > > and recommended to accept the default answers to all questions,
> > > unless you know what you're doing.
> > >
> > > We can start with probing for (PCI) I2C or SMBus adapters.
> > > Do you want to probe now? (YES/no):
> > > Probing for PCI bus adapters...
> > > Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7
> > >
> > > We will now try to load each adapter module in turn.
> > > Load `i2c-i801' (say NO if built into your kernel)? (YES/no): no
> > > If you have undetectable or unsupported adapters, you can have them
> > > scanned by manually loading the modules before running this script.
> > >
> > > We are now going to do the I2C/SMBus adapter probings. Some chips may
> > > be double detected; we choose the one with the highest confidence
> > > value in that case.
> > > If you found that the adapter hung after probing a certain address,
> > > you can specify that address to remain unprobed.
> > >
> > > Next adapter: SMBus I801 adapter at 3000 (i2c-0)
> > > Do you want to scan it? (YES/no/selectively):
> > > Client found at address 0x2e
> > > Handled by driver `lm85' (already loaded), chip type `lm85'
> > > Client found at address 0x44
> > > Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
> > > Client found at address 0x50
> > > Probing for `Analog Devices ADM1033'...                     No
> > > Probing for `Analog Devices ADM1034'...                     No
> > > Probing for `SPD EEPROM'...                                 Yes
> > >     (confidence 8, not a hardware monitoring chip)
> > > Probing for `EDID EEPROM'...                                No
> > > Client found at address 0x51
> > > Probing for `Analog Devices ADM1033'...                     No
> > > Probing for `Analog Devices ADM1034'...                     No
> > > Probing for `SPD EEPROM'...                                 Yes
> > >     (confidence 8, not a hardware monitoring chip)
> > > Probing for `EDID EEPROM'...                                No
> > > Client found at address 0x52
> > > Probing for `Analog Devices ADM1033'...                     No
> > > Probing for `Analog Devices ADM1034'...                     No
> > > Probing for `SPD EEPROM'...                                 Yes
> > >     (confidence 8, not a hardware monitoring chip)
> > > Probing for `EDID EEPROM'...                                No
> > > Client found at address 0x53
> > > Probing for `Analog Devices ADM1033'...                     No
> > > Probing for `Analog Devices ADM1034'...                     No
> > > Probing for `SPD EEPROM'...                                 Yes
> > >     (confidence 8, not a hardware monitoring chip)
> > > Probing for `EDID EEPROM'...                                No
> > >
> > > Here it is. I'd notice that I used 2.6.23-gentoo-r3 kernel with builtin
> > lm85
> > > driver. If you need I can easily build any other kernel with any
> > > drivers/etc.
> >
> > Ah yes, that explains why the SCH5027 is not detected here. If you
> > have the time and care about it you can rebuild a kernel without the
> > builtin lm85 and rerun the attached sensors-detect. It should then
> > suggest the dme1737 driver for your chip. Anyways, I tested the
> > modified script with the dump file that you provided and the i2c-stub
> > driver so I'm confident it works correctly. I'll submit a patch for
> > sensors-detect shortly...
> >
> > ...juerg
> >
> >
> > > Some chips are also accessible through the ISA I/O ports. We have to
> > > write to arbitrary I/O ports to probe them. This is usually safe though.
> > > Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> > > Do you want to scan the ISA I/O ports? (YES/no):
> > > Probing for `National Semiconductor LM78' at 0x290...       No
> > > Probing for `National Semiconductor LM78-J' at 0x290...     No
> > > Probing for `National Semiconductor LM79' at 0x290...       No
> > > Probing for `Winbond W83781D' at 0x290...                   No
> > > Probing for `Winbond W83782D' at 0x290...                   No
> > > Probing for `Silicon Integrated Systems SIS5595'...         No
> > > Probing for `VIA VT82C686 Integrated Sensors'...            No
> > > Probing for `VIA VT8231 Integrated Sensors'...              No
> > > Probing for `IPMI BMC KCS' at 0xca0...                      No
> > > Probing for `IPMI BMC SMIC' at 0xca8...                     No
> > >
> > > Some Super I/O chips may also contain sensors. We have to write to
> > > standard I/O ports to probe them. This is usually safe.
> > > Do you want to scan for Super I/O sensors? (YES/no):
> > > Probing for Super-I/O at 0x2e/0x2f
> > > Trying family `National Semiconductor'...                   No
> > > Trying family `SMSC'...                                     Yes
> > > Found `SMSC SCH5027D-NW Super IO'
> > >     (hardware monitoring capabilities accessible via SMBus only)
> > > Probing for Super-I/O at 0x4e/0x4f
> > > Trying family `National Semiconductor'...                   No
> > > Trying family `SMSC'...                                     No
> > > Trying family `VIA/Winbond/Fintek'...                       No
> > > Trying family `ITE'...                                      No
> > >
> > > Some CPUs or memory controllers may also contain embedded sensors.
> > > Do you want to scan for them? (YES/no):
> > > AMD K8 thermal sensors...                                   No
> > > AMD K10 thermal sensors...                                  No
> > > Intel Core family thermal sensor...                         Success!
> > >     (driver `coretemp')
> > > Intel AMB FB-DIMM thermal sensor...                         No
> > >
> > > Now follows a summary of the probes I have just done.
> > > Just press ENTER to continue:
> > >
> > > Driver `lm85' (should be inserted):
> > >   Detects correctly:
> > >   * Bus `SMBus I801 adapter at 3000'
> > >     Busdriver `i2c-i801', I2C address 0x2e
> > >     Chip `lm85' (confidence: 6)
> > >
> > > Driver `coretemp' (should be inserted):
> > >   Detects correctly:
> > >   * Chip `Intel Core family thermal sensor' (confidence: 9)
> > >
> > > Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO):
> > > To load everything that is needed, add this to one of the system
> > > initialization scripts (e.g. /etc/rc.d/rc.local):
> > >
> > > #----cut here----
> > > # I2C adapter drivers
> > > modprobe i2c-i801
> > > # Chip drivers
> > > modprobe lm85
> > > # Warning: the required module coretemp is not currently installed
> > > # on your system. For status of 2.6 kernel ports check
> > > # http://www.lm-sensors.org/wiki/Devices. If driver is built
> > > # into the kernel, or unavailable, comment out the following line.
> > > modprobe coretemp
> > > /usr/bin/sensors -s
> > > #----cut here----
> > >
> > > If you have some drivers built into your kernel, the list above will
> > > contain too many modules. Skip the appropriate ones! You really
> > > should try these commands right now to make sure everything is
> > > working properly. Monitoring programs won't work until the needed
> > > modules are loaded.
> > >
> > > Best regards,
> > > Andrew Voznytsa
> > >
> > > > -----Original Message-----
> > > > From: Juerg Haefliger [mailto:juergh@gmail.com]
> > >
> > > > Sent: Wednesday, January 30, 2008 6:08 PM
> > > > To: Andrew Voznytsa
> > > > Cc: lm-sensors@lm-sensors.org
> > > > Subject: Re: [lm-sensors] SMSC Super I/O: unknown chip with ID 0x8902
> > > > (was: lm85 in Intel S3000AH case)
> > > >
> > > > Hi Andrew,
> > > >
> > > >
> > > > On Jan 30, 2008 5:18 AM, Andrew Voznytsa <andrew.voznytsa@gmail.com>
> > > > wrote:
> > > > > Hi Juerg,
> > > > >
> > > > > Of course - works perfectly. It said
> > > > >
> > > > > [..]
> > > > > Trying family `SMSC'...                                     Yes
> > > > > Found `SMSC SCH5027D-NW Super IO'
> > > > >     (hardware monitoring capabilities accessible via SMBus only)
> > > > > [..]
> > > >
> > > > There should be another instance where the SMSC is detected as an I2C
> > > > device. Can you post the complete log?
> > > >
> > > >
> > > > > If I can do anything else - just let me know.
> > > > >
> > > > > Should I try some lm-sensors's svn branch/revision to test if all
> > fans
> > > > are
> > > > > monitored now? If there is such - could you send me URL?
> > > >
> > > > That won't help. I need to update the dme1737 driver first which is
> > > > part of the kernel, not lm-sensors.
> > > >
> > > > ...juerg
> > > >
> > > >
> > > > > Many thanks,
> > > > > Andrew Voznytsa
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Juerg Haefliger [mailto:juergh@gmail.com]
> > > > > > Sent: Wednesday, January 30, 2008 7:22 AM
> > > > > > To: Andrew Voznytsa
> > > > > > Cc: lm-sensors@lm-sensors.org
> > > > > > Subject: Re: [lm-sensors] SMSC Super I/O: unknown chip with ID
> > 0x8902
> > > > > > (was: lm85 in Intel S3000AH case)
> > > > > >
> > > > > > Hi Andrew,
> > > > > >
> > > > > > Could you run the attached script and post the output? It should
> > > > > > correctly identify the SCH5027.
> > > > > >
> > > > > > ...juerg
> > > > > >
> > > > > >
> > > > > > On Jan 18, 2008 7:25 AM, Andrew Voznytsa
> > <andrew.voznytsa@gmail.com>
> > > > > > wrote:
> > > > > > >
> > > > > > > Hi Juerg,
> > > > > > >
> > > > > > > > > > > > > > > Trying family `SMSC'...
> > > > > > > > Yes
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Found unknown chip with ID 0x8902
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > This is indeed unknown. Can you check the markings
> > on
> > > > the
> > > > > > chip
> > > > > > > > so
> > > > > > > > > > that
> > > > > > > > > > > > > > we know what we're dealing with? From the product
> > > > picture
> > > > > > my
> > > > > > > > guess
> > > > > > > > > > is
> > > > > > > > > > > > > > it's the chip in the QFP package close to the IDE
> > > > > > connector.
> > > > > > > > It
> > > > > > > > > > should
> > > > > > > > > > > > > > read something like SMSC xyz.
> > > > > > > > > > > > >
> > > > > > > > > > > > > There is chip marked SMSC SCH-5027D(not sure that D,
> > > > might
> > > > > > be
> > > > > > > > 0)-NW
> > > > > > > > > > > > >
> > > > > > > > > > > > > According to spec which comes with MB it should be
> > SMSC
> > > > SC-
> > > > > > 5027D
> > > > > > > > > > > >
> > > > > > > > > > > > Can you run
> > > > > > > > > > > > i2cdetect -y 0
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Of course - here is output:
> > > > > > > > > > >
> > > > > > > > > > >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > > > > > > > > > > 00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
> > > > > > > > > > > 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > > > > > > > > > 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- UU --
> > > > > > > > > > > 30: 30 31 32 33 -- -- -- -- -- -- -- -- -- -- -- --
> > > > > > > > > > > 40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
> > > > > > > > > > > 50: 50 51 52 53 -- -- -- -- -- -- -- -- -- -- -- --
> > > > > > > > > > > 60: -- 61 -- 63 64 -- -- -- -- 69 -- -- -- -- -- --
> > > > > > > > > > > 70: -- -- -- -- -- -- -- --
> > > > > > > > > >
> > > > > > > > > > OK, I figured it out, I believe :-) I received the
> > datasheet
> > > > for
> > > > > > the
> > > > > > > > > > SCH5027 from SMSC and after a quick glance at it, it looks
> > > > like
> > > > > > the
> > > > > > > > > > hardware monitoring features of the DME1737, SCH5027 and
> > > > EMC6D10x
> > > > > > are
> > > > > > > > > > identical but they advertise themselves differently. In
> > your
> > > > case,
> > > > > > the
> > > > > > > > > > chip is detected as a EMC6D10x and sensors-detect suggests
> > the
> > > > > > lm85
> > > > > > > > > > driver. However, I believe the dme1737 driver is more
> > > > appropriate.
> > > > > > I
> > > > > > > > > > will take a closer look at the various datasheets over the
> > > > next
> > > > > > couple
> > > > > > > > > > of days to confirm my theory. In the meantime, you can try
> > the
> > > > > > > > > > following:
> > > > > > > > > > 1) remove the lm85 driver (rmmod lm85)
> > > > > > > > > > 2) force the dme1737 driver (modprobe dme1737
> > force=0,0x2e)
> > > > > > > > > > 3) post the dme1737-related messages in /var/log/messages
> > to
> > > > the
> > > > > > > > mailing
> > > > > > > > > > list
> > > > > > > > >
> > > > > > > > > Here is output:
> > > > > > > > >
> > > > > > > > > Jan 18 16:09:12 farm dme1737 0-002e: Failed to query Super-
> > IO
> > > > for
> > > > > > > > optional
> > > > > > > > > features.
> > > > > > > >
> > > > > > > > Ah yes, the dme1737 driver doesn't know anything about the
> > SCH5027
> > > > > > > > Super-IO so it can't determine if fans 5&6 and PWMs 5&6 are
> > > > > > > > configured.
> > > > > > > >
> > > > > > > >
> > > > > > > > > Jan 18 16:09:12 farm dme1737 0-002e: Optional features:
> > > > pwm3=yes,
> > > > > > > > pwm5=no,
> > > > > > > > > pwm6=no, fan3=yes, fan4=yes, fan5=no, fan6=no.
> > > > > > > >
> > > > > > > > If the BIOS shows 6 fans, fans 5&6 should become available
> > once
> > > > the
> > > > > > > > driver is fixed to recognize the SCH5027.
> > > > > > > >
> > > > > > > >
> > > > > > > > > Jan 18 16:09:12 farm i2c-adapter i2c-0: Found a DME1737 chip
> > at
> > > > 0x2e
> > > > > > > > (rev
> > > > > > > > > 0x00)
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Note that the SCH5027 only supports 4 fans, so you won't
> > see
> > > > > > fan5&6.
> > > > > > > > > > How many fans do you have in the machine? Can you see RPMs
> > for
> > > > all
> > > > > > of
> > > > > > > > > > them in the BIOS?
> > > > > > > >
> > > > > > > > Correction: This is not true. The SCH5027 supports 6 fans,
> > just
> > > > like
> > > > > > > > the dme1737.
> > > > > > > >
> > > > > > > >
> > > > > > > > > I've 2 fans - CPU (fan1) and chassis (fan5). They are
> > connected
> > > > as
> > > > > > > > Intel's
> > > > > > > > > manual says.
> > > > > > > > >
> > > > > > > > > BIOS shows 6 fans - it shows some (reasonable) RPMs for
> > fans1, 5
> > > > and
> > > > > > > > zero
> > > > > > > > > for rest (nothing attached there). BIOS is able to control
> > RPMs
> > > > > > itself,
> > > > > > > > > depending on CPU, chassis and DIMM temperature sensors.
> > > > > > > >
> > > > > > > > Again, I'll take a look at the datasheets and if the chips are
> > > > indeed
> > > > > > > > compatible, I'll fix the dme1737 driver to support the
> > sch5027. I
> > > > > > > > don't have access to a test machine until next week, so it has
> > to
> > > > wait
> > > > > > > > until then.
> > > > > > > >
> > > > > > >
> > > > > > > Just let me know if I can help with testing - I can't give
> > access to
> > > > my
> > > > > > > S3000AH-based system but definitely can run some tests, etc.
> > > > > > >
> > > > > > > All the best,
> > > > > > > Andrew
> > > > > > >
> > > > > > >
> > > > > > >
> > > > >
> > > > >
> > >
> > >
>
>

------=_Part_6770_22556584.1202196709342
Content-Type: application/octet-stream; name=dme1737.c
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fca4sxlj0
Content-Disposition: attachment; filename=dme1737.c

LyoKICogZG1lMTczNy5jIC0gRHJpdmVyIGZvciB0aGUgU01TQyBETUUxNzM3LCBBc3VzIEE4MDAw
LCBTTVNDIFNDSDUwMjcgYW5kCiAqICAgICAgICAgICAgIFNDSDMxMXggU3VwZXItSS9PIGNoaXBz
IGludGVncmF0ZWQgaGFyZHdhcmUgbW9uaXRvcmluZyBmZWF0dXJlcy4KICogQ29weXJpZ2h0IChj
KSAyMDA3IEp1ZXJnIEhhZWZsaWdlciA8anVlcmdoQGdtYWlsLmNvbT4KICoKICogVGhpcyBkcml2
ZXIgaXMgYW4gSTJDL0lTQSBoeWJyaWQsIG1lYW5pbmcgdGhhdCBpdCB1c2VzIHRoZSBJMkMgYnVz
IHRvIGFjY2VzcwogKiB0aGUgY2hpcCByZWdpc3RlcnMgaWYgYSBETUUxNzM3IChvciBBODAwMCkg
aXMgZm91bmQgYW5kIHRoZSBJU0EgYnVzIGlmIGEKICogU0NIMzExeCBjaGlwIGlzIGZvdW5kLiBC
b3RoIHR5cGVzIG9mIGNoaXBzIGhhdmUgdmVyeSBzaW1pbGFyIGhhcmR3YXJlCiAqIG1vbml0b3Jp
bmcgY2FwYWJpbGl0aWVzIGJ1dCBkaWZmZXIgaW4gdGhlIHdheSB0aGV5IGNhbiBiZSBhY2Nlc3Nl
ZC4KICoKICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vciBtb2RpZnkKICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKICogdGhlIEZyZWUgU29mdHdhcmUg
Rm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKICogKGF0IHlv
dXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KICoKICogVGhpcyBwcm9ncmFtIGlzIGRpc3Ry
aWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCiAqIGJ1dCBXSVRIT1VU
IEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCiAqIE1F
UkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0
aGUKICogR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KICoKICog
WW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UKICogYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhl
IEZyZWUgU29mdHdhcmUKICogRm91bmRhdGlvbiwgSW5jLiwgNjc1IE1hc3MgQXZlLCBDYW1icmlk
Z2UsIE1BIDAyMTM5LCBVU0EuCiAqLwoKI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgojaW5jbHVk
ZSA8bGludXgvaW5pdC5oPgojaW5jbHVkZSA8bGludXgvc2xhYi5oPgojaW5jbHVkZSA8bGludXgv
amlmZmllcy5oPgojaW5jbHVkZSA8bGludXgvaTJjLmg+CiNpbmNsdWRlIDxsaW51eC9wbGF0Zm9y
bV9kZXZpY2UuaD4KI2luY2x1ZGUgPGxpbnV4L2h3bW9uLmg+CiNpbmNsdWRlIDxsaW51eC9od21v
bi1zeXNmcy5oPgojaW5jbHVkZSA8bGludXgvaHdtb24tdmlkLmg+CiNpbmNsdWRlIDxsaW51eC9l
cnIuaD4KI2luY2x1ZGUgPGxpbnV4L211dGV4Lmg+CiNpbmNsdWRlIDxhc20vaW8uaD4KCi8qIElT
QSBkZXZpY2UsIGlmIGZvdW5kICovCnN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
OwoKLyogTW9kdWxlIGxvYWQgcGFyYW1ldGVycyAqLwpzdGF0aWMgaW50IGZvcmNlX3N0YXJ0Owpt
b2R1bGVfcGFyYW0oZm9yY2Vfc3RhcnQsIGJvb2wsIDApOwpNT0RVTEVfUEFSTV9ERVNDKGZvcmNl
X3N0YXJ0LCAiRm9yY2UgdGhlIGNoaXAgdG8gc3RhcnQgbW9uaXRvcmluZyBpbnB1dHMiKTsKCnN0
YXRpYyB1bnNpZ25lZCBzaG9ydCBmb3JjZV9pZDsKbW9kdWxlX3BhcmFtKGZvcmNlX2lkLCB1c2hv
cnQsIDApOwpNT0RVTEVfUEFSTV9ERVNDKGZvcmNlX2lkLCAiT3ZlcnJpZGUgdGhlIGRldGVjdGVk
IGRldmljZSBJRCIpOwoKLyogQWRkcmVzc2VzIHRvIHNjYW4gKi8Kc3RhdGljIHVuc2lnbmVkIHNo
b3J0IG5vcm1hbF9pMmNbXSA9IHsweDJjLCAweDJkLCAweDJlLCBJMkNfQ0xJRU5UX0VORH07Cgov
KiBJbnNtb2QgcGFyYW1ldGVycyAqLwpJMkNfQ0xJRU5UX0lOU01PRF8yKGRtZTE3MzcsIHNjaDUw
MjcpOwoKLyogSVNBIGNoaXAgdHlwZXMgZm9yIGRldmljZSBkaWZmZXJlbnRpYXRpb24gKi8KZW51
bSBpc2FfY2hpcHMgeyBzY2gzMTF4ID0gc2NoNTAyNyArIDEgfTsKCi8qIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQog
KiBSZWdpc3RlcnMKICoKICogVGhlIHNlbnNvcnMgYXJlIGRlZmluZWQgYXMgZm9sbG93czoKICoK
ICogVm9sdGFnZXMgICAgICAgICAgICAgICAgICAgICAgICAgIFRlbXBlcmF0dXJlcwogKiAtLS0t
LS0tLSAgICAgICAgICAgICAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tCiAqIGluMCAgICs1VlRS
ICgrNVYgc3RkYnkpICAgICAgICAgICB0ZW1wMSAgIFJlbW90ZSBkaW9kZSAxCiAqIGluMSAgIFZj
Y3AgIChwcm9jIGNvcmUpICAgICAgICAgICB0ZW1wMiAgIEludGVybmFsIHRlbXAKICogaW4yICAg
VkNDICAgKGludGVybmFsICszLjNWKSAgICAgIHRlbXAzICAgUmVtb3RlIGRpb2RlIDIKICogaW4z
ICAgKzVWCiAqIGluNCAgICsxMlYKICogaW41ICAgVlRSICAgKCszLjNWIHN0YnkpCiAqIGluNiAg
IFZiYXQKICoKICogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICovCgovKiBWb2x0YWdlcyAoaW4pIG51bWJlcmVkIDAt
NiAoaXgpICovCiNkZWZpbmUJRE1FMTczN19SRUdfSU4oaXgpCQkoKGl4KSA8IDUgPyAweDIwICsg
KGl4KSBcCgkJCQkJCSAgOiAweDk0ICsgKGl4KSkKI2RlZmluZQlETUUxNzM3X1JFR19JTl9NSU4o
aXgpCQkoKGl4KSA8IDUgPyAweDQ0ICsgKGl4KSAqIDIgXAoJCQkJCQkgIDogMHg5MSArIChpeCkg
KiAyKQojZGVmaW5lCURNRTE3MzdfUkVHX0lOX01BWChpeCkJCSgoaXgpIDwgNSA/IDB4NDUgKyAo
aXgpICogMiBcCgkJCQkJCSAgOiAweDkyICsgKGl4KSAqIDIpCgovKiBUZW1wZXJhdHVyZXMgKHRl
bXApIG51bWJlcmVkIDAtMiAoaXgpICovCiNkZWZpbmUgRE1FMTczN19SRUdfVEVNUChpeCkJCSgw
eDI1ICsgKGl4KSkKI2RlZmluZSBETUUxNzM3X1JFR19URU1QX01JTihpeCkJKDB4NGUgKyAoaXgp
ICogMikKI2RlZmluZSBETUUxNzM3X1JFR19URU1QX01BWChpeCkJKDB4NGYgKyAoaXgpICogMikK
I2RlZmluZSBETUUxNzM3X1JFR19URU1QX09GRlNFVChpeCkJKChpeCkgPT0gMCA/IDB4MWYgXAoJ
CQkJCQkgICA6IDB4MWMgKyAoaXgpKQoKLyogVm9sdGFnZSBhbmQgdGVtcGVyYXR1cmUgTFNCcwog
KiBUaGUgTFNCcyAoNCBiaXRzIGVhY2gpIGFyZSBzdG9yZWQgaW4gNSByZWdpc3RlcnMgd2l0aCB0
aGUgZm9sbG93aW5nIGxheW91dHM6CiAqICAgIElOX1RFTVBfTFNCKDApID0gW2luNSwgaW42XQog
KiAgICBJTl9URU1QX0xTQigxKSA9IFt0ZW1wMywgdGVtcDFdCiAqICAgIElOX1RFTVBfTFNCKDIp
ID0gW2luNCwgdGVtcDJdCiAqICAgIElOX1RFTVBfTFNCKDMpID0gW2luMywgaW4wXQogKiAgICBJ
Tl9URU1QX0xTQig0KSA9IFtpbjIsIGluMV0gKi8KI2RlZmluZSBETUUxNzM3X1JFR19JTl9URU1Q
X0xTQihpeCkJKDB4ODQgKyAoaXgpKQpzdGF0aWMgY29uc3QgdTggRE1FMTczN19SRUdfSU5fTFNC
W10gPSB7MywgNCwgNCwgMywgMiwgMCwgMH07CnN0YXRpYyBjb25zdCB1OCBETUUxNzM3X1JFR19J
Tl9MU0JfU0hMW10gPSB7NCwgNCwgMCwgMCwgMCwgMCwgNH07CnN0YXRpYyBjb25zdCB1OCBETUUx
NzM3X1JFR19URU1QX0xTQltdID0gezEsIDIsIDF9OwpzdGF0aWMgY29uc3QgdTggRE1FMTczN19S
RUdfVEVNUF9MU0JfU0hMW10gPSB7NCwgNCwgMH07CgovKiBGYW5zIG51bWJlcmVkIDAtNSAoaXgp
ICovCiNkZWZpbmUgRE1FMTczN19SRUdfRkFOKGl4KQkJKChpeCkgPCA0ID8gMHgyOCArIChpeCkg
KiAyIFwKCQkJCQkJICA6IDB4YTEgKyAoaXgpICogMikKI2RlZmluZSBETUUxNzM3X1JFR19GQU5f
TUlOKGl4KQkJKChpeCkgPCA0ID8gMHg1NCArIChpeCkgKiAyIFwKCQkJCQkJICA6IDB4YTUgKyAo
aXgpICogMikKI2RlZmluZSBETUUxNzM3X1JFR19GQU5fT1BUKGl4KQkJKChpeCkgPCA0ID8gMHg5
MCArIChpeCkgXAoJCQkJCQkgIDogMHhiMiArIChpeCkpCiNkZWZpbmUgRE1FMTczN19SRUdfRkFO
X01BWChpeCkJCSgweGI0ICsgKGl4KSkgLyogb25seSBmb3IgZmFuWzQtNV0gKi8KCi8qIFBXTXMg
bnVtYmVyZWQgMC0yLCA0LTUgKGl4KSAqLwojZGVmaW5lIERNRTE3MzdfUkVHX1BXTShpeCkJCSgo
aXgpIDwgMyA/IDB4MzAgKyAoaXgpIFwKCQkJCQkJICA6IDB4YTEgKyAoaXgpKQojZGVmaW5lIERN
RTE3MzdfUkVHX1BXTV9DT05GSUcoaXgpCSgweDVjICsgKGl4KSkgLyogb25seSBmb3IgcHdtWzAt
Ml0gKi8KI2RlZmluZSBETUUxNzM3X1JFR19QV01fTUlOKGl4KQkJKDB4NjQgKyAoaXgpKSAvKiBv
bmx5IGZvciBwd21bMC0yXSAqLwojZGVmaW5lIERNRTE3MzdfUkVHX1BXTV9GUkVRKGl4KQkoKGl4
KSA8IDMgPyAweDVmICsgKGl4KSBcCgkJCQkJCSAgOiAweGEzICsgKGl4KSkKLyogVGhlIGxheW91
dCBvZiB0aGUgcmFtcCByYXRlIHJlZ2lzdGVycyBpcyBkaWZmZXJlbnQgZnJvbSB0aGUgb3RoZXIg
cHdtCiAqIHJlZ2lzdGVycy4gVGhlIGJpdHMgZm9yIHRoZSAzIFBXTXMgYXJlIHN0b3JlZCBpbiAy
IHJlZ2lzdGVyczoKICogICAgUFdNX1JSKDApID0gW09GRjMsIE9GRjIsICBPRkYxLCAgUkVTLCAg
IFJSMUUsIFJSMS0yLCBSUjEtMSwgUlIxLTBdCiAqICAgIFBXTV9SUigxKSA9IFtSUjJFLCBSUjIt
MiwgUlIyLTEsIFJSMi0wLCBSUjNFLCBSUjMtMiwgUlIzLTEsIFJSMy0wXSAqLwojZGVmaW5lIERN
RTE3MzdfUkVHX1BXTV9SUihpeCkJCSgweDYyICsgKGl4KSkgLyogb25seSBmb3IgcHdtWzAtMl0g
Ki8KCi8qIFRoZXJtYWwgem9uZXMgMC0yICovCiNkZWZpbmUgRE1FMTczN19SRUdfWk9ORV9MT1co
aXgpCSgweDY3ICsgKGl4KSkKI2RlZmluZSBETUUxNzM3X1JFR19aT05FX0FCUyhpeCkJKDB4NmEg
KyAoaXgpKQovKiBUaGUgbGF5b3V0IG9mIHRoZSBoeXN0ZXJlc2lzIHJlZ2lzdGVycyBpcyBkaWZm
ZXJlbnQgZnJvbSB0aGUgb3RoZXIgem9uZQogKiByZWdpc3RlcnMuIFRoZSBiaXRzIGZvciB0aGUg
MyB6b25lcyBhcmUgc3RvcmVkIGluIDIgcmVnaXN0ZXJzOgogKiAgICBaT05FX0hZU1QoMCkgPSBb
SDEtMywgIEgxLTIsICBIMS0xLCBIMS0wLCBIMi0zLCBIMi0yLCBIMi0xLCBIMi0wXQogKiAgICBa
T05FX0hZU1QoMSkgPSBbSDMtMywgIEgzLTIsICBIMy0xLCBIMy0wLCBSRVMsICBSRVMsICBSRVMs
ICBSRVNdICovCiNkZWZpbmUgRE1FMTczN19SRUdfWk9ORV9IWVNUKGl4KQkoMHg2ZCArIChpeCkp
CgovKiBBbGFybSByZWdpc3RlcnMgYW5kIGJpdCBtYXBwaW5nCiAqIFRoZSAzIDgtYml0IGFsYXJt
IHJlZ2lzdGVycyB3aWxsIGJlIGNvbmNhdGVuYXRlZCB0byBhIHNpbmdsZSAzMi1iaXQKICogYWxh
cm0gdmFsdWUgWzAsIEFMQVJNMywgQUxBUk0yLCBBTEFSTTFdLiAqLwojZGVmaW5lIERNRTE3Mzdf
UkVHX0FMQVJNMQkJMHg0MQojZGVmaW5lIERNRTE3MzdfUkVHX0FMQVJNMgkJMHg0MgojZGVmaW5l
IERNRTE3MzdfUkVHX0FMQVJNMwkJMHg4MwpzdGF0aWMgY29uc3QgdTggRE1FMTczN19CSVRfQUxB
Uk1fSU5bXSA9IHswLCAxLCAyLCAzLCA4LCAxNiwgMTd9OwpzdGF0aWMgY29uc3QgdTggRE1FMTcz
N19CSVRfQUxBUk1fVEVNUFtdID0gezQsIDUsIDZ9OwpzdGF0aWMgY29uc3QgdTggRE1FMTczN19C
SVRfQUxBUk1fRkFOW10gPSB7MTAsIDExLCAxMiwgMTMsIDIyLCAyM307CgovKiBNaXNjZWxsYW5l
b3VzIHJlZ2lzdGVycyAqLwojZGVmaW5lIERNRTE3MzdfUkVHX0RFVklDRQkJMHgzZAojZGVmaW5l
IERNRTE3MzdfUkVHX0NPTVBBTlkJCTB4M2UKI2RlZmluZSBETUUxNzM3X1JFR19WRVJTVEVQCQkw
eDNmCiNkZWZpbmUgRE1FMTczN19SRUdfQ09ORklHCQkweDQwCiNkZWZpbmUgRE1FMTczN19SRUdf
Q09ORklHMgkJMHg3ZgojZGVmaW5lIERNRTE3MzdfUkVHX1ZJRAkJCTB4NDMKI2RlZmluZSBETUUx
NzM3X1JFR19UQUNIX1BXTQkJMHg4MQoKLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAqIE1pc2MgZGVmaW5lcwog
KiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0gKi8KCi8qIENoaXAgaWRlbnRpZmljYXRpb24gKi8KI2RlZmluZSBETUUx
NzM3X0NPTVBBTllfU01TQwkweDVjCiNkZWZpbmUgRE1FMTczN19WRVJTVEVQCQkweDg4CiNkZWZp
bmUgRE1FMTczN19WRVJTVEVQX01BU0sJMHhmOAojZGVmaW5lIFNDSDMxMVhfREVWSUNFCQkweDhj
CiNkZWZpbmUgU0NINTAyN19WRVJTVEVQX01JTgkweDY5CiNkZWZpbmUgU0NINTAyN19WRVJTVEVQ
X01BWAkweDZmCgovKiBMZW5ndGggb2YgSVNBIGFkZHJlc3Mgc2VnbWVudCAqLwojZGVmaW5lIERN
RTE3MzdfRVhURU5UCTIKCi8qIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogKiBEYXRhIHN0cnVjdHVyZXMgYW5kIG1h
bmlwdWxhdGlvbiB0aGVyZW9mCiAqIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAqLwoKLyogRm9yIElTQSBjaGlwcywg
d2UgYWJ1c2UgdGhlIGkyY19jbGllbnQgYWRkciBhbmQgbmFtZSBmaWVsZHMuIFdlIGFsc28gdXNl
CiAgIHRoZSBkcml2ZXIgZmllbGQgdG8gZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIEkyQyBhbmQgSVNB
IGNoaXBzLiAqLwpzdHJ1Y3QgZG1lMTczN19kYXRhIHsKCXN0cnVjdCBpMmNfY2xpZW50IGNsaWVu
dDsKCXN0cnVjdCBkZXZpY2UgKmh3bW9uX2RldjsKCglzdHJ1Y3QgbXV0ZXggdXBkYXRlX2xvY2s7
CglpbnQgdmFsaWQ7CQkJLyogIT0wIGlmIGZvbGxvd2luZyBmaWVsZHMgYXJlIHZhbGlkICovCgl1
bnNpZ25lZCBsb25nIGxhc3RfdXBkYXRlOwkvKiBpbiBqaWZmaWVzICovCgl1bnNpZ25lZCBsb25n
IGxhc3RfdmJhdDsJLyogaW4gamlmZmllcyAqLwoJZW51bSBjaGlwcyB0eXBlOwoKCXU4IHZpZDsK
CXU4IHB3bV9ycl9lbjsKCXU4IGhhc19wd207Cgl1OCBoYXNfZmFuOwoKCS8qIFJlZ2lzdGVyIHZh
bHVlcyAqLwoJdTE2IGluWzddOwoJdTggIGluX21pbls3XTsKCXU4ICBpbl9tYXhbN107CglzMTYg
dGVtcFszXTsKCXM4ICB0ZW1wX21pblszXTsKCXM4ICB0ZW1wX21heFszXTsKCXM4ICB0ZW1wX29m
ZnNldFszXTsKCXU4ICBjb25maWc7Cgl1OCAgY29uZmlnMjsKCXU4ICB2cm07Cgl1MTYgZmFuWzZd
OwoJdTE2IGZhbl9taW5bNl07Cgl1OCAgZmFuX21heFsyXTsKCXU4ICBmYW5fb3B0WzZdOwoJdTgg
IHB3bVs2XTsKCXU4ICBwd21fbWluWzNdOwoJdTggIHB3bV9jb25maWdbM107Cgl1OCAgcHdtX2Fj
elszXTsKCXU4ICBwd21fZnJlcVs2XTsKCXU4ICBwd21fcnJbMl07Cgl1OCAgem9uZV9sb3dbM107
Cgl1OCAgem9uZV9hYnNbM107Cgl1OCAgem9uZV9oeXN0WzJdOwoJdTMyIGFsYXJtczsKfTsKCi8q
IE5vbWluYWwgdm9sdGFnZSB2YWx1ZXMgKi8Kc3RhdGljIGNvbnN0IGludCBJTl9OT01JTkFMW10g
PSB7NTAwMCwgMjI1MCwgMzMwMCwgNTAwMCwgMTIwMDAsIDMzMDAsIDMzMDB9OwoKLyogVm9sdGFn
ZSBpbnB1dAogKiBWb2x0YWdlIGlucHV0cyBoYXZlIDE2IGJpdHMgcmVzb2x1dGlvbiwgbGltaXQg
dmFsdWVzIGhhdmUgOCBiaXRzCiAqIHJlc29sdXRpb24uICovCnN0YXRpYyBpbmxpbmUgaW50IElO
X0ZST01fUkVHKGludCByZWcsIGludCBpeCwgaW50IHJlcykKewoJcmV0dXJuIChyZWcgKiBJTl9O
T01JTkFMW2l4XSArICgzIDw8IChyZXMgLSAzKSkpIC8gKDMgPDwgKHJlcyAtIDIpKTsKfQoKc3Rh
dGljIGlubGluZSBpbnQgSU5fVE9fUkVHKGludCB2YWwsIGludCBpeCkKewoJcmV0dXJuIFNFTlNP
UlNfTElNSVQoKHZhbCAqIDE5MiArIElOX05PTUlOQUxbaXhdIC8gMikgLwoJCQkgICAgIElOX05P
TUlOQUxbaXhdLCAwLCAyNTUpOwp9CgovKiBUZW1wZXJhdHVyZSBpbnB1dAogKiBUaGUgcmVnaXN0
ZXIgdmFsdWVzIHJlcHJlc2VudCB0ZW1wZXJhdHVyZXMgaW4gMidzIGNvbXBsZW1lbnQgbm90YXRp
b24gZnJvbQogKiAtMTI3IGRlZ3JlZXMgQyB0byArMTI3IGRlZ3JlZXMgQy4gVGVtcCBpbnB1dHMg
aGF2ZSAxNiBiaXRzIHJlc29sdXRpb24sIGxpbWl0CiAqIHZhbHVlcyBoYXZlIDggYml0cyByZXNv
bHV0aW9uLiAqLwpzdGF0aWMgaW5saW5lIGludCBURU1QX0ZST01fUkVHKGludCByZWcsIGludCBy
ZXMpCnsKCXJldHVybiAocmVnICogMTAwMCkgPj4gKHJlcyAtIDgpOwp9CgpzdGF0aWMgaW5saW5l
IGludCBURU1QX1RPX1JFRyhpbnQgdmFsKQp7CglyZXR1cm4gU0VOU09SU19MSU1JVCgodmFsIDwg
MCA/IHZhbCAtIDUwMCA6IHZhbCArIDUwMCkgLyAxMDAwLAoJCQkgICAgIC0xMjgsIDEyNyk7Cn0K
Ci8qIFRlbXBlcmF0dXJlIHJhbmdlICovCnN0YXRpYyBjb25zdCBpbnQgVEVNUF9SQU5HRVtdID0g
ezIwMDAsIDI1MDAsIDMzMzMsIDQwMDAsIDUwMDAsIDY2NjYsIDgwMDAsCgkJCQkgMTAwMDAsIDEz
MzMzLCAxNjAwMCwgMjAwMDAsIDI2NjY2LCAzMjAwMCwKCQkJCSA0MDAwMCwgNTMzMzMsIDgwMDAw
fTsKCnN0YXRpYyBpbmxpbmUgaW50IFRFTVBfUkFOR0VfRlJPTV9SRUcoaW50IHJlZykKewoJcmV0
dXJuIFRFTVBfUkFOR0VbKHJlZyA+PiA0KSAmIDB4MGZdOwp9CgpzdGF0aWMgaW50IFRFTVBfUkFO
R0VfVE9fUkVHKGludCB2YWwsIGludCByZWcpCnsKCWludCBpOwoKCWZvciAoaSA9IDE1OyBpID4g
MDsgaS0tKSB7CgkJaWYgKHZhbCA+IChURU1QX1JBTkdFW2ldICsgVEVNUF9SQU5HRVtpIC0gMV0g
KyAxKSAvIDIpIHsKCQkJYnJlYWs7CgkJfQoJfQoKCXJldHVybiAocmVnICYgMHgwZikgfCAoaSA8
PCA0KTsKfQoKLyogVGVtcGVyYXR1cmUgaHlzdGVyZXNpcwogKiBSZWdpc3RlciBsYXlvdXQ6CiAq
ICAgIHJlZ1swXSA9IFtIMS0zLCBIMS0yLCBIMS0xLCBIMS0wLCBIMi0zLCBIMi0yLCBIMi0xLCBI
Mi0wXQogKiAgICByZWdbMV0gPSBbSDMtMywgSDMtMiwgSDMtMSwgSDMtMCwgeHh4eCwgeHh4eCwg
eHh4eCwgeHh4eF0gKi8Kc3RhdGljIGlubGluZSBpbnQgVEVNUF9IWVNUX0ZST01fUkVHKGludCBy
ZWcsIGludCBpeCkKewoJcmV0dXJuICgoKGl4ID09IDEpID8gcmVnIDogcmVnID4+IDQpICYgMHgw
ZikgKiAxMDAwOwp9CgpzdGF0aWMgaW5saW5lIGludCBURU1QX0hZU1RfVE9fUkVHKGludCB2YWws
IGludCBpeCwgaW50IHJlZykKewoJaW50IGh5c3QgPSBTRU5TT1JTX0xJTUlUKCh2YWwgKyA1MDAp
IC8gMTAwMCwgMCwgMTUpOwoKCXJldHVybiAoaXggPT0gMSkgPyAocmVnICYgMHhmMCkgfCBoeXN0
IDogKHJlZyAmIDB4MGYpIHwgKGh5c3QgPDwgNCk7Cn0KCi8qIEZhbiBpbnB1dCBSUE0gKi8Kc3Rh
dGljIGlubGluZSBpbnQgRkFOX0ZST01fUkVHKGludCByZWcsIGludCB0cGMpCnsKCWlmICh0cGMp
IHsKCQlyZXR1cm4gdHBjICogcmVnOwoJfSBlbHNlIHsKCQlyZXR1cm4gKHJlZyA9PSAwIHx8IHJl
ZyA9PSAweGZmZmYpID8gMCA6IDkwMDAwICogNjAgLyByZWc7Cgl9Cn0KCnN0YXRpYyBpbmxpbmUg
aW50IEZBTl9UT19SRUcoaW50IHZhbCwgaW50IHRwYykKewoJaWYgKHRwYykgewoJCXJldHVybiBT
RU5TT1JTX0xJTUlUKHZhbCAvIHRwYywgMCwgMHhmZmZmKTsKCX0gZWxzZSB7CgkJcmV0dXJuICh2
YWwgPD0gMCkgPyAweGZmZmYgOgoJCQlTRU5TT1JTX0xJTUlUKDkwMDAwICogNjAgLyB2YWwsIDAs
IDB4ZmZmZSk7Cgl9Cn0KCi8qIEZhbiBUUEMgKHRhY2ggcHVsc2UgY291bnQpCiAqIENvbnZlcnRz
IGEgcmVnaXN0ZXIgdmFsdWUgdG8gYSBUUEMgbXVsdGlwbGllciBvciByZXR1cm5zIDAgaWYgdGhl
IHRhY2hvbWV0ZXIKICogaXMgY29uZmlndXJlZCBpbiBsZWdhY3kgKG5vbi10cGMpIG1vZGUgKi8K
c3RhdGljIGlubGluZSBpbnQgRkFOX1RQQ19GUk9NX1JFRyhpbnQgcmVnKQp7CglyZXR1cm4gKHJl
ZyAmIDB4MjApID8gMCA6IDYwID4+IChyZWcgJiAweDAzKTsKfQoKLyogRmFuIHR5cGUKICogVGhl
IHR5cGUgb2YgYSBmYW4gaXMgZXhwcmVzc2VkIGluIG51bWJlciBvZiBwdWxzZXMtcGVyLXJldm9s
dXRpb24gdGhhdCBpdAogKiBlbWl0cyAqLwpzdGF0aWMgaW5saW5lIGludCBGQU5fVFlQRV9GUk9N
X1JFRyhpbnQgcmVnKQp7CglpbnQgZWRnZSA9IChyZWcgPj4gMSkgJiAweDAzOwoKCXJldHVybiAo
ZWRnZSA+IDApID8gMSA8PCAoZWRnZSAtIDEpIDogMDsKfQoKc3RhdGljIGlubGluZSBpbnQgRkFO
X1RZUEVfVE9fUkVHKGludCB2YWwsIGludCByZWcpCnsKCWludCBlZGdlID0gKHZhbCA9PSA0KSA/
IDMgOiB2YWw7CgoJcmV0dXJuIChyZWcgJiAweGY5KSB8IChlZGdlIDw8IDEpOwp9CgovKiBGYW4g
bWF4IFJQTSAqLwpzdGF0aWMgY29uc3QgaW50IEZBTl9NQVhbXSA9IHsweDU0LCAweDM4LCAweDJh
LCAweDIxLCAweDFjLCAweDE4LCAweDE1LCAweDEyLAoJCQkgICAgICAweDExLCAweDBmLCAweDBl
fTsKCnN0YXRpYyBpbnQgRkFOX01BWF9GUk9NX1JFRyhpbnQgcmVnKQp7CglpbnQgaTsKCglmb3Ig
KGkgPSAxMDsgaSA+IDA7IGktLSkgewoJCWlmIChyZWcgPT0gRkFOX01BWFtpXSkgewoJCQlicmVh
azsKCQl9Cgl9CgoJcmV0dXJuIDEwMDAgKyBpICogNTAwOwp9CgpzdGF0aWMgaW50IEZBTl9NQVhf
VE9fUkVHKGludCB2YWwpCnsKCWludCBpOwoKCWZvciAoaSA9IDEwOyBpID4gMDsgaS0tKSB7CgkJ
aWYgKHZhbCA+ICgxMDAwICsgKGkgLSAxKSAqIDUwMCkpIHsKCQkJYnJlYWs7CgkJfQoJfQoKCXJl
dHVybiBGQU5fTUFYW2ldOwp9CgovKiBQV00gZW5hYmxlCiAqIFJlZ2lzdGVyIHRvIGVuYWJsZSBt
YXBwaW5nOgogKiAwMDA6ICAyICBmYW4gb24gem9uZSAxIGF1dG8KICogMDAxOiAgMiAgZmFuIG9u
IHpvbmUgMiBhdXRvCiAqIDAxMDogIDIgIGZhbiBvbiB6b25lIDMgYXV0bwogKiAwMTE6ICAwICBm
YW4gZnVsbCBvbgogKiAxMDA6IC0xICBmYW4gZGlzYWJsZWQKICogMTAxOiAgMiAgZmFuIG9uIGhv
dHRlc3Qgb2Ygem9uZXMgMiwzIGF1dG8KICogMTEwOiAgMiAgZmFuIG9uIGhvdHRlc3Qgb2Ygem9u
ZXMgMSwyLDMgYXV0bwogKiAxMTE6ICAxICBmYW4gaW4gbWFudWFsIG1vZGUgKi8Kc3RhdGljIGlu
bGluZSBpbnQgUFdNX0VOX0ZST01fUkVHKGludCByZWcpCnsKCXN0YXRpYyBjb25zdCBpbnQgZW5b
XSA9IHsyLCAyLCAyLCAwLCAtMSwgMiwgMiwgMX07CgoJcmV0dXJuIGVuWyhyZWcgPj4gNSkgJiAw
eDA3XTsKfQoKc3RhdGljIGlubGluZSBpbnQgUFdNX0VOX1RPX1JFRyhpbnQgdmFsLCBpbnQgcmVn
KQp7CglpbnQgZW4gPSAodmFsID09IDEpID8gNyA6IDM7CgoJcmV0dXJuIChyZWcgJiAweDFmKSB8
ICgoZW4gJiAweDA3KSA8PCA1KTsKfQoKLyogUFdNIGF1dG8gY2hhbm5lbHMgem9uZQogKiBSZWdp
c3RlciB0byBhdXRvIGNoYW5uZWxzIHpvbmUgbWFwcGluZyAoQUNaIGlzIGEgYml0ZmllbGQgd2l0
aCBiaXQgeAogKiBjb3JyZXNwb25kaW5nIHRvIHpvbmUgeCsxKToKICogMDAwOiAwMDEgIGZhbiBv
biB6b25lIDEgYXV0bwogKiAwMDE6IDAxMCAgZmFuIG9uIHpvbmUgMiBhdXRvCiAqIDAxMDogMTAw
ICBmYW4gb24gem9uZSAzIGF1dG8KICogMDExOiAwMDAgIGZhbiBmdWxsIG9uCiAqIDEwMDogMDAw
ICBmYW4gZGlzYWJsZWQKICogMTAxOiAxMTAgIGZhbiBvbiBob3R0ZXN0IG9mIHpvbmVzIDIsMyBh
dXRvCiAqIDExMDogMTExICBmYW4gb24gaG90dGVzdCBvZiB6b25lcyAxLDIsMyBhdXRvCiAqIDEx
MTogMDAwICBmYW4gaW4gbWFudWFsIG1vZGUgKi8Kc3RhdGljIGlubGluZSBpbnQgUFdNX0FDWl9G
Uk9NX1JFRyhpbnQgcmVnKQp7CglzdGF0aWMgY29uc3QgaW50IGFjeltdID0gezEsIDIsIDQsIDAs
IDAsIDYsIDcsIDB9OwoKCXJldHVybiBhY3pbKHJlZyA+PiA1KSAmIDB4MDddOwp9CgpzdGF0aWMg
aW5saW5lIGludCBQV01fQUNaX1RPX1JFRyhpbnQgdmFsLCBpbnQgcmVnKQp7CglpbnQgYWN6ID0g
KHZhbCA9PSA0KSA/IDIgOiB2YWwgLSAxOwoKCXJldHVybiAocmVnICYgMHgxZikgfCAoKGFjeiAm
IDB4MDcpIDw8IDUpOwp9CgovKiBQV00gZnJlcXVlbmN5ICovCnN0YXRpYyBjb25zdCBpbnQgUFdN
X0ZSRVFbXSA9IHsxMSwgMTUsIDIyLCAyOSwgMzUsIDQ0LCA1OSwgODgsCgkJCSAgICAgICAxNTAw
MCwgMjAwMDAsIDMwMDAwLCAyNTAwMCwgMCwgMCwgMCwgMH07CgpzdGF0aWMgaW5saW5lIGludCBQ
V01fRlJFUV9GUk9NX1JFRyhpbnQgcmVnKQp7CglyZXR1cm4gUFdNX0ZSRVFbcmVnICYgMHgwZl07
Cn0KCnN0YXRpYyBpbnQgUFdNX0ZSRVFfVE9fUkVHKGludCB2YWwsIGludCByZWcpCnsKCWludCBp
OwoKCS8qIHRoZSBmaXJzdCB0d28gY2FzZXMgYXJlIHNwZWNpYWwgLSBzdHVwaWQgY2hpcCBkZXNp
Z24hICovCglpZiAodmFsID4gMjc1MDApIHsKCQlpID0gMTA7Cgl9IGVsc2UgaWYgKHZhbCA+IDIy
NTAwKSB7CgkJaSA9IDExOwoJfSBlbHNlIHsKCQlmb3IgKGkgPSA5OyBpID4gMDsgaS0tKSB7CgkJ
CWlmICh2YWwgPiAoUFdNX0ZSRVFbaV0gKyBQV01fRlJFUVtpIC0gMV0gKyAxKSAvIDIpIHsKCQkJ
CWJyZWFrOwoJCQl9CgkJfQoJfQoKCXJldHVybiAocmVnICYgMHhmMCkgfCBpOwp9CgovKiBQV00g
cmFtcCByYXRlCiAqIFJlZ2lzdGVyIGxheW91dDoKICogICAgcmVnWzBdID0gW09GRjMsICBPRkYy
LCAgT0ZGMSwgIFJFUywgICBSUjEtRSwgUlIxLTIsIFJSMS0xLCBSUjEtMF0KICogICAgcmVnWzFd
ID0gW1JSMi1FLCBSUjItMiwgUlIyLTEsIFJSMi0wLCBSUjMtRSwgUlIzLTIsIFJSMy0xLCBSUjMt
MF0gKi8Kc3RhdGljIGNvbnN0IHU4IFBXTV9SUltdID0gezIwNiwgMTA0LCA2OSwgNDEsIDI2LCAx
OCwgMTAsIDV9OwoKc3RhdGljIGlubGluZSBpbnQgUFdNX1JSX0ZST01fUkVHKGludCByZWcsIGlu
dCBpeCkKewoJaW50IHJyID0gKGl4ID09IDEpID8gcmVnID4+IDQgOiByZWc7CgoJcmV0dXJuIChy
ciAmIDB4MDgpID8gUFdNX1JSW3JyICYgMHgwN10gOiAwOwp9CgpzdGF0aWMgaW50IFBXTV9SUl9U
T19SRUcoaW50IHZhbCwgaW50IGl4LCBpbnQgcmVnKQp7CglpbnQgaTsKCglmb3IgKGkgPSAwOyBp
IDwgNzsgaSsrKSB7CgkJaWYgKHZhbCA+IChQV01fUlJbaV0gKyBQV01fUlJbaSArIDFdICsgMSkg
LyAyKSB7CgkJCWJyZWFrOwoJCX0KCX0KCglyZXR1cm4gKGl4ID09IDEpID8gKHJlZyAmIDB4OGYp
IHwgKGkgPDwgNCkgOiAocmVnICYgMHhmOCkgfCBpOwp9CgovKiBQV00gcmFtcCByYXRlIGVuYWJs
ZSAqLwpzdGF0aWMgaW5saW5lIGludCBQV01fUlJfRU5fRlJPTV9SRUcoaW50IHJlZywgaW50IGl4
KQp7CglyZXR1cm4gUFdNX1JSX0ZST01fUkVHKHJlZywgaXgpID8gMSA6IDA7Cn0KCnN0YXRpYyBp
bmxpbmUgaW50IFBXTV9SUl9FTl9UT19SRUcoaW50IHZhbCwgaW50IGl4LCBpbnQgcmVnKQp7Cglp
bnQgZW4gPSAoaXggPT0gMSkgPyAweDgwIDogMHgwODsKCglyZXR1cm4gdmFsID8gcmVnIHwgZW4g
OiByZWcgJiB+ZW47Cn0KCi8qIFBXTSBtaW4vb2ZmCiAqIFRoZSBQV00gbWluL29mZiBiaXRzIGFy
ZSBwYXJ0IG9mIHRoZSBQTVcgcmFtcCByYXRlIHJlZ2lzdGVyIDAgKHNlZSBhYm92ZSBmb3IKICog
dGhlIHJlZ2lzdGVyIGxheW91dCkuICovCnN0YXRpYyBpbmxpbmUgaW50IFBXTV9PRkZfRlJPTV9S
RUcoaW50IHJlZywgaW50IGl4KQp7CglyZXR1cm4gKHJlZyA+PiAoaXggKyA1KSkgJiAweDAxOwp9
CgpzdGF0aWMgaW5saW5lIGludCBQV01fT0ZGX1RPX1JFRyhpbnQgdmFsLCBpbnQgaXgsIGludCBy
ZWcpCnsKCXJldHVybiAocmVnICYgfigxIDw8IChpeCArIDUpKSkgfCAoKHZhbCAmIDB4MDEpIDw8
IChpeCArIDUpKTsKfQoKLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAqIERldmljZSBJL08gYWNjZXNzCiAqCiAq
IElTQSBhY2Nlc3MgaXMgcGVyZm9ybWVkIHRocm91Z2ggYW4gaW5kZXgvZGF0YSByZWdpc3RlciBw
YWlyIGFuZCBuZWVkcyB0bwogKiBiZSBwcm90ZWN0ZWQgYnkgYSBtdXRleCBkdXJpbmcgcnVudGlt
ZSAobm90IHJlcXVpcmVkIGZvciBpbml0aWFsaXphdGlvbikuCiAqIFdlIHVzZSBkYXRhLT51cGRh
dGVfbG9jayBmb3IgdGhpcyBhbmQgbmVlZCB0byBlbnN1cmUgdGhhdCB3ZSBhY3F1aXJlIGl0CiAq
IGJlZm9yZSBjYWxsaW5nIGRtZTE3MzdfcmVhZCBvciBkbWUxNzM3X3dyaXRlLgogKiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0gKi8KCnN0YXRpYyB1OCBkbWUxNzM3X3JlYWQoc3RydWN0IGkyY19jbGllbnQgKmNsaWVu
dCwgdTggcmVnKQp7CglzMzIgdmFsOwoKCWlmIChjbGllbnQtPmRyaXZlcikgeyAvKiBJMkMgZGV2
aWNlICovCgkJdmFsID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKGNsaWVudCwgcmVnKTsKCgkJ
aWYgKHZhbCA8IDApIHsKCQkJZGV2X3dhcm4oJmNsaWVudC0+ZGV2LCAiUmVhZCBmcm9tIHJlZ2lz
dGVyICIKCQkJCSAiMHglMDJ4IGZhaWxlZCEgUGxlYXNlIHJlcG9ydCB0byB0aGUgZHJpdmVyICIK
CQkJCSAibWFpbnRhaW5lci5cbiIsIHJlZyk7CgkJfQoJfSBlbHNlIHsgLyogSVNBIGRldmljZSAq
LwoJCW91dGIocmVnLCBjbGllbnQtPmFkZHIpOwoJCXZhbCA9IGluYihjbGllbnQtPmFkZHIgKyAx
KTsKCX0KCglyZXR1cm4gdmFsOwp9CgpzdGF0aWMgczMyIGRtZTE3Mzdfd3JpdGUoc3RydWN0IGky
Y19jbGllbnQgKmNsaWVudCwgdTggcmVnLCB1OCB2YWwpCnsKCXMzMiByZXMgPSAwOwoKCWlmIChj
bGllbnQtPmRyaXZlcikgeyAvKiBJMkMgZGV2aWNlICovCgkJcmVzID0gaTJjX3NtYnVzX3dyaXRl
X2J5dGVfZGF0YShjbGllbnQsIHJlZywgdmFsKTsKCgkJaWYgKHJlcyA8IDApIHsKCQkJZGV2X3dh
cm4oJmNsaWVudC0+ZGV2LCAiV3JpdGUgdG8gcmVnaXN0ZXIgIgoJCQkJICIweCUwMnggZmFpbGVk
ISBQbGVhc2UgcmVwb3J0IHRvIHRoZSBkcml2ZXIgIgoJCQkJICJtYWludGFpbmVyLlxuIiwgcmVn
KTsKCQl9Cgl9IGVsc2UgeyAvKiBJU0EgZGV2aWNlICovCgkJb3V0YihyZWcsIGNsaWVudC0+YWRk
cik7CgkJb3V0Yih2YWwsIGNsaWVudC0+YWRkciArIDEpOwoJfQoKCXJldHVybiByZXM7Cn0KCnN0
YXRpYyBzdHJ1Y3QgZG1lMTczN19kYXRhICpkbWUxNzM3X3VwZGF0ZV9kZXZpY2Uoc3RydWN0IGRl
dmljZSAqZGV2KQp7CglzdHJ1Y3QgZG1lMTczN19kYXRhICpkYXRhID0gZGV2X2dldF9kcnZkYXRh
KGRldik7CglzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gJmRhdGEtPmNsaWVudDsKCWludCBp
eDsKCXU4IGxzYls1XTsKCgltdXRleF9sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7CgoJLyogRW5h
YmxlIGEgVmJhdCBtb25pdG9yaW5nIGN5Y2xlIGV2ZXJ5IDEwIG1pbnMgKi8KCWlmICh0aW1lX2Fm
dGVyKGppZmZpZXMsIGRhdGEtPmxhc3RfdmJhdCArIDYwMCAqIEhaKSB8fCAhZGF0YS0+dmFsaWQp
IHsKCQlkbWUxNzM3X3dyaXRlKGNsaWVudCwgRE1FMTczN19SRUdfQ09ORklHLCBkbWUxNzM3X3Jl
YWQoY2xpZW50LAoJCQkJCQlETUUxNzM3X1JFR19DT05GSUcpIHwgMHgxMCk7CgkJZGF0YS0+bGFz
dF92YmF0ID0gamlmZmllczsKCX0KCgkvKiBTYW1wbGUgcmVnaXN0ZXIgY29udGVudHMgZXZlcnkg
MSBzZWMgKi8KCWlmICh0aW1lX2FmdGVyKGppZmZpZXMsIGRhdGEtPmxhc3RfdXBkYXRlICsgSFop
IHx8ICFkYXRhLT52YWxpZCkgewoJCWRhdGEtPnZpZCA9IGRtZTE3MzdfcmVhZChjbGllbnQsIERN
RTE3MzdfUkVHX1ZJRCk7CgkJZGF0YS0+dmlkICY9IChkYXRhLT50eXBlID09IHNjaDUwMjcpID8g
MHgzOCA6IDB4M2Y7CgoJCS8qIEluICh2b2x0YWdlKSByZWdpc3RlcnMgKi8KCQlmb3IgKGl4ID0g
MDsgaXggPCBBUlJBWV9TSVpFKGRhdGEtPmluKTsgaXgrKykgewoJCQkvKiBWb2x0YWdlIGlucHV0
cyBhcmUgc3RvcmVkIGFzIDE2IGJpdCB2YWx1ZXMgZXZlbgoJCQkgKiB0aG91Z2ggdGhleSBoYXZl
IG9ubHkgMTIgYml0cyByZXNvbHV0aW9uLiBUaGlzIGlzCgkJCSAqIHRvIG1ha2UgaXQgY29uc2lz
dGVudCB3aXRoIHRoZSB0ZW1wIGlucHV0cy4gKi8KCQkJZGF0YS0+aW5baXhdID0gZG1lMTczN19y
ZWFkKGNsaWVudCwKCQkJCQlETUUxNzM3X1JFR19JTihpeCkpIDw8IDg7CgkJCWRhdGEtPmluX21p
bltpeF0gPSBkbWUxNzM3X3JlYWQoY2xpZW50LAoJCQkJCURNRTE3MzdfUkVHX0lOX01JTihpeCkp
OwoJCQlkYXRhLT5pbl9tYXhbaXhdID0gZG1lMTczN19yZWFkKGNsaWVudCwKCQkJCQlETUUxNzM3
X1JFR19JTl9NQVgoaXgpKTsKCQl9CgoJCS8qIFRlbXAgcmVnaXN0ZXJzICovCgkJZm9yIChpeCA9
IDA7IGl4IDwgQVJSQVlfU0laRShkYXRhLT50ZW1wKTsgaXgrKykgewoJCQkvKiBUZW1wIGlucHV0
cyBhcmUgc3RvcmVkIGFzIDE2IGJpdCB2YWx1ZXMgZXZlbgoJCQkgKiB0aG91Z2ggdGhleSBoYXZl
IG9ubHkgMTIgYml0cyByZXNvbHV0aW9uLiBUaGlzIGlzCgkJCSAqIHRvIHRha2UgYWR2YW50YWdl
IG9mIGltcGxpY2l0IGNvbnZlcnNpb25zIGJldHdlZW4KCQkJICogcmVnaXN0ZXIgdmFsdWVzICgy
J3MgY29tcGxlbWVudCkgYW5kIHRlbXAgdmFsdWVzCgkJCSAqIChzaWduZWQgZGVjaW1hbCkuICov
CgkJCWRhdGEtPnRlbXBbaXhdID0gZG1lMTczN19yZWFkKGNsaWVudCwKCQkJCQlETUUxNzM3X1JF
R19URU1QKGl4KSkgPDwgODsKCQkJZGF0YS0+dGVtcF9taW5baXhdID0gZG1lMTczN19yZWFkKGNs
aWVudCwKCQkJCQlETUUxNzM3X1JFR19URU1QX01JTihpeCkpOwoJCQlkYXRhLT50ZW1wX21heFtp
eF0gPSBkbWUxNzM3X3JlYWQoY2xpZW50LAoJCQkJCURNRTE3MzdfUkVHX1RFTVBfTUFYKGl4KSk7
CgkJCWlmIChkYXRhLT50eXBlICE9IHNjaDUwMjcpIHsKCQkJCWRhdGEtPnRlbXBfb2Zmc2V0W2l4
XSA9IGRtZTE3MzdfcmVhZChjbGllbnQsCgkJCQkJCURNRTE3MzdfUkVHX1RFTVBfT0ZGU0VUKGl4
KSk7CgkJCX0KCQl9CgoJCS8qIEluIGFuZCB0ZW1wIExTQiByZWdpc3RlcnMKCQkgKiBUaGUgTFNC
cyBhcmUgbGF0Y2hlZCB3aGVuIHRoZSBNU0JzIGFyZSByZWFkLCBzbyB0aGUgb3JkZXIgaW4KCQkg
KiB3aGljaCB0aGUgcmVnaXN0ZXJzIGFyZSByZWFkIChNU0IgZmlyc3QsIHRoZW4gTFNCKSBpcwoJ
CSAqIGltcG9ydGFudCEgKi8KCQlmb3IgKGl4ID0gMDsgaXggPCBBUlJBWV9TSVpFKGxzYik7IGl4
KyspIHsKCQkJbHNiW2l4XSA9IGRtZTE3MzdfcmVhZChjbGllbnQsCgkJCQkJRE1FMTczN19SRUdf
SU5fVEVNUF9MU0IoaXgpKTsKCQl9CgkJZm9yIChpeCA9IDA7IGl4IDwgQVJSQVlfU0laRShkYXRh
LT5pbik7IGl4KyspIHsKCQkJZGF0YS0+aW5baXhdIHw9IChsc2JbRE1FMTczN19SRUdfSU5fTFNC
W2l4XV0gPDwKCQkJCQlETUUxNzM3X1JFR19JTl9MU0JfU0hMW2l4XSkgJiAweGYwOwoJCX0KCQlm
b3IgKGl4ID0gMDsgaXggPCBBUlJBWV9TSVpFKGRhdGEtPnRlbXApOyBpeCsrKSB7CgkJCWRhdGEt
PnRlbXBbaXhdIHw9IChsc2JbRE1FMTczN19SRUdfVEVNUF9MU0JbaXhdXSA8PAoJCQkJCURNRTE3
MzdfUkVHX1RFTVBfTFNCX1NITFtpeF0pICYgMHhmMDsKCQl9CgoJCS8qIEZhbiByZWdpc3RlcnMg
Ki8KCQlmb3IgKGl4ID0gMDsgaXggPCBBUlJBWV9TSVpFKGRhdGEtPmZhbik7IGl4KyspIHsKCQkJ
LyogU2tpcCByZWFkaW5nIHJlZ2lzdGVycyBpZiBvcHRpb25hbCBmYW5zIGFyZSBub3QKCQkJICog
cHJlc2VudCAqLwoJCQlpZiAoIShkYXRhLT5oYXNfZmFuICYgKDEgPDwgaXgpKSkgewoJCQkJY29u
dGludWU7CgkJCX0KCQkJZGF0YS0+ZmFuW2l4XSA9IGRtZTE3MzdfcmVhZChjbGllbnQsCgkJCQkJ
RE1FMTczN19SRUdfRkFOKGl4KSk7CgkJCWRhdGEtPmZhbltpeF0gfD0gZG1lMTczN19yZWFkKGNs
aWVudCwKCQkJCQlETUUxNzM3X1JFR19GQU4oaXgpICsgMSkgPDwgODsKCQkJZGF0YS0+ZmFuX21p
bltpeF0gPSBkbWUxNzM3X3JlYWQoY2xpZW50LAoJCQkJCURNRTE3MzdfUkVHX0ZBTl9NSU4oaXgp
KTsKCQkJZGF0YS0+ZmFuX21pbltpeF0gfD0gZG1lMTczN19yZWFkKGNsaWVudCwKCQkJCQlETUUx
NzM3X1JFR19GQU5fTUlOKGl4KSArIDEpIDw8IDg7CgkJCWRhdGEtPmZhbl9vcHRbaXhdID0gZG1l
MTczN19yZWFkKGNsaWVudCwKCQkJCQlETUUxNzM3X1JFR19GQU5fT1BUKGl4KSk7CgkJCS8qIGZh
bl9tYXggZXhpc3RzIG9ubHkgZm9yIGZhbls1LTZdICovCgkJCWlmIChpeCA+IDMpIHsKCQkJCWRh
dGEtPmZhbl9tYXhbaXggLSA0XSA9IGRtZTE3MzdfcmVhZChjbGllbnQsCgkJCQkJRE1FMTczN19S
RUdfRkFOX01BWChpeCkpOwoJCQl9CgkJfQoKCQkvKiBQV00gcmVnaXN0ZXJzICovCgkJZm9yIChp
eCA9IDA7IGl4IDwgQVJSQVlfU0laRShkYXRhLT5wd20pOyBpeCsrKSB7CgkJCS8qIFNraXAgcmVh
ZGluZyByZWdpc3RlcnMgaWYgb3B0aW9uYWwgUFdNcyBhcmUgbm90CgkJCSAqIHByZXNlbnQgKi8K
CQkJaWYgKCEoZGF0YS0+aGFzX3B3bSAmICgxIDw8IGl4KSkpIHsKCQkJCWNvbnRpbnVlOwoJCQl9
CgkJCWRhdGEtPnB3bVtpeF0gPSBkbWUxNzM3X3JlYWQoY2xpZW50LAoJCQkJCURNRTE3MzdfUkVH
X1BXTShpeCkpOwoJCQlkYXRhLT5wd21fZnJlcVtpeF0gPSBkbWUxNzM3X3JlYWQoY2xpZW50LAoJ
CQkJCURNRTE3MzdfUkVHX1BXTV9GUkVRKGl4KSk7CgkJCS8qIHB3bV9jb25maWcgYW5kIHB3bV9t
aW4gZXhpc3Qgb25seSBmb3IgcHdtWzEtM10gKi8KCQkJaWYgKGl4IDwgMykgewoJCQkJZGF0YS0+
cHdtX2NvbmZpZ1tpeF0gPSBkbWUxNzM3X3JlYWQoY2xpZW50LAoJCQkJCQlETUUxNzM3X1JFR19Q
V01fQ09ORklHKGl4KSk7CgkJCQlkYXRhLT5wd21fbWluW2l4XSA9IGRtZTE3MzdfcmVhZChjbGll
bnQsCgkJCQkJCURNRTE3MzdfUkVHX1BXTV9NSU4oaXgpKTsKCQkJfQoJCX0KCQlmb3IgKGl4ID0g
MDsgaXggPCBBUlJBWV9TSVpFKGRhdGEtPnB3bV9ycik7IGl4KyspIHsKCQkJZGF0YS0+cHdtX3Jy
W2l4XSA9IGRtZTE3MzdfcmVhZChjbGllbnQsCgkJCQkJCURNRTE3MzdfUkVHX1BXTV9SUihpeCkp
OwoJCX0KCgkJLyogVGhlcm1hbCB6b25lIHJlZ2lzdGVycyAqLwoJCWZvciAoaXggPSAwOyBpeCA8
IEFSUkFZX1NJWkUoZGF0YS0+em9uZV9sb3cpOyBpeCsrKSB7CgkJCWRhdGEtPnpvbmVfbG93W2l4
XSA9IGRtZTE3MzdfcmVhZChjbGllbnQsCgkJCQkJRE1FMTczN19SRUdfWk9ORV9MT1coaXgpKTsK
CQkJZGF0YS0+em9uZV9hYnNbaXhdID0gZG1lMTczN19yZWFkKGNsaWVudCwKCQkJCQlETUUxNzM3
X1JFR19aT05FX0FCUyhpeCkpOwoJCX0KCQlmb3IgKGl4ID0gMDsgaXggPCBBUlJBWV9TSVpFKGRh
dGEtPnpvbmVfaHlzdCk7IGl4KyspIHsKCQkJZGF0YS0+em9uZV9oeXN0W2l4XSA9IGRtZTE3Mzdf
cmVhZChjbGllbnQsCgkJCQkJCURNRTE3MzdfUkVHX1pPTkVfSFlTVChpeCkpOwoJCX0KCgkJLyog
QWxhcm0gcmVnaXN0ZXJzICovCgkJZGF0YS0+YWxhcm1zID0gZG1lMTczN19yZWFkKGNsaWVudCwK
CQkJCQkJRE1FMTczN19SRUdfQUxBUk0xKTsKCQkvKiBCaXQgNyB0ZWxscyB1cyBpZiB0aGUgb3Ro
ZXIgYWxhcm0gcmVnaXN0ZXJzIGFyZSBub24temVybyBhbmQKCQkgKiB0aGVyZWZvcmUgYWxzbyBu
ZWVkIHRvIGJlIHJlYWQgKi8KCQlpZiAoZGF0YS0+YWxhcm1zICYgMHg4MCkgewoJCQlkYXRhLT5h
bGFybXMgfD0gZG1lMTczN19yZWFkKGNsaWVudCwKCQkJCQkJRE1FMTczN19SRUdfQUxBUk0yKSA8
PCA4OwoJCQlkYXRhLT5hbGFybXMgfD0gZG1lMTczN19yZWFkKGNsaWVudCwKCQkJCQkJRE1FMTcz
N19SRUdfQUxBUk0zKSA8PCAxNjsKCQl9CgoJCS8qIFRoZSBJU0EgY2hpcHMgcmVxdWlyZSBleHBs
aWNpdCBjbGVhcmluZyBvZiBhbGFybSBiaXRzLgoJCSAqIERvbid0IHdvcnJ5LCBhbiBhbGFybSB3
aWxsIGNvbWUgYmFjayBpZiB0aGUgY29uZGl0aW9uCgkJICogdGhhdCBjYXVzZXMgaXQgc3RpbGwg
ZXhpc3RzICovCgkJaWYgKCFjbGllbnQtPmRyaXZlcikgewoJCQlpZiAoZGF0YS0+YWxhcm1zICYg
MHhmZjAwMDApIHsKCQkJCWRtZTE3Mzdfd3JpdGUoY2xpZW50LCBETUUxNzM3X1JFR19BTEFSTTMs
CgkJCQkJICAgICAgMHhmZik7CgkJCX0KCQkJaWYgKGRhdGEtPmFsYXJtcyAmIDB4ZmYwMCkgewoJ
CQkJZG1lMTczN193cml0ZShjbGllbnQsIERNRTE3MzdfUkVHX0FMQVJNMiwKCQkJCQkgICAgICAw
eGZmKTsKCQkJfQoJCQlpZiAoZGF0YS0+YWxhcm1zICYgMHhmZikgewoJCQkJZG1lMTczN193cml0
ZShjbGllbnQsIERNRTE3MzdfUkVHX0FMQVJNMSwKCQkJCQkgICAgICAweGZmKTsKCQkJfQoJCX0K
CgkJZGF0YS0+bGFzdF91cGRhdGUgPSBqaWZmaWVzOwoJCWRhdGEtPnZhbGlkID0gMTsKCX0KCglt
dXRleF91bmxvY2soJmRhdGEtPnVwZGF0ZV9sb2NrKTsKCglyZXR1cm4gZGF0YTsKfQoKLyogLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCiAqIFZvbHRhZ2Ugc3lzZnMgYXR0cmlidXRlcwogKiBpeCA9IFswLTVdCiAqIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSAqLwoKI2RlZmluZSBTWVNfSU5fSU5QVVQJMAojZGVmaW5lIFNZU19JTl9NSU4J
MQojZGVmaW5lIFNZU19JTl9NQVgJMgojZGVmaW5lIFNZU19JTl9BTEFSTQkzCgpzdGF0aWMgc3Np
emVfdCBzaG93X2luKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUg
KmF0dHIsCgkJICAgICAgIGNoYXIgKmJ1ZikKewoJc3RydWN0IGRtZTE3MzdfZGF0YSAqZGF0YSA9
IGRtZTE3MzdfdXBkYXRlX2RldmljZShkZXYpOwoJc3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0cmli
dXRlXzIKCQkqc2Vuc29yX2F0dHJfMiA9IHRvX3NlbnNvcl9kZXZfYXR0cl8yKGF0dHIpOwoJaW50
IGl4ID0gc2Vuc29yX2F0dHJfMi0+aW5kZXg7CglpbnQgZm4gPSBzZW5zb3JfYXR0cl8yLT5ucjsK
CWludCByZXM7CgoJc3dpdGNoIChmbikgewoJY2FzZSBTWVNfSU5fSU5QVVQ6CgkJcmVzID0gSU5f
RlJPTV9SRUcoZGF0YS0+aW5baXhdLCBpeCwgMTYpOwoJCWJyZWFrOwoJY2FzZSBTWVNfSU5fTUlO
OgoJCXJlcyA9IElOX0ZST01fUkVHKGRhdGEtPmluX21pbltpeF0sIGl4LCA4KTsKCQlicmVhazsK
CWNhc2UgU1lTX0lOX01BWDoKCQlyZXMgPSBJTl9GUk9NX1JFRyhkYXRhLT5pbl9tYXhbaXhdLCBp
eCwgOCk7CgkJYnJlYWs7CgljYXNlIFNZU19JTl9BTEFSTToKCQlyZXMgPSAoZGF0YS0+YWxhcm1z
ID4+IERNRTE3MzdfQklUX0FMQVJNX0lOW2l4XSkgJiAweDAxOwoJCWJyZWFrOwoJZGVmYXVsdDoK
CQlyZXMgPSAwOwoJCWRldl9kYmcoZGV2LCAiVW5rbm93biBmdW5jdGlvbiAlZC5cbiIsIGZuKTsK
CX0KCglyZXR1cm4gc3ByaW50ZihidWYsICIlZFxuIiwgcmVzKTsKfQoKc3RhdGljIHNzaXplX3Qg
c2V0X2luKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIs
CgkJICAgICAgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpCnsKCXN0cnVjdCBkbWUxNzM3
X2RhdGEgKmRhdGEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKCXN0cnVjdCBpMmNfY2xpZW50ICpj
bGllbnQgPSAmZGF0YS0+Y2xpZW50OwoJc3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0cmlidXRlXzIK
CQkqc2Vuc29yX2F0dHJfMiA9IHRvX3NlbnNvcl9kZXZfYXR0cl8yKGF0dHIpOwoJaW50IGl4ID0g
c2Vuc29yX2F0dHJfMi0+aW5kZXg7CglpbnQgZm4gPSBzZW5zb3JfYXR0cl8yLT5ucjsKCWxvbmcg
dmFsID0gc2ltcGxlX3N0cnRvbChidWYsIE5VTEwsIDEwKTsKCgltdXRleF9sb2NrKCZkYXRhLT51
cGRhdGVfbG9jayk7Cglzd2l0Y2ggKGZuKSB7CgljYXNlIFNZU19JTl9NSU46CgkJZGF0YS0+aW5f
bWluW2l4XSA9IElOX1RPX1JFRyh2YWwsIGl4KTsKCQlkbWUxNzM3X3dyaXRlKGNsaWVudCwgRE1F
MTczN19SRUdfSU5fTUlOKGl4KSwKCQkJICAgICAgZGF0YS0+aW5fbWluW2l4XSk7CgkJYnJlYWs7
CgljYXNlIFNZU19JTl9NQVg6CgkJZGF0YS0+aW5fbWF4W2l4XSA9IElOX1RPX1JFRyh2YWwsIGl4
KTsKCQlkbWUxNzM3X3dyaXRlKGNsaWVudCwgRE1FMTczN19SRUdfSU5fTUFYKGl4KSwKCQkJICAg
ICAgZGF0YS0+aW5fbWF4W2l4XSk7CgkJYnJlYWs7CglkZWZhdWx0OgoJCWRldl9kYmcoZGV2LCAi
VW5rbm93biBmdW5jdGlvbiAlZC5cbiIsIGZuKTsKCX0KCW11dGV4X3VubG9jaygmZGF0YS0+dXBk
YXRlX2xvY2spOwoKCXJldHVybiBjb3VudDsKfQoKLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAqIFRlbXBlcmF0
dXJlIHN5c2ZzIGF0dHJpYnV0ZXMKICogaXggPSBbMC0yXQogKiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gKi8KCiNk
ZWZpbmUgU1lTX1RFTVBfSU5QVVQJCQkwCiNkZWZpbmUgU1lTX1RFTVBfTUlOCQkJMQojZGVmaW5l
IFNZU19URU1QX01BWAkJCTIKI2RlZmluZSBTWVNfVEVNUF9PRkZTRVQJCQkzCiNkZWZpbmUgU1lT
X1RFTVBfQUxBUk0JCQk0CiNkZWZpbmUgU1lTX1RFTVBfRkFVTFQJCQk1CgpzdGF0aWMgc3NpemVf
dCBzaG93X3RlbXAoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAq
YXR0ciwKCQkJIGNoYXIgKmJ1ZikKewoJc3RydWN0IGRtZTE3MzdfZGF0YSAqZGF0YSA9IGRtZTE3
MzdfdXBkYXRlX2RldmljZShkZXYpOwoJc3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0cmlidXRlXzIK
CQkqc2Vuc29yX2F0dHJfMiA9IHRvX3NlbnNvcl9kZXZfYXR0cl8yKGF0dHIpOwoJaW50IGl4ID0g
c2Vuc29yX2F0dHJfMi0+aW5kZXg7CglpbnQgZm4gPSBzZW5zb3JfYXR0cl8yLT5ucjsKCWludCBy
ZXM7CgoJc3dpdGNoIChmbikgewoJY2FzZSBTWVNfVEVNUF9JTlBVVDoKCQlyZXMgPSBURU1QX0ZS
T01fUkVHKGRhdGEtPnRlbXBbaXhdLCAxNik7CgkJYnJlYWs7CgljYXNlIFNZU19URU1QX01JTjoK
CQlyZXMgPSBURU1QX0ZST01fUkVHKGRhdGEtPnRlbXBfbWluW2l4XSwgOCk7CgkJYnJlYWs7Cglj
YXNlIFNZU19URU1QX01BWDoKCQlyZXMgPSBURU1QX0ZST01fUkVHKGRhdGEtPnRlbXBfbWF4W2l4
XSwgOCk7CgkJYnJlYWs7CgljYXNlIFNZU19URU1QX09GRlNFVDoKCQlyZXMgPSBURU1QX0ZST01f
UkVHKGRhdGEtPnRlbXBfb2Zmc2V0W2l4XSwgOCk7CgkJYnJlYWs7CgljYXNlIFNZU19URU1QX0FM
QVJNOgoJCXJlcyA9IChkYXRhLT5hbGFybXMgPj4gRE1FMTczN19CSVRfQUxBUk1fVEVNUFtpeF0p
ICYgMHgwMTsKCQlicmVhazsKCWNhc2UgU1lTX1RFTVBfRkFVTFQ6CgkJcmVzID0gKCgodTE2KWRh
dGEtPnRlbXBbaXhdICYgMHhmZjAwKSA9PSAweDgwMDApOwoJCWJyZWFrOwoJZGVmYXVsdDoKCQly
ZXMgPSAwOwoJCWRldl9kYmcoZGV2LCAiVW5rbm93biBmdW5jdGlvbiAlZC5cbiIsIGZuKTsKCX0K
CglyZXR1cm4gc3ByaW50ZihidWYsICIlZFxuIiwgcmVzKTsKfQoKc3RhdGljIHNzaXplX3Qgc2V0
X3RlbXAoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwK
CQkJY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpCnsKCXN0cnVjdCBkbWUxNzM3X2RhdGEg
KmRhdGEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKCXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQg
PSAmZGF0YS0+Y2xpZW50OwoJc3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0cmlidXRlXzIKCQkqc2Vu
c29yX2F0dHJfMiA9IHRvX3NlbnNvcl9kZXZfYXR0cl8yKGF0dHIpOwoJaW50IGl4ID0gc2Vuc29y
X2F0dHJfMi0+aW5kZXg7CglpbnQgZm4gPSBzZW5zb3JfYXR0cl8yLT5ucjsKCWxvbmcgdmFsID0g
c2ltcGxlX3N0cnRvbChidWYsIE5VTEwsIDEwKTsKCgltdXRleF9sb2NrKCZkYXRhLT51cGRhdGVf
bG9jayk7Cglzd2l0Y2ggKGZuKSB7CgljYXNlIFNZU19URU1QX01JTjoKCQlkYXRhLT50ZW1wX21p
bltpeF0gPSBURU1QX1RPX1JFRyh2YWwpOwoJCWRtZTE3Mzdfd3JpdGUoY2xpZW50LCBETUUxNzM3
X1JFR19URU1QX01JTihpeCksCgkJCSAgICAgIGRhdGEtPnRlbXBfbWluW2l4XSk7CgkJYnJlYWs7
CgljYXNlIFNZU19URU1QX01BWDoKCQlkYXRhLT50ZW1wX21heFtpeF0gPSBURU1QX1RPX1JFRyh2
YWwpOwoJCWRtZTE3Mzdfd3JpdGUoY2xpZW50LCBETUUxNzM3X1JFR19URU1QX01BWChpeCksCgkJ
CSAgICAgIGRhdGEtPnRlbXBfbWF4W2l4XSk7CgkJYnJlYWs7CgljYXNlIFNZU19URU1QX09GRlNF
VDoKCQlkYXRhLT50ZW1wX29mZnNldFtpeF0gPSBURU1QX1RPX1JFRyh2YWwpOwoJCWRtZTE3Mzdf
d3JpdGUoY2xpZW50LCBETUUxNzM3X1JFR19URU1QX09GRlNFVChpeCksCgkJCSAgICAgIGRhdGEt
PnRlbXBfb2Zmc2V0W2l4XSk7CgkJYnJlYWs7CglkZWZhdWx0OgoJCWRldl9kYmcoZGV2LCAiVW5r
bm93biBmdW5jdGlvbiAlZC5cbiIsIGZuKTsKCX0KCW11dGV4X3VubG9jaygmZGF0YS0+dXBkYXRl
X2xvY2spOwoKCXJldHVybiBjb3VudDsKfQoKLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAqIFpvbmUgc3lzZnMg
YXR0cmlidXRlcwogKiBpeCA9IFswLTJdCiAqIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAqLwoKI2RlZmluZSBTWVNf
Wk9ORV9BVVRPX0NIQU5ORUxTX1RFTVAJMAojZGVmaW5lIFNZU19aT05FX0FVVE9fUE9JTlQxX1RF
TVBfSFlTVAkxCiNkZWZpbmUgU1lTX1pPTkVfQVVUT19QT0lOVDFfVEVNUAkyCiNkZWZpbmUgU1lT
X1pPTkVfQVVUT19QT0lOVDJfVEVNUAkzCiNkZWZpbmUgU1lTX1pPTkVfQVVUT19QT0lOVDNfVEVN
UAk0CgpzdGF0aWMgc3NpemVfdCBzaG93X3pvbmUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qg
ZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKCQkJIGNoYXIgKmJ1ZikKewoJc3RydWN0IGRtZTE3Mzdf
ZGF0YSAqZGF0YSA9IGRtZTE3MzdfdXBkYXRlX2RldmljZShkZXYpOwoJc3RydWN0IHNlbnNvcl9k
ZXZpY2VfYXR0cmlidXRlXzIKCQkqc2Vuc29yX2F0dHJfMiA9IHRvX3NlbnNvcl9kZXZfYXR0cl8y
KGF0dHIpOwoJaW50IGl4ID0gc2Vuc29yX2F0dHJfMi0+aW5kZXg7CglpbnQgZm4gPSBzZW5zb3Jf
YXR0cl8yLT5ucjsKCWludCByZXM7CgoJc3dpdGNoIChmbikgewoJY2FzZSBTWVNfWk9ORV9BVVRP
X0NIQU5ORUxTX1RFTVA6CgkJLyogY2hlY2sgY29uZmlnMiBmb3Igbm9uLXN0YW5kYXJkIHRlbXAt
dG8tem9uZSBtYXBwaW5nICovCgkJaWYgKChpeCA9PSAxKSAmJiAoZGF0YS0+Y29uZmlnMiAmIDB4
MDIpKSB7CgkJCXJlcyA9IDQ7CgkJfSBlbHNlIHsKCQkJcmVzID0gMSA8PCBpeDsKCQl9CgkJYnJl
YWs7CgljYXNlIFNZU19aT05FX0FVVE9fUE9JTlQxX1RFTVBfSFlTVDoKCQlyZXMgPSBURU1QX0ZS
T01fUkVHKGRhdGEtPnpvbmVfbG93W2l4XSwgOCkgLQoJCSAgICAgIFRFTVBfSFlTVF9GUk9NX1JF
RyhkYXRhLT56b25lX2h5c3RbaXggPT0gMl0sIGl4KTsKCQlicmVhazsKCWNhc2UgU1lTX1pPTkVf
QVVUT19QT0lOVDFfVEVNUDoKCQlyZXMgPSBURU1QX0ZST01fUkVHKGRhdGEtPnpvbmVfbG93W2l4
XSwgOCk7CgkJYnJlYWs7CgljYXNlIFNZU19aT05FX0FVVE9fUE9JTlQyX1RFTVA6CgkJLyogcHdt
X2ZyZXEgaG9sZHMgdGhlIHRlbXAgcmFuZ2UgYml0cyBpbiB0aGUgdXBwZXIgbmliYmxlICovCgkJ
cmVzID0gVEVNUF9GUk9NX1JFRyhkYXRhLT56b25lX2xvd1tpeF0sIDgpICsKCQkgICAgICBURU1Q
X1JBTkdFX0ZST01fUkVHKGRhdGEtPnB3bV9mcmVxW2l4XSk7CgkJYnJlYWs7CgljYXNlIFNZU19a
T05FX0FVVE9fUE9JTlQzX1RFTVA6CgkJcmVzID0gVEVNUF9GUk9NX1JFRyhkYXRhLT56b25lX2Fi
c1tpeF0sIDgpOwoJCWJyZWFrOwoJZGVmYXVsdDoKCQlyZXMgPSAwOwoJCWRldl9kYmcoZGV2LCAi
VW5rbm93biBmdW5jdGlvbiAlZC5cbiIsIGZuKTsKCX0KCglyZXR1cm4gc3ByaW50ZihidWYsICIl
ZFxuIiwgcmVzKTsKfQoKc3RhdGljIHNzaXplX3Qgc2V0X3pvbmUoc3RydWN0IGRldmljZSAqZGV2
LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKCQkJY29uc3QgY2hhciAqYnVmLCBzaXpl
X3QgY291bnQpCnsKCXN0cnVjdCBkbWUxNzM3X2RhdGEgKmRhdGEgPSBkZXZfZ2V0X2RydmRhdGEo
ZGV2KTsKCXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQgPSAmZGF0YS0+Y2xpZW50OwoJc3RydWN0
IHNlbnNvcl9kZXZpY2VfYXR0cmlidXRlXzIKCQkqc2Vuc29yX2F0dHJfMiA9IHRvX3NlbnNvcl9k
ZXZfYXR0cl8yKGF0dHIpOwoJaW50IGl4ID0gc2Vuc29yX2F0dHJfMi0+aW5kZXg7CglpbnQgZm4g
PSBzZW5zb3JfYXR0cl8yLT5ucjsKCWxvbmcgdmFsID0gc2ltcGxlX3N0cnRvbChidWYsIE5VTEws
IDEwKTsKCgltdXRleF9sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7Cglzd2l0Y2ggKGZuKSB7Cglj
YXNlIFNZU19aT05FX0FVVE9fUE9JTlQxX1RFTVBfSFlTVDoKCQkvKiBSZWZyZXNoIHRoZSBjYWNo
ZSAqLwoJCWRhdGEtPnpvbmVfbG93W2l4XSA9IGRtZTE3MzdfcmVhZChjbGllbnQsCgkJCQkJCSAg
RE1FMTczN19SRUdfWk9ORV9MT1coaXgpKTsKCQkvKiBNb2RpZnkgdGhlIHRlbXAgaHlzdCB2YWx1
ZSAqLwoJCWRhdGEtPnpvbmVfaHlzdFtpeCA9PSAyXSA9IFRFTVBfSFlTVF9UT19SRUcoCgkJCQkJ
VEVNUF9GUk9NX1JFRyhkYXRhLT56b25lX2xvd1tpeF0sIDgpIC0KCQkJCQl2YWwsIGl4LCBkbWUx
NzM3X3JlYWQoY2xpZW50LAoJCQkJCURNRTE3MzdfUkVHX1pPTkVfSFlTVChpeCA9PSAyKSkpOwoJ
CWRtZTE3Mzdfd3JpdGUoY2xpZW50LCBETUUxNzM3X1JFR19aT05FX0hZU1QoaXggPT0gMiksCgkJ
CSAgICAgIGRhdGEtPnpvbmVfaHlzdFtpeCA9PSAyXSk7CgkJYnJlYWs7CgljYXNlIFNZU19aT05F
X0FVVE9fUE9JTlQxX1RFTVA6CgkJZGF0YS0+em9uZV9sb3dbaXhdID0gVEVNUF9UT19SRUcodmFs
KTsKCQlkbWUxNzM3X3dyaXRlKGNsaWVudCwgRE1FMTczN19SRUdfWk9ORV9MT1coaXgpLAoJCQkg
ICAgICBkYXRhLT56b25lX2xvd1tpeF0pOwoJCWJyZWFrOwoJY2FzZSBTWVNfWk9ORV9BVVRPX1BP
SU5UMl9URU1QOgoJCS8qIFJlZnJlc2ggdGhlIGNhY2hlICovCgkJZGF0YS0+em9uZV9sb3dbaXhd
ID0gZG1lMTczN19yZWFkKGNsaWVudCwKCQkJCQkJICBETUUxNzM3X1JFR19aT05FX0xPVyhpeCkp
OwoJCS8qIE1vZGlmeSB0aGUgdGVtcCByYW5nZSB2YWx1ZSAod2hpY2ggaXMgc3RvcmVkIGluIHRo
ZSB1cHBlcgoJCSAqIG5pYmJsZSBvZiB0aGUgcHdtX2ZyZXEgcmVnaXN0ZXIpICovCgkJZGF0YS0+
cHdtX2ZyZXFbaXhdID0gVEVNUF9SQU5HRV9UT19SRUcodmFsIC0KCQkJCQlURU1QX0ZST01fUkVH
KGRhdGEtPnpvbmVfbG93W2l4XSwgOCksCgkJCQkJZG1lMTczN19yZWFkKGNsaWVudCwKCQkJCQlE
TUUxNzM3X1JFR19QV01fRlJFUShpeCkpKTsKCQlkbWUxNzM3X3dyaXRlKGNsaWVudCwgRE1FMTcz
N19SRUdfUFdNX0ZSRVEoaXgpLAoJCQkgICAgICBkYXRhLT5wd21fZnJlcVtpeF0pOwoJCWJyZWFr
OwoJY2FzZSBTWVNfWk9ORV9BVVRPX1BPSU5UM19URU1QOgoJCWRhdGEtPnpvbmVfYWJzW2l4XSA9
IFRFTVBfVE9fUkVHKHZhbCk7CgkJZG1lMTczN193cml0ZShjbGllbnQsIERNRTE3MzdfUkVHX1pP
TkVfQUJTKGl4KSwKCQkJICAgICAgZGF0YS0+em9uZV9hYnNbaXhdKTsKCQlicmVhazsKCWRlZmF1
bHQ6CgkJZGV2X2RiZyhkZXYsICJVbmtub3duIGZ1bmN0aW9uICVkLlxuIiwgZm4pOwoJfQoJbXV0
ZXhfdW5sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7CgoJcmV0dXJuIGNvdW50Owp9CgovKiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KICogRmFuIHN5c2ZzIGF0dHJpYnV0ZXMKICogaXggPSBbMC01XQogKiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0gKi8KCiNkZWZpbmUgU1lTX0ZBTl9JTlBVVAkwCiNkZWZpbmUgU1lTX0ZBTl9NSU4JMQoj
ZGVmaW5lIFNZU19GQU5fTUFYCTIKI2RlZmluZSBTWVNfRkFOX0FMQVJNCTMKI2RlZmluZSBTWVNf
RkFOX1RZUEUJNAoKc3RhdGljIHNzaXplX3Qgc2hvd19mYW4oc3RydWN0IGRldmljZSAqZGV2LCBz
dHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKCQkJY2hhciAqYnVmKQp7CglzdHJ1Y3QgZG1l
MTczN19kYXRhICpkYXRhID0gZG1lMTczN191cGRhdGVfZGV2aWNlKGRldik7CglzdHJ1Y3Qgc2Vu
c29yX2RldmljZV9hdHRyaWJ1dGVfMgoJCSpzZW5zb3JfYXR0cl8yID0gdG9fc2Vuc29yX2Rldl9h
dHRyXzIoYXR0cik7CglpbnQgaXggPSBzZW5zb3JfYXR0cl8yLT5pbmRleDsKCWludCBmbiA9IHNl
bnNvcl9hdHRyXzItPm5yOwoJaW50IHJlczsKCglzd2l0Y2ggKGZuKSB7CgljYXNlIFNZU19GQU5f
SU5QVVQ6CgkJcmVzID0gRkFOX0ZST01fUkVHKGRhdGEtPmZhbltpeF0sCgkJCQkgICBpeCA8IDQg
PyAwIDoKCQkJCSAgIEZBTl9UUENfRlJPTV9SRUcoZGF0YS0+ZmFuX29wdFtpeF0pKTsKCQlicmVh
azsKCWNhc2UgU1lTX0ZBTl9NSU46CgkJcmVzID0gRkFOX0ZST01fUkVHKGRhdGEtPmZhbl9taW5b
aXhdLAoJCQkJICAgaXggPCA0ID8gMCA6CgkJCQkgICBGQU5fVFBDX0ZST01fUkVHKGRhdGEtPmZh
bl9vcHRbaXhdKSk7CgkJYnJlYWs7CgljYXNlIFNZU19GQU5fTUFYOgoJCS8qIG9ubHkgdmFsaWQg
Zm9yIGZhbls1LTZdICovCgkJcmVzID0gRkFOX01BWF9GUk9NX1JFRyhkYXRhLT5mYW5fbWF4W2l4
IC0gNF0pOwoJCWJyZWFrOwoJY2FzZSBTWVNfRkFOX0FMQVJNOgoJCXJlcyA9IChkYXRhLT5hbGFy
bXMgPj4gRE1FMTczN19CSVRfQUxBUk1fRkFOW2l4XSkgJiAweDAxOwoJCWJyZWFrOwoJY2FzZSBT
WVNfRkFOX1RZUEU6CgkJLyogb25seSB2YWxpZCBmb3IgZmFuWzEtNF0gKi8KCQlyZXMgPSBGQU5f
VFlQRV9GUk9NX1JFRyhkYXRhLT5mYW5fb3B0W2l4XSk7CgkJYnJlYWs7CglkZWZhdWx0OgoJCXJl
cyA9IDA7CgkJZGV2X2RiZyhkZXYsICJVbmtub3duIGZ1bmN0aW9uICVkLlxuIiwgZm4pOwoJfQoK
CXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVkXG4iLCByZXMpOwp9CgpzdGF0aWMgc3NpemVfdCBzZXRf
ZmFuKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCgkJ
ICAgICAgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQp7CglzdHJ1Y3QgZG1lMTczN19k
YXRhICpkYXRhID0gZGV2X2dldF9kcnZkYXRhKGRldik7CglzdHJ1Y3QgaTJjX2NsaWVudCAqY2xp
ZW50ID0gJmRhdGEtPmNsaWVudDsKCXN0cnVjdCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZV8yCgkJ
KnNlbnNvcl9hdHRyXzIgPSB0b19zZW5zb3JfZGV2X2F0dHJfMihhdHRyKTsKCWludCBpeCA9IHNl
bnNvcl9hdHRyXzItPmluZGV4OwoJaW50IGZuID0gc2Vuc29yX2F0dHJfMi0+bnI7Cglsb25nIHZh
bCA9IHNpbXBsZV9zdHJ0b2woYnVmLCBOVUxMLCAxMCk7CgoJbXV0ZXhfbG9jaygmZGF0YS0+dXBk
YXRlX2xvY2spOwoJc3dpdGNoIChmbikgewoJY2FzZSBTWVNfRkFOX01JTjoKCQlpZiAoaXggPCA0
KSB7CgkJCWRhdGEtPmZhbl9taW5baXhdID0gRkFOX1RPX1JFRyh2YWwsIDApOwoJCX0gZWxzZSB7
CgkJCS8qIFJlZnJlc2ggdGhlIGNhY2hlICovCgkJCWRhdGEtPmZhbl9vcHRbaXhdID0gZG1lMTcz
N19yZWFkKGNsaWVudCwKCQkJCQkJRE1FMTczN19SRUdfRkFOX09QVChpeCkpOwoJCQkvKiBNb2Rp
ZnkgdGhlIGZhbiBtaW4gdmFsdWUgKi8KCQkJZGF0YS0+ZmFuX21pbltpeF0gPSBGQU5fVE9fUkVH
KHZhbCwKCQkJCQlGQU5fVFBDX0ZST01fUkVHKGRhdGEtPmZhbl9vcHRbaXhdKSk7CgkJfQoJCWRt
ZTE3Mzdfd3JpdGUoY2xpZW50LCBETUUxNzM3X1JFR19GQU5fTUlOKGl4KSwKCQkJICAgICAgZGF0
YS0+ZmFuX21pbltpeF0gJiAweGZmKTsKCQlkbWUxNzM3X3dyaXRlKGNsaWVudCwgRE1FMTczN19S
RUdfRkFOX01JTihpeCkgKyAxLAoJCQkgICAgICBkYXRhLT5mYW5fbWluW2l4XSA+PiA4KTsKCQli
cmVhazsKCWNhc2UgU1lTX0ZBTl9NQVg6CgkJLyogT25seSB2YWxpZCBmb3IgZmFuWzUtNl0gKi8K
CQlkYXRhLT5mYW5fbWF4W2l4IC0gNF0gPSBGQU5fTUFYX1RPX1JFRyh2YWwpOwoJCWRtZTE3Mzdf
d3JpdGUoY2xpZW50LCBETUUxNzM3X1JFR19GQU5fTUFYKGl4KSwKCQkJICAgICAgZGF0YS0+ZmFu
X21heFtpeCAtIDRdKTsKCQlicmVhazsKCWNhc2UgU1lTX0ZBTl9UWVBFOgoJCS8qIE9ubHkgdmFs
aWQgZm9yIGZhblsxLTRdICovCgkJaWYgKCEodmFsID09IDEgfHwgdmFsID09IDIgfHwgdmFsID09
IDQpKSB7CgkJCWNvdW50ID0gLUVJTlZBTDsKCQkJZGV2X3dhcm4oZGV2LCAiRmFuIHR5cGUgdmFs
dWUgJWxkIG5vdCAiCgkJCQkgInN1cHBvcnRlZC4gQ2hvb3NlIG9uZSBvZiAxLCAyLCBvciA0Llxu
IiwKCQkJCSB2YWwpOwoJCQlnb3RvIGV4aXQ7CgkJfQoJCWRhdGEtPmZhbl9vcHRbaXhdID0gRkFO
X1RZUEVfVE9fUkVHKHZhbCwgZG1lMTczN19yZWFkKGNsaWVudCwKCQkJCQlETUUxNzM3X1JFR19G
QU5fT1BUKGl4KSkpOwoJCWRtZTE3Mzdfd3JpdGUoY2xpZW50LCBETUUxNzM3X1JFR19GQU5fT1BU
KGl4KSwKCQkJICAgICAgZGF0YS0+ZmFuX29wdFtpeF0pOwoJCWJyZWFrOwoJZGVmYXVsdDoKCQlk
ZXZfZGJnKGRldiwgIlVua25vd24gZnVuY3Rpb24gJWQuXG4iLCBmbik7Cgl9CmV4aXQ6CgltdXRl
eF91bmxvY2soJmRhdGEtPnVwZGF0ZV9sb2NrKTsKCglyZXR1cm4gY291bnQ7Cn0KCi8qIC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQogKiBQV00gc3lzZnMgYXR0cmlidXRlcwogKiBpeCA9IFswLTRdCiAqIC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSAqLwoKI2RlZmluZSBTWVNfUFdNCQkJCTAKI2RlZmluZSBTWVNfUFdNX0ZSRVEJCQkxCiNk
ZWZpbmUgU1lTX1BXTV9FTkFCTEUJCQkyCiNkZWZpbmUgU1lTX1BXTV9SQU1QX1JBVEUJCTMKI2Rl
ZmluZSBTWVNfUFdNX0FVVE9fQ0hBTk5FTFNfWk9ORQk0CiNkZWZpbmUgU1lTX1BXTV9BVVRPX1BX
TV9NSU4JCTUKI2RlZmluZSBTWVNfUFdNX0FVVE9fUE9JTlQxX1BXTQkJNgojZGVmaW5lIFNZU19Q
V01fQVVUT19QT0lOVDJfUFdNCQk3CgpzdGF0aWMgc3NpemVfdCBzaG93X3B3bShzdHJ1Y3QgZGV2
aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLAoJCQljaGFyICpidWYpCnsK
CXN0cnVjdCBkbWUxNzM3X2RhdGEgKmRhdGEgPSBkbWUxNzM3X3VwZGF0ZV9kZXZpY2UoZGV2KTsK
CXN0cnVjdCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZV8yCgkJKnNlbnNvcl9hdHRyXzIgPSB0b19z
ZW5zb3JfZGV2X2F0dHJfMihhdHRyKTsKCWludCBpeCA9IHNlbnNvcl9hdHRyXzItPmluZGV4OwoJ
aW50IGZuID0gc2Vuc29yX2F0dHJfMi0+bnI7CglpbnQgcmVzOwoKCXN3aXRjaCAoZm4pIHsKCWNh
c2UgU1lTX1BXTToKCQlpZiAoUFdNX0VOX0ZST01fUkVHKGRhdGEtPnB3bV9jb25maWdbaXhdKSA9
PSAwKSB7CgkJCXJlcyA9IDI1NTsKCQl9IGVsc2UgewoJCQlyZXMgPSBkYXRhLT5wd21baXhdOwoJ
CX0KCQlicmVhazsKCWNhc2UgU1lTX1BXTV9GUkVROgoJCXJlcyA9IFBXTV9GUkVRX0ZST01fUkVH
KGRhdGEtPnB3bV9mcmVxW2l4XSk7CgkJYnJlYWs7CgljYXNlIFNZU19QV01fRU5BQkxFOgoJCWlm
IChpeCA+IDMpIHsKCQkJcmVzID0gMTsgLyogcHdtWzUtNl0gaGFyZC13aXJlZCB0byBtYW51YWwg
bW9kZSAqLwoJCX0gZWxzZSB7CgkJCXJlcyA9IFBXTV9FTl9GUk9NX1JFRyhkYXRhLT5wd21fY29u
ZmlnW2l4XSk7CgkJfQoJCWJyZWFrOwoJY2FzZSBTWVNfUFdNX1JBTVBfUkFURToKCQkvKiBPbmx5
IHZhbGlkIGZvciBwd21bMS0zXSAqLwoJCXJlcyA9IFBXTV9SUl9GUk9NX1JFRyhkYXRhLT5wd21f
cnJbaXggPiAwXSwgaXgpOwoJCWJyZWFrOwoJY2FzZSBTWVNfUFdNX0FVVE9fQ0hBTk5FTFNfWk9O
RToKCQkvKiBPbmx5IHZhbGlkIGZvciBwd21bMS0zXSAqLwoJCWlmIChQV01fRU5fRlJPTV9SRUco
ZGF0YS0+cHdtX2NvbmZpZ1tpeF0pID09IDIpIHsKCQkJcmVzID0gUFdNX0FDWl9GUk9NX1JFRyhk
YXRhLT5wd21fY29uZmlnW2l4XSk7CgkJfSBlbHNlIHsKCQkJcmVzID0gZGF0YS0+cHdtX2Fjeltp
eF07CgkJfQoJCWJyZWFrOwoJY2FzZSBTWVNfUFdNX0FVVE9fUFdNX01JTjoKCQkvKiBPbmx5IHZh
bGlkIGZvciBwd21bMS0zXSAqLwoJCWlmIChkYXRhLT50eXBlID09IHNjaDUwMjcgfHwKCQkgICAg
UFdNX09GRl9GUk9NX1JFRyhkYXRhLT5wd21fcnJbMF0sIGl4KSkgewoJCQlyZXMgPSBkYXRhLT5w
d21fbWluW2l4XTsKCQl9IGVsc2UgewoJCQlyZXMgPSAwOwoJCX0KCQlicmVhazsKCWNhc2UgU1lT
X1BXTV9BVVRPX1BPSU5UMV9QV006CgkJLyogT25seSB2YWxpZCBmb3IgcHdtWzEtM10gKi8KCQly
ZXMgPSBkYXRhLT5wd21fbWluW2l4XTsKCQlicmVhazsKCWNhc2UgU1lTX1BXTV9BVVRPX1BPSU5U
Ml9QV006CgkJLyogT25seSB2YWxpZCBmb3IgcHdtWzEtM10gKi8KCQlyZXMgPSAyNTU7IC8qIGhh
cmQtd2lyZWQgKi8KCQlicmVhazsKCWRlZmF1bHQ6CgkJcmVzID0gMDsKCQlkZXZfZGJnKGRldiwg
IlVua25vd24gZnVuY3Rpb24gJWQuXG4iLCBmbik7Cgl9CgoJcmV0dXJuIHNwcmludGYoYnVmLCAi
JWRcbiIsIHJlcyk7Cn0KCnN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpkbWUxNzM3X2F0dHJfcHdt
X2NobW9kW107CnN0YXRpYyB2b2lkIGRtZTE3MzdfY2htb2RfZmlsZShzdHJ1Y3QgZGV2aWNlKiwg
c3RydWN0IGF0dHJpYnV0ZSosIG1vZGVfdCk7CgpzdGF0aWMgc3NpemVfdCBzZXRfcHdtKHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCgkJICAgICAgIGNv
bnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQp7CglzdHJ1Y3QgZG1lMTczN19kYXRhICpkYXRh
ID0gZGV2X2dldF9kcnZkYXRhKGRldik7CglzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gJmRh
dGEtPmNsaWVudDsKCXN0cnVjdCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZV8yCgkJKnNlbnNvcl9h
dHRyXzIgPSB0b19zZW5zb3JfZGV2X2F0dHJfMihhdHRyKTsKCWludCBpeCA9IHNlbnNvcl9hdHRy
XzItPmluZGV4OwoJaW50IGZuID0gc2Vuc29yX2F0dHJfMi0+bnI7Cglsb25nIHZhbCA9IHNpbXBs
ZV9zdHJ0b2woYnVmLCBOVUxMLCAxMCk7CgoJbXV0ZXhfbG9jaygmZGF0YS0+dXBkYXRlX2xvY2sp
OwoJc3dpdGNoIChmbikgewoJY2FzZSBTWVNfUFdNOgoJCWRhdGEtPnB3bVtpeF0gPSBTRU5TT1JT
X0xJTUlUKHZhbCwgMCwgMjU1KTsKCQlkbWUxNzM3X3dyaXRlKGNsaWVudCwgRE1FMTczN19SRUdf
UFdNKGl4KSwgZGF0YS0+cHdtW2l4XSk7CgkJYnJlYWs7CgljYXNlIFNZU19QV01fRlJFUToKCQlk
YXRhLT5wd21fZnJlcVtpeF0gPSBQV01fRlJFUV9UT19SRUcodmFsLCBkbWUxNzM3X3JlYWQoY2xp
ZW50LAoJCQkJCQlETUUxNzM3X1JFR19QV01fRlJFUShpeCkpKTsKCQlkbWUxNzM3X3dyaXRlKGNs
aWVudCwgRE1FMTczN19SRUdfUFdNX0ZSRVEoaXgpLAoJCQkgICAgICBkYXRhLT5wd21fZnJlcVtp
eF0pOwoJCWJyZWFrOwoJY2FzZSBTWVNfUFdNX0VOQUJMRToKCQkvKiBPbmx5IHZhbGlkIGZvciBw
d21bMS0zXSAqLwoJCWlmICh2YWwgPCAwIHx8IHZhbCA+IDIpIHsKCQkJY291bnQgPSAtRUlOVkFM
OwoJCQlkZXZfd2FybihkZXYsICJQV00gZW5hYmxlICVsZCBub3QgIgoJCQkJICJzdXBwb3J0ZWQu
IENob29zZSBvbmUgb2YgMCwgMSwgb3IgMi5cbiIsCgkJCQkgdmFsKTsKCQkJZ290byBleGl0OwoJ
CX0KCQkvKiBSZWZyZXNoIHRoZSBjYWNoZSAqLwoJCWRhdGEtPnB3bV9jb25maWdbaXhdID0gZG1l
MTczN19yZWFkKGNsaWVudCwKCQkJCQkJRE1FMTczN19SRUdfUFdNX0NPTkZJRyhpeCkpOwoJCWlm
ICh2YWwgPT0gUFdNX0VOX0ZST01fUkVHKGRhdGEtPnB3bV9jb25maWdbaXhdKSkgewoJCQkvKiBC
YWlsIG91dCBpZiBubyBjaGFuZ2UgKi8KCQkJZ290byBleGl0OwoJCX0KCQkvKiBEbyBzb21lIGhv
dXNla2VlcGluZyBpZiB3ZSBhcmUgY3VycmVudGx5IGluIGF1dG8gbW9kZSAqLwoJCWlmIChQV01f
RU5fRlJPTV9SRUcoZGF0YS0+cHdtX2NvbmZpZ1tpeF0pID09IDIpIHsKCQkJLyogU2F2ZSB0aGUg
Y3VycmVudCB6b25lIGNoYW5uZWwgYXNzaWdubWVudCAqLwoJCQlkYXRhLT5wd21fYWN6W2l4XSA9
IFBXTV9BQ1pfRlJPTV9SRUcoCgkJCQkJCQlkYXRhLT5wd21fY29uZmlnW2l4XSk7CgkJCS8qIFNh
dmUgdGhlIGN1cnJlbnQgcmFtcCByYXRlIHN0YXRlIGFuZCBkaXNhYmxlIGl0ICovCgkJCWRhdGEt
PnB3bV9ycltpeCA+IDBdID0gZG1lMTczN19yZWFkKGNsaWVudCwKCQkJCQkJRE1FMTczN19SRUdf
UFdNX1JSKGl4ID4gMCkpOwoJCQlkYXRhLT5wd21fcnJfZW4gJj0gfigxIDw8IGl4KTsKCQkJaWYg
KFBXTV9SUl9FTl9GUk9NX1JFRyhkYXRhLT5wd21fcnJbaXggPiAwXSwgaXgpKSB7CgkJCQlkYXRh
LT5wd21fcnJfZW4gfD0gKDEgPDwgaXgpOwoJCQkJZGF0YS0+cHdtX3JyW2l4ID4gMF0gPSBQV01f
UlJfRU5fVE9fUkVHKDAsIGl4LAoJCQkJCQkJZGF0YS0+cHdtX3JyW2l4ID4gMF0pOwoJCQkJZG1l
MTczN193cml0ZShjbGllbnQsCgkJCQkJICAgICAgRE1FMTczN19SRUdfUFdNX1JSKGl4ID4gMCks
CgkJCQkJICAgICAgZGF0YS0+cHdtX3JyW2l4ID4gMF0pOwoJCQl9CgkJfQoJCS8qIFNldCB0aGUg
bmV3IFBXTSBtb2RlICovCgkJc3dpdGNoICh2YWwpIHsKCQljYXNlIDA6CgkJCS8qIENoYW5nZSBw
ZXJtaXNzaW9ucyBvZiBwd21baXhdIHRvIHJlYWQtb25seSAqLwoJCQlkbWUxNzM3X2NobW9kX2Zp
bGUoZGV2LCBkbWUxNzM3X2F0dHJfcHdtX2NobW9kW2l4XSwKCQkJCQkgICBTX0lSVUdPKTsKCQkJ
LyogVHVybiBmYW4gZnVsbHkgb24gKi8KCQkJZGF0YS0+cHdtX2NvbmZpZ1tpeF0gPSBQV01fRU5f
VE9fUkVHKDAsCgkJCQkJCQlkYXRhLT5wd21fY29uZmlnW2l4XSk7CgkJCWRtZTE3Mzdfd3JpdGUo
Y2xpZW50LCBETUUxNzM3X1JFR19QV01fQ09ORklHKGl4KSwKCQkJCSAgICAgIGRhdGEtPnB3bV9j
b25maWdbaXhdKTsKCQkJYnJlYWs7CgkJY2FzZSAxOgoJCQkvKiBUdXJuIG9uIG1hbnVhbCBtb2Rl
ICovCgkJCWRhdGEtPnB3bV9jb25maWdbaXhdID0gUFdNX0VOX1RPX1JFRygxLAoJCQkJCQkJZGF0
YS0+cHdtX2NvbmZpZ1tpeF0pOwoJCQlkbWUxNzM3X3dyaXRlKGNsaWVudCwgRE1FMTczN19SRUdf
UFdNX0NPTkZJRyhpeCksCgkJCQkgICAgICBkYXRhLT5wd21fY29uZmlnW2l4XSk7CgkJCS8qIENo
YW5nZSBwZXJtaXNzaW9ucyBvZiBwd21baXhdIHRvIHJlYWQtd3JpdGVhYmxlICovCgkJCWRtZTE3
MzdfY2htb2RfZmlsZShkZXYsIGRtZTE3MzdfYXR0cl9wd21fY2htb2RbaXhdLAoJCQkJCSAgIFNf
SVJVR08gfCBTX0lXVVNSKTsKCQkJYnJlYWs7CgkJY2FzZSAyOgoJCQkvKiBDaGFuZ2UgcGVybWlz
c2lvbnMgb2YgcHdtW2l4XSB0byByZWFkLW9ubHkgKi8KCQkJZG1lMTczN19jaG1vZF9maWxlKGRl
diwgZG1lMTczN19hdHRyX3B3bV9jaG1vZFtpeF0sCgkJCQkJICAgU19JUlVHTyk7CgkJCS8qIFR1
cm4gb24gYXV0byBtb2RlIHVzaW5nIHRoZSBzYXZlZCB6b25lIGNoYW5uZWwKCQkJICogYXNzaWdu
bWVudCAqLwoJCQlkYXRhLT5wd21fY29uZmlnW2l4XSA9IFBXTV9BQ1pfVE9fUkVHKAoJCQkJCQkJ
ZGF0YS0+cHdtX2FjeltpeF0sCgkJCQkJCQlkYXRhLT5wd21fY29uZmlnW2l4XSk7CgkJCWRtZTE3
Mzdfd3JpdGUoY2xpZW50LCBETUUxNzM3X1JFR19QV01fQ09ORklHKGl4KSwKCQkJCSAgICAgIGRh
dGEtPnB3bV9jb25maWdbaXhdKTsKCQkJLyogRW5hYmxlIFBXTSByYW1wIHJhdGUgaWYgcHJldmlv
dXNseSBlbmFibGVkICovCgkJCWlmIChkYXRhLT5wd21fcnJfZW4gJiAoMSA8PCBpeCkpIHsKCQkJ
CWRhdGEtPnB3bV9ycltpeCA+IDBdID0gUFdNX1JSX0VOX1RPX1JFRygxLCBpeCwKCQkJCQkJZG1l
MTczN19yZWFkKGNsaWVudCwKCQkJCQkJRE1FMTczN19SRUdfUFdNX1JSKGl4ID4gMCkpKTsKCQkJ
CWRtZTE3Mzdfd3JpdGUoY2xpZW50LAoJCQkJCSAgICAgIERNRTE3MzdfUkVHX1BXTV9SUihpeCA+
IDApLAoJCQkJCSAgICAgIGRhdGEtPnB3bV9ycltpeCA+IDBdKTsKCQkJfQoJCQlicmVhazsKCQl9
CgkJYnJlYWs7CgljYXNlIFNZU19QV01fUkFNUF9SQVRFOgoJCS8qIE9ubHkgdmFsaWQgZm9yIHB3
bVsxLTNdICovCgkJLyogUmVmcmVzaCB0aGUgY2FjaGUgKi8KCQlkYXRhLT5wd21fY29uZmlnW2l4
XSA9IGRtZTE3MzdfcmVhZChjbGllbnQsCgkJCQkJCURNRTE3MzdfUkVHX1BXTV9DT05GSUcoaXgp
KTsKCQlkYXRhLT5wd21fcnJbaXggPiAwXSA9IGRtZTE3MzdfcmVhZChjbGllbnQsCgkJCQkJCURN
RTE3MzdfUkVHX1BXTV9SUihpeCA+IDApKTsKCQkvKiBTZXQgdGhlIHJhbXAgcmF0ZSB2YWx1ZSAq
LwoJCWlmICh2YWwgPiAwKSB7CgkJCWRhdGEtPnB3bV9ycltpeCA+IDBdID0gUFdNX1JSX1RPX1JF
Ryh2YWwsIGl4LAoJCQkJCQkJZGF0YS0+cHdtX3JyW2l4ID4gMF0pOwoJCX0KCQkvKiBFbmFibGUv
ZGlzYWJsZSB0aGUgZmVhdHVyZSBvbmx5IGlmIHRoZSBhc3NvY2lhdGVkIFBXTQoJCSAqIG91dHB1
dCBpcyBpbiBhdXRvbWF0aWMgbW9kZS4gKi8KCQlpZiAoUFdNX0VOX0ZST01fUkVHKGRhdGEtPnB3
bV9jb25maWdbaXhdKSA9PSAyKSB7CgkJCWRhdGEtPnB3bV9ycltpeCA+IDBdID0gUFdNX1JSX0VO
X1RPX1JFRyh2YWwgPiAwLCBpeCwKCQkJCQkJCWRhdGEtPnB3bV9ycltpeCA+IDBdKTsKCQl9CgkJ
ZG1lMTczN193cml0ZShjbGllbnQsIERNRTE3MzdfUkVHX1BXTV9SUihpeCA+IDApLAoJCQkgICAg
ICBkYXRhLT5wd21fcnJbaXggPiAwXSk7CgkJYnJlYWs7CgljYXNlIFNZU19QV01fQVVUT19DSEFO
TkVMU19aT05FOgoJCS8qIE9ubHkgdmFsaWQgZm9yIHB3bVsxLTNdICovCgkJaWYgKCEodmFsID09
IDEgfHwgdmFsID09IDIgfHwgdmFsID09IDQgfHwKCQkgICAgICB2YWwgPT0gNiB8fCB2YWwgPT0g
NykpIHsKCQkJY291bnQgPSAtRUlOVkFMOwoJCQlkZXZfd2FybihkZXYsICJQV00gYXV0byBjaGFu
bmVscyB6b25lICVsZCAiCgkJCQkgIm5vdCBzdXBwb3J0ZWQuIENob29zZSBvbmUgb2YgMSwgMiwg
NCwgNiwgIgoJCQkJICJvciA3LlxuIiwgdmFsKTsKCQkJZ290byBleGl0OwoJCX0KCQkvKiBSZWZy
ZXNoIHRoZSBjYWNoZSAqLwoJCWRhdGEtPnB3bV9jb25maWdbaXhdID0gZG1lMTczN19yZWFkKGNs
aWVudCwKCQkJCQkJRE1FMTczN19SRUdfUFdNX0NPTkZJRyhpeCkpOwoJCWlmIChQV01fRU5fRlJP
TV9SRUcoZGF0YS0+cHdtX2NvbmZpZ1tpeF0pID09IDIpIHsKCQkJLyogUFdNIGlzIGFscmVhZHkg
aW4gYXV0byBtb2RlIHNvIHVwZGF0ZSB0aGUgdGVtcAoJCQkgKiBjaGFubmVsIGFzc2lnbm1lbnQg
Ki8KCQkJZGF0YS0+cHdtX2NvbmZpZ1tpeF0gPSBQV01fQUNaX1RPX1JFRyh2YWwsCgkJCQkJCWRh
dGEtPnB3bV9jb25maWdbaXhdKTsKCQkJZG1lMTczN193cml0ZShjbGllbnQsIERNRTE3MzdfUkVH
X1BXTV9DT05GSUcoaXgpLAoJCQkJICAgICAgZGF0YS0+cHdtX2NvbmZpZ1tpeF0pOwoJCX0gZWxz
ZSB7CgkJCS8qIFBXTSBpcyBub3QgaW4gYXV0byBtb2RlIHNvIHdlIHNhdmUgdGhlIHRlbXAKCQkJ
ICogY2hhbm5lbCBhc3NpZ25tZW50IGZvciBsYXRlciB1c2UgKi8KCQkJZGF0YS0+cHdtX2Fjeltp
eF0gPSB2YWw7CgkJfQoJCWJyZWFrOwoJY2FzZSBTWVNfUFdNX0FVVE9fUFdNX01JTjoKCQkvKiBP
bmx5IHZhbGlkIGZvciBwd21bMS0zXSAqLwoJCS8qIFJlZnJlc2ggdGhlIGNhY2hlICovCgkJZGF0
YS0+cHdtX21pbltpeF0gPSBkbWUxNzM3X3JlYWQoY2xpZW50LAoJCQkJCQlETUUxNzM3X1JFR19Q
V01fTUlOKGl4KSk7CgkJLyogVGhlcmUgYXJlIG9ubHkgMiB2YWx1ZXMgc3VwcG9ydGVkIGZvciB0
aGUgYXV0b19wd21fbWluCgkJICogdmFsdWU6IDAgb3IgYXV0b19wb2ludDFfcHdtLiBTbyBpZiB0
aGUgdGVtcGVyYXR1cmUgZHJvcHMKCQkgKiBiZWxvdyB0aGUgYXV0b19wb2ludDFfdGVtcF9oeXN0
IHZhbHVlLCB0aGUgZmFuIGVpdGhlciB0dXJucwoJCSAqIG9mZiBvciBydW5zIGF0IGF1dG9fcG9p
bnQxX3B3bSBkdXR5LWN5Y2xlLiAqLwoJCWlmICh2YWwgPiAoKGRhdGEtPnB3bV9taW5baXhdICsg
MSkgLyAyKSkgewoJCQlkYXRhLT5wd21fcnJbMF0gPSBQV01fT0ZGX1RPX1JFRygxLCBpeCwKCQkJ
CQkJZG1lMTczN19yZWFkKGNsaWVudCwKCQkJCQkJRE1FMTczN19SRUdfUFdNX1JSKDApKSk7CgkJ
fSBlbHNlIHsKCQkJZGF0YS0+cHdtX3JyWzBdID0gUFdNX09GRl9UT19SRUcoMCwgaXgsCgkJCQkJ
CWRtZTE3MzdfcmVhZChjbGllbnQsCgkJCQkJCURNRTE3MzdfUkVHX1BXTV9SUigwKSkpOwoJCX0K
CQlkbWUxNzM3X3dyaXRlKGNsaWVudCwgRE1FMTczN19SRUdfUFdNX1JSKDApLAoJCQkgICAgICBk
YXRhLT5wd21fcnJbMF0pOwoJCWJyZWFrOwoJY2FzZSBTWVNfUFdNX0FVVE9fUE9JTlQxX1BXTToK
CQkvKiBPbmx5IHZhbGlkIGZvciBwd21bMS0zXSAqLwoJCWRhdGEtPnB3bV9taW5baXhdID0gU0VO
U09SU19MSU1JVCh2YWwsIDAsIDI1NSk7CgkJZG1lMTczN193cml0ZShjbGllbnQsIERNRTE3Mzdf
UkVHX1BXTV9NSU4oaXgpLAoJCQkgICAgICBkYXRhLT5wd21fbWluW2l4XSk7CgkJYnJlYWs7Cglk
ZWZhdWx0OgoJCWRldl9kYmcoZGV2LCAiVW5rbm93biBmdW5jdGlvbiAlZC5cbiIsIGZuKTsKCX0K
ZXhpdDoKCW11dGV4X3VubG9jaygmZGF0YS0+dXBkYXRlX2xvY2spOwoKCXJldHVybiBjb3VudDsK
fQoKLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCiAqIE1pc2NlbGxhbmVvdXMgc3lzZnMgYXR0cmlidXRlcwogKiAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0gKi8KCnN0YXRpYyBzc2l6ZV90IHNob3dfdnJtKHN0cnVjdCBkZXZpY2UgKmRl
diwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCgkJCWNoYXIgKmJ1ZikKewoJc3RydWN0
IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2kyY19jbGllbnQoZGV2KTsKCXN0cnVjdCBkbWUxNzM3
X2RhdGEgKmRhdGEgPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsKCglyZXR1cm4gc3ByaW50
ZihidWYsICIlZFxuIiwgZGF0YS0+dnJtKTsKfQoKc3RhdGljIHNzaXplX3Qgc2V0X3ZybShzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLAoJCSAgICAgICBj
b25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkKewoJc3RydWN0IGRtZTE3MzdfZGF0YSAqZGF0
YSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOwoJbG9uZyB2YWwgPSBzaW1wbGVfc3RydG9sKGJ1Ziwg
TlVMTCwgMTApOwoKCWRhdGEtPnZybSA9IHZhbDsKCXJldHVybiBjb3VudDsKfQoKc3RhdGljIHNz
aXplX3Qgc2hvd192aWQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0
ZSAqYXR0ciwKCQkJY2hhciAqYnVmKQp7CglzdHJ1Y3QgZG1lMTczN19kYXRhICpkYXRhID0gZG1l
MTczN191cGRhdGVfZGV2aWNlKGRldik7CgoJcmV0dXJuIHNwcmludGYoYnVmLCAiJWRcbiIsIHZp
ZF9mcm9tX3JlZyhkYXRhLT52aWQsIGRhdGEtPnZybSkpOwp9CgpzdGF0aWMgc3NpemVfdCBzaG93
X25hbWUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwK
CQkJIGNoYXIgKmJ1ZikKewoJc3RydWN0IGRtZTE3MzdfZGF0YSAqZGF0YSA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOwoKCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVzXG4iLCBkYXRhLT5jbGllbnQubmFt
ZSk7Cn0KCi8qIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogKiBTeXNmcyBkZXZpY2UgYXR0cmlidXRlIGRlZmluZXMg
YW5kIHN0cnVjdHMKICogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICovCgovKiBWb2x0YWdlcyAwLTYgKi8KCiNkZWZp
bmUgU0VOU09SX0RFVklDRV9BVFRSX0lOKGl4KSBcCnN0YXRpYyBTRU5TT1JfREVWSUNFX0FUVFJf
MihpbiMjaXgjI19pbnB1dCwgU19JUlVHTywgXAoJc2hvd19pbiwgTlVMTCwgU1lTX0lOX0lOUFVU
LCBpeCk7IFwKc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8yKGluIyNpeCMjX21pbiwgU19JUlVH
TyB8IFNfSVdVU1IsIFwKCXNob3dfaW4sIHNldF9pbiwgU1lTX0lOX01JTiwgaXgpOyBcCnN0YXRp
YyBTRU5TT1JfREVWSUNFX0FUVFJfMihpbiMjaXgjI19tYXgsIFNfSVJVR08gfCBTX0lXVVNSLCBc
CglzaG93X2luLCBzZXRfaW4sIFNZU19JTl9NQVgsIGl4KTsgXApzdGF0aWMgU0VOU09SX0RFVklD
RV9BVFRSXzIoaW4jI2l4IyNfYWxhcm0sIFNfSVJVR08sIFwKCXNob3dfaW4sIE5VTEwsIFNZU19J
Tl9BTEFSTSwgaXgpCgpTRU5TT1JfREVWSUNFX0FUVFJfSU4oMCk7ClNFTlNPUl9ERVZJQ0VfQVRU
Ul9JTigxKTsKU0VOU09SX0RFVklDRV9BVFRSX0lOKDIpOwpTRU5TT1JfREVWSUNFX0FUVFJfSU4o
Myk7ClNFTlNPUl9ERVZJQ0VfQVRUUl9JTig0KTsKU0VOU09SX0RFVklDRV9BVFRSX0lOKDUpOwpT
RU5TT1JfREVWSUNFX0FUVFJfSU4oNik7CgovKiBUZW1wZXJhdHVyZXMgMS0zICovCgojZGVmaW5l
IFNFTlNPUl9ERVZJQ0VfQVRUUl9URU1QKGl4KSBcCnN0YXRpYyBTRU5TT1JfREVWSUNFX0FUVFJf
Mih0ZW1wIyNpeCMjX2lucHV0LCBTX0lSVUdPLCBcCglzaG93X3RlbXAsIE5VTEwsIFNZU19URU1Q
X0lOUFVULCBpeC0xKTsgXApzdGF0aWMgU0VOU09SX0RFVklDRV9BVFRSXzIodGVtcCMjaXgjI19t
aW4sIFNfSVJVR08gfCBTX0lXVVNSLCBcCglzaG93X3RlbXAsIHNldF90ZW1wLCBTWVNfVEVNUF9N
SU4sIGl4LTEpOyBcCnN0YXRpYyBTRU5TT1JfREVWSUNFX0FUVFJfMih0ZW1wIyNpeCMjX21heCwg
U19JUlVHTyB8IFNfSVdVU1IsIFwKCXNob3dfdGVtcCwgc2V0X3RlbXAsIFNZU19URU1QX01BWCwg
aXgtMSk7IFwKc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8yKHRlbXAjI2l4IyNfb2Zmc2V0LCBT
X0lSVUdPLCBcCglzaG93X3RlbXAsIHNldF90ZW1wLCBTWVNfVEVNUF9PRkZTRVQsIGl4LTEpOyBc
CnN0YXRpYyBTRU5TT1JfREVWSUNFX0FUVFJfMih0ZW1wIyNpeCMjX2FsYXJtLCBTX0lSVUdPLCBc
CglzaG93X3RlbXAsIE5VTEwsIFNZU19URU1QX0FMQVJNLCBpeC0xKTsgXApzdGF0aWMgU0VOU09S
X0RFVklDRV9BVFRSXzIodGVtcCMjaXgjI19mYXVsdCwgU19JUlVHTywgXAoJc2hvd190ZW1wLCBO
VUxMLCBTWVNfVEVNUF9GQVVMVCwgaXgtMSkKClNFTlNPUl9ERVZJQ0VfQVRUUl9URU1QKDEpOwpT
RU5TT1JfREVWSUNFX0FUVFJfVEVNUCgyKTsKU0VOU09SX0RFVklDRV9BVFRSX1RFTVAoMyk7Cgov
KiBab25lcyAxLTMgKi8KCiNkZWZpbmUgU0VOU09SX0RFVklDRV9BVFRSX1pPTkUoaXgpIFwKc3Rh
dGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8yKHpvbmUjI2l4IyNfYXV0b19jaGFubmVsc190ZW1wLCBT
X0lSVUdPLCBcCglzaG93X3pvbmUsIE5VTEwsIFNZU19aT05FX0FVVE9fQ0hBTk5FTFNfVEVNUCwg
aXgtMSk7IFwKc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8yKHpvbmUjI2l4IyNfYXV0b19wb2lu
dDFfdGVtcF9oeXN0LCBTX0lSVUdPLCBcCglzaG93X3pvbmUsIHNldF96b25lLCBTWVNfWk9ORV9B
VVRPX1BPSU5UMV9URU1QX0hZU1QsIGl4LTEpOyBcCnN0YXRpYyBTRU5TT1JfREVWSUNFX0FUVFJf
Mih6b25lIyNpeCMjX2F1dG9fcG9pbnQxX3RlbXAsIFNfSVJVR08sIFwKCXNob3dfem9uZSwgc2V0
X3pvbmUsIFNZU19aT05FX0FVVE9fUE9JTlQxX1RFTVAsIGl4LTEpOyBcCnN0YXRpYyBTRU5TT1Jf
REVWSUNFX0FUVFJfMih6b25lIyNpeCMjX2F1dG9fcG9pbnQyX3RlbXAsIFNfSVJVR08sIFwKCXNo
b3dfem9uZSwgc2V0X3pvbmUsIFNZU19aT05FX0FVVE9fUE9JTlQyX1RFTVAsIGl4LTEpOyBcCnN0
YXRpYyBTRU5TT1JfREVWSUNFX0FUVFJfMih6b25lIyNpeCMjX2F1dG9fcG9pbnQzX3RlbXAsIFNf
SVJVR08sIFwKCXNob3dfem9uZSwgc2V0X3pvbmUsIFNZU19aT05FX0FVVE9fUE9JTlQzX1RFTVAs
IGl4LTEpCgpTRU5TT1JfREVWSUNFX0FUVFJfWk9ORSgxKTsKU0VOU09SX0RFVklDRV9BVFRSX1pP
TkUoMik7ClNFTlNPUl9ERVZJQ0VfQVRUUl9aT05FKDMpOwoKLyogRmFucyAxLTQgKi8KCiNkZWZp
bmUgU0VOU09SX0RFVklDRV9BVFRSX0ZBTl8xVE80KGl4KSBcCnN0YXRpYyBTRU5TT1JfREVWSUNF
X0FUVFJfMihmYW4jI2l4IyNfaW5wdXQsIFNfSVJVR08sIFwKCXNob3dfZmFuLCBOVUxMLCBTWVNf
RkFOX0lOUFVULCBpeC0xKTsgXApzdGF0aWMgU0VOU09SX0RFVklDRV9BVFRSXzIoZmFuIyNpeCMj
X21pbiwgU19JUlVHTyB8IFNfSVdVU1IsIFwKCXNob3dfZmFuLCBzZXRfZmFuLCBTWVNfRkFOX01J
TiwgaXgtMSk7IFwKc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8yKGZhbiMjaXgjI19hbGFybSwg
U19JUlVHTywgXAoJc2hvd19mYW4sIE5VTEwsIFNZU19GQU5fQUxBUk0sIGl4LTEpOyBcCnN0YXRp
YyBTRU5TT1JfREVWSUNFX0FUVFJfMihmYW4jI2l4IyNfdHlwZSwgU19JUlVHTyB8IFNfSVdVU1Is
IFwKCXNob3dfZmFuLCBzZXRfZmFuLCBTWVNfRkFOX1RZUEUsIGl4LTEpCgpTRU5TT1JfREVWSUNF
X0FUVFJfRkFOXzFUTzQoMSk7ClNFTlNPUl9ERVZJQ0VfQVRUUl9GQU5fMVRPNCgyKTsKU0VOU09S
X0RFVklDRV9BVFRSX0ZBTl8xVE80KDMpOwpTRU5TT1JfREVWSUNFX0FUVFJfRkFOXzFUTzQoNCk7
CgovKiBGYW5zIDUtNiAqLwoKI2RlZmluZSBTRU5TT1JfREVWSUNFX0FUVFJfRkFOXzVUTzYoaXgp
IFwKc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8yKGZhbiMjaXgjI19pbnB1dCwgU19JUlVHTywg
XAoJc2hvd19mYW4sIE5VTEwsIFNZU19GQU5fSU5QVVQsIGl4LTEpOyBcCnN0YXRpYyBTRU5TT1Jf
REVWSUNFX0FUVFJfMihmYW4jI2l4IyNfbWluLCBTX0lSVUdPIHwgU19JV1VTUiwgXAoJc2hvd19m
YW4sIHNldF9mYW4sIFNZU19GQU5fTUlOLCBpeC0xKTsgXApzdGF0aWMgU0VOU09SX0RFVklDRV9B
VFRSXzIoZmFuIyNpeCMjX2FsYXJtLCBTX0lSVUdPLCBcCglzaG93X2ZhbiwgTlVMTCwgU1lTX0ZB
Tl9BTEFSTSwgaXgtMSk7IFwKc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8yKGZhbiMjaXgjI19t
YXgsIFNfSVJVR08gfCBTX0lXVVNSLCBcCglzaG93X2Zhbiwgc2V0X2ZhbiwgU1lTX0ZBTl9NQVgs
IGl4LTEpCgpTRU5TT1JfREVWSUNFX0FUVFJfRkFOXzVUTzYoNSk7ClNFTlNPUl9ERVZJQ0VfQVRU
Ul9GQU5fNVRPNig2KTsKCi8qIFBXTXMgMS0zICovCgojZGVmaW5lIFNFTlNPUl9ERVZJQ0VfQVRU
Ul9QV01fMVRPMyhpeCkgXApzdGF0aWMgU0VOU09SX0RFVklDRV9BVFRSXzIocHdtIyNpeCwgU19J
UlVHTywgXAoJc2hvd19wd20sIHNldF9wd20sIFNZU19QV00sIGl4LTEpOyBcCnN0YXRpYyBTRU5T
T1JfREVWSUNFX0FUVFJfMihwd20jI2l4IyNfZnJlcSwgU19JUlVHTywgXAoJc2hvd19wd20sIHNl
dF9wd20sIFNZU19QV01fRlJFUSwgaXgtMSk7IFwKc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8y
KHB3bSMjaXgjI19lbmFibGUsIFNfSVJVR08sIFwKCXNob3dfcHdtLCBzZXRfcHdtLCBTWVNfUFdN
X0VOQUJMRSwgaXgtMSk7IFwKc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8yKHB3bSMjaXgjI19y
YW1wX3JhdGUsIFNfSVJVR08sIFwKCXNob3dfcHdtLCBzZXRfcHdtLCBTWVNfUFdNX1JBTVBfUkFU
RSwgaXgtMSk7IFwKc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8yKHB3bSMjaXgjI19hdXRvX2No
YW5uZWxzX3pvbmUsIFNfSVJVR08sIFwKCXNob3dfcHdtLCBzZXRfcHdtLCBTWVNfUFdNX0FVVE9f
Q0hBTk5FTFNfWk9ORSwgaXgtMSk7IFwKc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8yKHB3bSMj
aXgjI19hdXRvX3B3bV9taW4sIFNfSVJVR08sIFwKCXNob3dfcHdtLCBzZXRfcHdtLCBTWVNfUFdN
X0FVVE9fUFdNX01JTiwgaXgtMSk7IFwKc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8yKHB3bSMj
aXgjI19hdXRvX3BvaW50MV9wd20sIFNfSVJVR08sIFwKCXNob3dfcHdtLCBzZXRfcHdtLCBTWVNf
UFdNX0FVVE9fUE9JTlQxX1BXTSwgaXgtMSk7IFwKc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8y
KHB3bSMjaXgjI19hdXRvX3BvaW50Ml9wd20sIFNfSVJVR08sIFwKCXNob3dfcHdtLCBOVUxMLCBT
WVNfUFdNX0FVVE9fUE9JTlQyX1BXTSwgaXgtMSkKClNFTlNPUl9ERVZJQ0VfQVRUUl9QV01fMVRP
MygxKTsKU0VOU09SX0RFVklDRV9BVFRSX1BXTV8xVE8zKDIpOwpTRU5TT1JfREVWSUNFX0FUVFJf
UFdNXzFUTzMoMyk7CgovKiBQV01zIDUtNiAqLwoKI2RlZmluZSBTRU5TT1JfREVWSUNFX0FUVFJf
UFdNXzVUTzYoaXgpIFwKc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8yKHB3bSMjaXgsIFNfSVJV
R08gfCBTX0lXVVNSLCBcCglzaG93X3B3bSwgc2V0X3B3bSwgU1lTX1BXTSwgaXgtMSk7IFwKc3Rh
dGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8yKHB3bSMjaXgjI19mcmVxLCBTX0lSVUdPIHwgU19JV1VT
UiwgXAoJc2hvd19wd20sIHNldF9wd20sIFNZU19QV01fRlJFUSwgaXgtMSk7IFwKc3RhdGljIFNF
TlNPUl9ERVZJQ0VfQVRUUl8yKHB3bSMjaXgjI19lbmFibGUsIFNfSVJVR08sIFwKCXNob3dfcHdt
LCBOVUxMLCBTWVNfUFdNX0VOQUJMRSwgaXgtMSkKClNFTlNPUl9ERVZJQ0VfQVRUUl9QV01fNVRP
Nig1KTsKU0VOU09SX0RFVklDRV9BVFRSX1BXTV81VE82KDYpOwoKLyogTWlzYyAqLwoKc3RhdGlj
IERFVklDRV9BVFRSKHZybSwgU19JUlVHTyB8IFNfSVdVU1IsIHNob3dfdnJtLCBzZXRfdnJtKTsK
c3RhdGljIERFVklDRV9BVFRSKGNwdTBfdmlkLCBTX0lSVUdPLCBzaG93X3ZpZCwgTlVMTCk7CnN0
YXRpYyBERVZJQ0VfQVRUUihuYW1lLCBTX0lSVUdPLCBzaG93X25hbWUsIE5VTEwpOyAgIC8qIGZv
ciBJU0EgZGV2aWNlcyAqLwoKLyogVGhpcyBzdHJ1Y3QgaG9sZHMgYWxsIHRoZSBhdHRyaWJ1dGVz
IHRoYXQgYXJlIGFsd2F5cyBwcmVzZW50IGFuZCBuZWVkIHRvIGJlCiAqIGNyZWF0ZWQgdW5jb25k
aXRpb25hbGx5LiBUaGUgYXR0cmlidXRlcyB0aGF0IG5lZWQgbW9kaWZpY2F0aW9uIG9mIHRoZWly
CiAqIHBlcm1pc3Npb25zIGFyZSBjcmVhdGVkIHJlYWQtb25seSBhbmQgd3JpdGUgcGVybWlzc2lv
bnMgYXJlIGFkZGVkIG9yIHJlbW92ZWQKICogb24gdGhlIGZseSB3aGVuIHJlcXVpcmVkICovCnN0
YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpkbWUxNzM3X2F0dHJbXSA9ewoJLyogVm9sdGFnZXMgKi8K
CSZzZW5zb3JfZGV2X2F0dHJfaW4wX2lucHV0LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9h
dHRyX2luMF9taW4uZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfaW4wX21heC5kZXZf
YXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9pbjBfYWxhcm0uZGV2X2F0dHIuYXR0ciwKCSZz
ZW5zb3JfZGV2X2F0dHJfaW4xX2lucHV0LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRy
X2luMV9taW4uZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfaW4xX21heC5kZXZfYXR0
ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9pbjFfYWxhcm0uZGV2X2F0dHIuYXR0ciwKCSZzZW5z
b3JfZGV2X2F0dHJfaW4yX2lucHV0LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX2lu
Ml9taW4uZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfaW4yX21heC5kZXZfYXR0ci5h
dHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9pbjJfYWxhcm0uZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3Jf
ZGV2X2F0dHJfaW4zX2lucHV0LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX2luM19t
aW4uZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfaW4zX21heC5kZXZfYXR0ci5hdHRy
LAoJJnNlbnNvcl9kZXZfYXR0cl9pbjNfYWxhcm0uZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2
X2F0dHJfaW40X2lucHV0LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX2luNF9taW4u
ZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfaW40X21heC5kZXZfYXR0ci5hdHRyLAoJ
JnNlbnNvcl9kZXZfYXR0cl9pbjRfYWxhcm0uZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0
dHJfaW41X2lucHV0LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX2luNV9taW4uZGV2
X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfaW41X21heC5kZXZfYXR0ci5hdHRyLAoJJnNl
bnNvcl9kZXZfYXR0cl9pbjVfYWxhcm0uZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJf
aW42X2lucHV0LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX2luNl9taW4uZGV2X2F0
dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfaW42X21heC5kZXZfYXR0ci5hdHRyLAoJJnNlbnNv
cl9kZXZfYXR0cl9pbjZfYWxhcm0uZGV2X2F0dHIuYXR0ciwKCS8qIFRlbXBlcmF0dXJlcyAqLwoJ
JnNlbnNvcl9kZXZfYXR0cl90ZW1wMV9pbnB1dC5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZf
YXR0cl90ZW1wMV9taW4uZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfdGVtcDFfbWF4
LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3RlbXAxX2FsYXJtLmRldl9hdHRyLmF0
dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3RlbXAxX2ZhdWx0LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29y
X2Rldl9hdHRyX3RlbXAyX2lucHV0LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3Rl
bXAyX21pbi5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl90ZW1wMl9tYXguZGV2X2F0
dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfdGVtcDJfYWxhcm0uZGV2X2F0dHIuYXR0ciwKCSZz
ZW5zb3JfZGV2X2F0dHJfdGVtcDJfZmF1bHQuZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0
dHJfdGVtcDNfaW5wdXQuZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfdGVtcDNfbWlu
LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3RlbXAzX21heC5kZXZfYXR0ci5hdHRy
LAoJJnNlbnNvcl9kZXZfYXR0cl90ZW1wM19hbGFybS5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9k
ZXZfYXR0cl90ZW1wM19mYXVsdC5kZXZfYXR0ci5hdHRyLAoJLyogWm9uZXMgKi8KCSZzZW5zb3Jf
ZGV2X2F0dHJfem9uZTFfYXV0b19wb2ludDFfdGVtcF9oeXN0LmRldl9hdHRyLmF0dHIsCgkmc2Vu
c29yX2Rldl9hdHRyX3pvbmUxX2F1dG9fcG9pbnQxX3RlbXAuZGV2X2F0dHIuYXR0ciwKCSZzZW5z
b3JfZGV2X2F0dHJfem9uZTFfYXV0b19wb2ludDJfdGVtcC5kZXZfYXR0ci5hdHRyLAoJJnNlbnNv
cl9kZXZfYXR0cl96b25lMV9hdXRvX3BvaW50M190ZW1wLmRldl9hdHRyLmF0dHIsCgkmc2Vuc29y
X2Rldl9hdHRyX3pvbmUxX2F1dG9fY2hhbm5lbHNfdGVtcC5kZXZfYXR0ci5hdHRyLAoJJnNlbnNv
cl9kZXZfYXR0cl96b25lMl9hdXRvX3BvaW50MV90ZW1wX2h5c3QuZGV2X2F0dHIuYXR0ciwKCSZz
ZW5zb3JfZGV2X2F0dHJfem9uZTJfYXV0b19wb2ludDFfdGVtcC5kZXZfYXR0ci5hdHRyLAoJJnNl
bnNvcl9kZXZfYXR0cl96b25lMl9hdXRvX3BvaW50Ml90ZW1wLmRldl9hdHRyLmF0dHIsCgkmc2Vu
c29yX2Rldl9hdHRyX3pvbmUyX2F1dG9fcG9pbnQzX3RlbXAuZGV2X2F0dHIuYXR0ciwKCSZzZW5z
b3JfZGV2X2F0dHJfem9uZTJfYXV0b19jaGFubmVsc190ZW1wLmRldl9hdHRyLmF0dHIsCgkmc2Vu
c29yX2Rldl9hdHRyX3pvbmUzX2F1dG9fcG9pbnQxX3RlbXBfaHlzdC5kZXZfYXR0ci5hdHRyLAoJ
JnNlbnNvcl9kZXZfYXR0cl96b25lM19hdXRvX3BvaW50MV90ZW1wLmRldl9hdHRyLmF0dHIsCgkm
c2Vuc29yX2Rldl9hdHRyX3pvbmUzX2F1dG9fcG9pbnQyX3RlbXAuZGV2X2F0dHIuYXR0ciwKCSZz
ZW5zb3JfZGV2X2F0dHJfem9uZTNfYXV0b19wb2ludDNfdGVtcC5kZXZfYXR0ci5hdHRyLAoJJnNl
bnNvcl9kZXZfYXR0cl96b25lM19hdXRvX2NoYW5uZWxzX3RlbXAuZGV2X2F0dHIuYXR0ciwKCS8q
IE1pc2MgKi8KCSZkZXZfYXR0cl92cm0uYXR0ciwKCSZkZXZfYXR0cl9jcHUwX3ZpZC5hdHRyLAoJ
TlVMTAp9OwoKc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgZG1lMTczN19ncm91
cCA9IHsKCS5hdHRycyA9IGRtZTE3MzdfYXR0ciwKfTsKCi8qIFRoZSBmb2xsb3dpbmcgc3RydWN0
IGhvbGRzIHRoZSB0ZW1wIG9mZnNldCBhdHRyaWJ1dGVzLCB3aGljaCBhcmUgbm90CiAqIGF2YWls
YWJsZSBpbiBhbGwgY2hpcHMuIFRoZWlyIGNyZWF0aW9uIGRlcGVuZHMgb24gdGhlIGNoaXAgdHlw
ZSB3aGljaCBpcwogKiBkZXRlcm1pbmVkIGR1cmluZyBtb2R1bGUgbG9hZC4gKi8Kc3RhdGljIHN0
cnVjdCBhdHRyaWJ1dGUgKmRtZTE3MzdfYXR0cl90ZW1wX29mZnNldFtdID0gewoJJnNlbnNvcl9k
ZXZfYXR0cl90ZW1wMV9vZmZzZXQuZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfdGVt
cDJfb2Zmc2V0LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3RlbXAzX29mZnNldC5k
ZXZfYXR0ci5hdHRyLAoJTlVMTAp9OwoKc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3Jv
dXAgZG1lMTczN190ZW1wX29mZnNldF9ncm91cCA9IHsKCS5hdHRycyA9IGRtZTE3MzdfYXR0cl90
ZW1wX29mZnNldCwKfTsKCi8qIFRoZSBmb2xsb3dpbmcgc3RydWN0cyBob2xkIHRoZSBQV00gYXR0
cmlidXRlcywgc29tZSBvZiB3aGljaCBhcmUgb3B0aW9uYWwuCiAqIFRoZWlyIGNyZWF0aW9uIGRl
cGVuZHMgb24gdGhlIGNoaXAgY29uZmlndXJhdGlvbiB3aGljaCBpcyBkZXRlcm1pbmVkIGR1cmlu
ZwogKiBtb2R1bGUgbG9hZC4gKi8Kc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKmRtZTE3MzdfYXR0
cl9wd20xW10gPSB7Cgkmc2Vuc29yX2Rldl9hdHRyX3B3bTEuZGV2X2F0dHIuYXR0ciwKCSZzZW5z
b3JfZGV2X2F0dHJfcHdtMV9mcmVxLmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3B3
bTFfZW5hYmxlLmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3B3bTFfcmFtcF9yYXRl
LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3B3bTFfYXV0b19jaGFubmVsc196b25l
LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3B3bTFfYXV0b19wd21fbWluLmRldl9h
dHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3B3bTFfYXV0b19wb2ludDFfcHdtLmRldl9hdHRy
LmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3B3bTFfYXV0b19wb2ludDJfcHdtLmRldl9hdHRyLmF0
dHIsCglOVUxMCn07CnN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpkbWUxNzM3X2F0dHJfcHdtMltd
ID0gewoJJnNlbnNvcl9kZXZfYXR0cl9wd20yLmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9h
dHRyX3B3bTJfZnJlcS5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9wd20yX2VuYWJs
ZS5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9wd20yX3JhbXBfcmF0ZS5kZXZfYXR0
ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9wd20yX2F1dG9fY2hhbm5lbHNfem9uZS5kZXZfYXR0
ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9wd20yX2F1dG9fcHdtX21pbi5kZXZfYXR0ci5hdHRy
LAoJJnNlbnNvcl9kZXZfYXR0cl9wd20yX2F1dG9fcG9pbnQxX3B3bS5kZXZfYXR0ci5hdHRyLAoJ
JnNlbnNvcl9kZXZfYXR0cl9wd20yX2F1dG9fcG9pbnQyX3B3bS5kZXZfYXR0ci5hdHRyLAoJTlVM
TAp9OwpzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqZG1lMTczN19hdHRyX3B3bTNbXSA9IHsKCSZz
ZW5zb3JfZGV2X2F0dHJfcHdtMy5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9wd20z
X2ZyZXEuZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfcHdtM19lbmFibGUuZGV2X2F0
dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfcHdtM19yYW1wX3JhdGUuZGV2X2F0dHIuYXR0ciwK
CSZzZW5zb3JfZGV2X2F0dHJfcHdtM19hdXRvX2NoYW5uZWxzX3pvbmUuZGV2X2F0dHIuYXR0ciwK
CSZzZW5zb3JfZGV2X2F0dHJfcHdtM19hdXRvX3B3bV9taW4uZGV2X2F0dHIuYXR0ciwKCSZzZW5z
b3JfZGV2X2F0dHJfcHdtM19hdXRvX3BvaW50MV9wd20uZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3Jf
ZGV2X2F0dHJfcHdtM19hdXRvX3BvaW50Ml9wd20uZGV2X2F0dHIuYXR0ciwKCU5VTEwKfTsKc3Rh
dGljIHN0cnVjdCBhdHRyaWJ1dGUgKmRtZTE3MzdfYXR0cl9wd201W10gPSB7Cgkmc2Vuc29yX2Rl
dl9hdHRyX3B3bTUuZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfcHdtNV9mcmVxLmRl
dl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3B3bTVfZW5hYmxlLmRldl9hdHRyLmF0dHIs
CglOVUxMCn07CnN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpkbWUxNzM3X2F0dHJfcHdtNltdID0g
ewoJJnNlbnNvcl9kZXZfYXR0cl9wd202LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRy
X3B3bTZfZnJlcS5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9wd202X2VuYWJsZS5k
ZXZfYXR0ci5hdHRyLAoJTlVMTAp9OwoKc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3Jv
dXAgZG1lMTczN19wd21fZ3JvdXBbXSA9IHsKCXsgLmF0dHJzID0gZG1lMTczN19hdHRyX3B3bTEg
fSwKCXsgLmF0dHJzID0gZG1lMTczN19hdHRyX3B3bTIgfSwKCXsgLmF0dHJzID0gZG1lMTczN19h
dHRyX3B3bTMgfSwKCXsgLmF0dHJzID0gTlVMTCB9LAoJeyAuYXR0cnMgPSBkbWUxNzM3X2F0dHJf
cHdtNSB9LAoJeyAuYXR0cnMgPSBkbWUxNzM3X2F0dHJfcHdtNiB9LAp9OwoKLyogVGhlIGZvbGxv
d2luZyBzdHJ1Y3RzIGhvbGQgdGhlIGZhbiBhdHRyaWJ1dGVzLCBzb21lIG9mIHdoaWNoIGFyZSBv
cHRpb25hbC4KICogVGhlaXIgY3JlYXRpb24gZGVwZW5kcyBvbiB0aGUgY2hpcCBjb25maWd1cmF0
aW9uIHdoaWNoIGlzIGRldGVybWluZWQgZHVyaW5nCiAqIG1vZHVsZSBsb2FkLiAqLwpzdGF0aWMg
c3RydWN0IGF0dHJpYnV0ZSAqZG1lMTczN19hdHRyX2ZhbjFbXSA9IHsKCSZzZW5zb3JfZGV2X2F0
dHJfZmFuMV9pbnB1dC5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9mYW4xX21pbi5k
ZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9mYW4xX2FsYXJtLmRldl9hdHRyLmF0dHIs
Cgkmc2Vuc29yX2Rldl9hdHRyX2ZhbjFfdHlwZS5kZXZfYXR0ci5hdHRyLAoJTlVMTAp9OwpzdGF0
aWMgc3RydWN0IGF0dHJpYnV0ZSAqZG1lMTczN19hdHRyX2ZhbjJbXSA9IHsKCSZzZW5zb3JfZGV2
X2F0dHJfZmFuMl9pbnB1dC5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9mYW4yX21p
bi5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9mYW4yX2FsYXJtLmRldl9hdHRyLmF0
dHIsCgkmc2Vuc29yX2Rldl9hdHRyX2ZhbjJfdHlwZS5kZXZfYXR0ci5hdHRyLAoJTlVMTAp9Owpz
dGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqZG1lMTczN19hdHRyX2ZhbjNbXSA9IHsKCSZzZW5zb3Jf
ZGV2X2F0dHJfZmFuM19pbnB1dC5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9mYW4z
X21pbi5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9mYW4zX2FsYXJtLmRldl9hdHRy
LmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX2ZhbjNfdHlwZS5kZXZfYXR0ci5hdHRyLAoJTlVMTAp9
OwpzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqZG1lMTczN19hdHRyX2ZhbjRbXSA9IHsKCSZzZW5z
b3JfZGV2X2F0dHJfZmFuNF9pbnB1dC5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9m
YW40X21pbi5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9mYW40X2FsYXJtLmRldl9h
dHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX2ZhbjRfdHlwZS5kZXZfYXR0ci5hdHRyLAoJTlVM
TAp9OwpzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqZG1lMTczN19hdHRyX2ZhbjVbXSA9IHsKCSZz
ZW5zb3JfZGV2X2F0dHJfZmFuNV9pbnB1dC5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0
cl9mYW41X21pbi5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9mYW41X2FsYXJtLmRl
dl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX2ZhbjVfbWF4LmRldl9hdHRyLmF0dHIsCglO
VUxMCn07CnN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpkbWUxNzM3X2F0dHJfZmFuNltdID0gewoJ
JnNlbnNvcl9kZXZfYXR0cl9mYW42X2lucHV0LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9h
dHRyX2ZhbjZfbWluLmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX2ZhbjZfYWxhcm0u
ZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfZmFuNl9tYXguZGV2X2F0dHIuYXR0ciwK
CU5VTEwKfTsKCnN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIGRtZTE3MzdfZmFu
X2dyb3VwW10gPSB7Cgl7IC5hdHRycyA9IGRtZTE3MzdfYXR0cl9mYW4xIH0sCgl7IC5hdHRycyA9
IGRtZTE3MzdfYXR0cl9mYW4yIH0sCgl7IC5hdHRycyA9IGRtZTE3MzdfYXR0cl9mYW4zIH0sCgl7
IC5hdHRycyA9IGRtZTE3MzdfYXR0cl9mYW40IH0sCgl7IC5hdHRycyA9IGRtZTE3MzdfYXR0cl9m
YW41IH0sCgl7IC5hdHRycyA9IGRtZTE3MzdfYXR0cl9mYW42IH0sCn07CgovKiBUaGUgcGVybWlz
c2lvbnMgb2YgdGhlIGZvbGxvd2luZyB6b25lIGF0dHJpYnV0ZXMgYXJlIGNoYW5nZWQgdG8gcmVh
ZC0KICogd3JpdGVhYmxlIGlmIHRoZSBjaGlwIGlzICpub3QqIGxvY2tlZC4gT3RoZXJ3aXNlIHRo
ZXkgc3RheSByZWFkLW9ubHkuICovCnN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpkbWUxNzM3X2F0
dHJfem9uZV9jaG1vZFtdID0gewoJJnNlbnNvcl9kZXZfYXR0cl96b25lMV9hdXRvX3BvaW50MV90
ZW1wX2h5c3QuZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfem9uZTFfYXV0b19wb2lu
dDFfdGVtcC5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl96b25lMV9hdXRvX3BvaW50
Ml90ZW1wLmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3pvbmUxX2F1dG9fcG9pbnQz
X3RlbXAuZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfem9uZTJfYXV0b19wb2ludDFf
dGVtcF9oeXN0LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3pvbmUyX2F1dG9fcG9p
bnQxX3RlbXAuZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfem9uZTJfYXV0b19wb2lu
dDJfdGVtcC5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl96b25lMl9hdXRvX3BvaW50
M190ZW1wLmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3pvbmUzX2F1dG9fcG9pbnQx
X3RlbXBfaHlzdC5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl96b25lM19hdXRvX3Bv
aW50MV90ZW1wLmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3pvbmUzX2F1dG9fcG9p
bnQyX3RlbXAuZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfem9uZTNfYXV0b19wb2lu
dDNfdGVtcC5kZXZfYXR0ci5hdHRyLAoJTlVMTAp9OwoKc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRy
aWJ1dGVfZ3JvdXAgZG1lMTczN196b25lX2NobW9kX2dyb3VwID0gewoJLmF0dHJzID0gZG1lMTcz
N19hdHRyX3pvbmVfY2htb2QsCn07CgovKiBUaGUgcGVybWlzc2lvbnMgb2YgdGhlIGZvbGxvd2lu
ZyB0ZW1wIG9mZnNldCBhdHRyaWJ1dGVzIGFyZSBjaGFuZ2VkIHRvIHJlYWQtCiAqIHdyaXRlYWJs
ZSBpZiB0aGUgY2hpcCBpcyAqbm90KiBsb2NrZWQgYW5kIGl0IGlzICpub3QqIGEgU0NINTAyNyAo
d2hpY2gKICogZG9lc24ndCBzdXBwb3J0IHRlbXAgb2Zmc2V0cykuICovCnN0YXRpYyBzdHJ1Y3Qg
YXR0cmlidXRlICpkbWUxNzM3X2F0dHJfdGVtcF9vZmZzZXRfY2htb2RbXSA9IHsKCSZzZW5zb3Jf
ZGV2X2F0dHJfdGVtcDFfb2Zmc2V0LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3Rl
bXAyX29mZnNldC5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl90ZW1wM19vZmZzZXQu
ZGV2X2F0dHIuYXR0ciwKCU5VTEwKfTsKCnN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dy
b3VwIGRtZTE3MzdfdGVtcF9vZmZzZXRfY2htb2RfZ3JvdXAgPSB7CgkuYXR0cnMgPSBkbWUxNzM3
X2F0dHJfdGVtcF9vZmZzZXRfY2htb2QsCn07CgovKiBUaGUgcGVybWlzc2lvbnMgb2YgdGhlIGZv
bGxvd2luZyBQV00gYXR0cmlidXRlcyBhcmUgY2hhbmdlZCB0byByZWFkLQogKiB3cml0ZWFibGUg
aWYgdGhlIGNoaXAgaXMgKm5vdCogbG9ja2VkIGFuZCB0aGUgcmVzcGVjdGl2ZSBQV00gaXMgYXZh
aWxhYmxlLgogKiBPdGhlcndpc2UgdGhleSBzdGF5IHJlYWQtb25seS4gKi8Kc3RhdGljIHN0cnVj
dCBhdHRyaWJ1dGUgKmRtZTE3MzdfYXR0cl9wd20xX2NobW9kW10gPSB7Cgkmc2Vuc29yX2Rldl9h
dHRyX3B3bTFfZnJlcS5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9wd20xX2VuYWJs
ZS5kZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9wd20xX3JhbXBfcmF0ZS5kZXZfYXR0
ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9wd20xX2F1dG9fY2hhbm5lbHNfem9uZS5kZXZfYXR0
ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9wd20xX2F1dG9fcG9pbnQxX3B3bS5kZXZfYXR0ci5h
dHRyLAoJTlVMTAp9OwpzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqZG1lMTczN19hdHRyX3B3bTJf
Y2htb2RbXSA9IHsKCSZzZW5zb3JfZGV2X2F0dHJfcHdtMl9mcmVxLmRldl9hdHRyLmF0dHIsCgkm
c2Vuc29yX2Rldl9hdHRyX3B3bTJfZW5hYmxlLmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9h
dHRyX3B3bTJfcmFtcF9yYXRlLmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3B3bTJf
YXV0b19jaGFubmVsc196b25lLmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3B3bTJf
YXV0b19wb2ludDFfcHdtLmRldl9hdHRyLmF0dHIsCglOVUxMCn07CnN0YXRpYyBzdHJ1Y3QgYXR0
cmlidXRlICpkbWUxNzM3X2F0dHJfcHdtM19jaG1vZFtdID0gewoJJnNlbnNvcl9kZXZfYXR0cl9w
d20zX2ZyZXEuZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfcHdtM19lbmFibGUuZGV2
X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfcHdtM19yYW1wX3JhdGUuZGV2X2F0dHIuYXR0
ciwKCSZzZW5zb3JfZGV2X2F0dHJfcHdtM19hdXRvX2NoYW5uZWxzX3pvbmUuZGV2X2F0dHIuYXR0
ciwKCSZzZW5zb3JfZGV2X2F0dHJfcHdtM19hdXRvX3BvaW50MV9wd20uZGV2X2F0dHIuYXR0ciwK
CU5VTEwKfTsKc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKmRtZTE3MzdfYXR0cl9wd201X2NobW9k
W10gPSB7Cgkmc2Vuc29yX2Rldl9hdHRyX3B3bTUuZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2
X2F0dHJfcHdtNV9mcmVxLmRldl9hdHRyLmF0dHIsCglOVUxMCn07CnN0YXRpYyBzdHJ1Y3QgYXR0
cmlidXRlICpkbWUxNzM3X2F0dHJfcHdtNl9jaG1vZFtdID0gewoJJnNlbnNvcl9kZXZfYXR0cl9w
d202LmRldl9hdHRyLmF0dHIsCgkmc2Vuc29yX2Rldl9hdHRyX3B3bTZfZnJlcS5kZXZfYXR0ci5h
dHRyLAoJTlVMTAp9OwoKc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgZG1lMTcz
N19wd21fY2htb2RfZ3JvdXBbXSA9IHsKCXsgLmF0dHJzID0gZG1lMTczN19hdHRyX3B3bTFfY2ht
b2QgfSwKCXsgLmF0dHJzID0gZG1lMTczN19hdHRyX3B3bTJfY2htb2QgfSwKCXsgLmF0dHJzID0g
ZG1lMTczN19hdHRyX3B3bTNfY2htb2QgfSwKCXsgLmF0dHJzID0gTlVMTCB9LAoJeyAuYXR0cnMg
PSBkbWUxNzM3X2F0dHJfcHdtNV9jaG1vZCB9LAoJeyAuYXR0cnMgPSBkbWUxNzM3X2F0dHJfcHdt
Nl9jaG1vZCB9LAp9OwoKLyogUHdtWzEtM10gYXJlIHJlYWQtd3JpdGVhYmxlIGlmIHRoZSBhc3Nv
Y2lhdGVkIHB3bSBpcyBpbiBtYW51YWwgbW9kZSBhbmQgdGhlCiAqIGNoaXAgaXMgbm90IGxvY2tl
ZC4gT3RoZXJ3aXNlIHRoZXkgYXJlIHJlYWQtb25seS4gKi8Kc3RhdGljIHN0cnVjdCBhdHRyaWJ1
dGUgKmRtZTE3MzdfYXR0cl9wd21fY2htb2RbXSA9IHsKCSZzZW5zb3JfZGV2X2F0dHJfcHdtMS5k
ZXZfYXR0ci5hdHRyLAoJJnNlbnNvcl9kZXZfYXR0cl9wd20yLmRldl9hdHRyLmF0dHIsCgkmc2Vu
c29yX2Rldl9hdHRyX3B3bTMuZGV2X2F0dHIuYXR0ciwKfTsKCi8qIFB3bVsxLTNdX2F1dG9fcHdt
X21pbiBhcmUgcmVhZC13cml0ZWFibGUgaWYgdGhlIGNoaXAgaXMgKm5vdCogYSBTQ0g1MDI3Lgog
KiBPdGhlcndpc2UgdGhleSBhcmUgcmVhZC1vbmx5LiAqLwpzdGF0aWMgc3RydWN0IGF0dHJpYnV0
ZSAqZG1lMTczN19hdHRyX3B3bV9taW5fY2htb2RbXSA9IHsKCSZzZW5zb3JfZGV2X2F0dHJfcHdt
MV9hdXRvX3B3bV9taW4uZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfcHdtMl9hdXRv
X3B3bV9taW4uZGV2X2F0dHIuYXR0ciwKCSZzZW5zb3JfZGV2X2F0dHJfcHdtM19hdXRvX3B3bV9t
aW4uZGV2X2F0dHIuYXR0ciwKfTsKCi8qIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogKiBTdXBlci1JTyBmdW5jdGlv
bnMKICogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tICovCgpzdGF0aWMgaW5saW5lIHZvaWQgZG1lMTczN19zaW9fZW50
ZXIoaW50IHNpb19jaXApCnsKCW91dGIoMHg1NSwgc2lvX2NpcCk7Cn0KCnN0YXRpYyBpbmxpbmUg
dm9pZCBkbWUxNzM3X3Npb19leGl0KGludCBzaW9fY2lwKQp7CglvdXRiKDB4YWEsIHNpb19jaXAp
Owp9CgpzdGF0aWMgaW5saW5lIGludCBkbWUxNzM3X3Npb19pbmIoaW50IHNpb19jaXAsIGludCBy
ZWcpCnsKCW91dGIocmVnLCBzaW9fY2lwKTsKCXJldHVybiBpbmIoc2lvX2NpcCArIDEpOwp9Cgpz
dGF0aWMgaW5saW5lIHZvaWQgZG1lMTczN19zaW9fb3V0YihpbnQgc2lvX2NpcCwgaW50IHJlZywg
aW50IHZhbCkKewoJb3V0YihyZWcsIHNpb19jaXApOwoJb3V0Yih2YWwsIHNpb19jaXAgKyAxKTsK
fQoKLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCiAqIERldmljZSBpbml0aWFsaXphdGlvbgogKiAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0gKi8KCnN0YXRpYyBpbnQgZG1lMTczN19pMmNfZ2V0X2ZlYXR1cmVzKGludCwgc3RydWN0IGRt
ZTE3MzdfZGF0YSopOwoKc3RhdGljIHZvaWQgZG1lMTczN19jaG1vZF9maWxlKHN0cnVjdCBkZXZp
Y2UgKmRldiwKCQkJICAgICAgIHN0cnVjdCBhdHRyaWJ1dGUgKmF0dHIsIG1vZGVfdCBtb2RlKQp7
CglpZiAoc3lzZnNfY2htb2RfZmlsZSgmZGV2LT5rb2JqLCBhdHRyLCBtb2RlKSkgewoJCWRldl93
YXJuKGRldiwgIkZhaWxlZCB0byBjaGFuZ2UgcGVybWlzc2lvbnMgb2YgJXMuXG4iLAoJCQkgYXR0
ci0+bmFtZSk7Cgl9Cn0KCnN0YXRpYyB2b2lkIGRtZTE3MzdfY2htb2RfZ3JvdXAoc3RydWN0IGRl
dmljZSAqZGV2LAoJCQkJY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCAqZ3JvdXAsCgkJCQlt
b2RlX3QgbW9kZSkKewoJc3RydWN0IGF0dHJpYnV0ZSAqKmF0dHI7CgoJZm9yIChhdHRyID0gZ3Jv
dXAtPmF0dHJzOyAqYXR0cjsgYXR0cisrKSB7CgkJZG1lMTczN19jaG1vZF9maWxlKGRldiwgKmF0
dHIsIG1vZGUpOwoJfQp9CgpzdGF0aWMgdm9pZCBkbWUxNzM3X3JlbW92ZV9maWxlcyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYpCnsKCXN0cnVjdCBkbWUxNzM3X2RhdGEgKmRhdGEgPSBkZXZfZ2V0X2RydmRh
dGEoZGV2KTsKCWludCBpeDsKCglmb3IgKGl4ID0gMDsgaXggPCBBUlJBWV9TSVpFKGRtZTE3Mzdf
ZmFuX2dyb3VwKTsgaXgrKykgewoJCWlmIChkYXRhLT5oYXNfZmFuICYgKDEgPDwgaXgpKSB7CgkJ
CXN5c2ZzX3JlbW92ZV9ncm91cCgmZGV2LT5rb2JqLAoJCQkJCSAgICZkbWUxNzM3X2Zhbl9ncm91
cFtpeF0pOwoJCX0KCX0KCglmb3IgKGl4ID0gMDsgaXggPCBBUlJBWV9TSVpFKGRtZTE3MzdfcHdt
X2dyb3VwKTsgaXgrKykgewoJCWlmIChkYXRhLT5oYXNfcHdtICYgKDEgPDwgaXgpKSB7CgkJCXN5
c2ZzX3JlbW92ZV9ncm91cCgmZGV2LT5rb2JqLAoJCQkJCSAgICZkbWUxNzM3X3B3bV9ncm91cFtp
eF0pOwoJCX0KCX0KCglpZiAoZGF0YS0+dHlwZSAhPSBzY2g1MDI3KSB7CgkJc3lzZnNfcmVtb3Zl
X2dyb3VwKCZkZXYtPmtvYmosICZkbWUxNzM3X3RlbXBfb2Zmc2V0X2dyb3VwKTsKCX0KCglzeXNm
c19yZW1vdmVfZ3JvdXAoJmRldi0+a29iaiwgJmRtZTE3MzdfZ3JvdXApOwoKCWlmICghZGF0YS0+
Y2xpZW50LmRyaXZlcikgewoJCXN5c2ZzX3JlbW92ZV9maWxlKCZkZXYtPmtvYmosICZkZXZfYXR0
cl9uYW1lLmF0dHIpOwoJfQp9CgpzdGF0aWMgaW50IGRtZTE3MzdfY3JlYXRlX2ZpbGVzKHN0cnVj
dCBkZXZpY2UgKmRldikKewoJc3RydWN0IGRtZTE3MzdfZGF0YSAqZGF0YSA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOwoJaW50IGVyciwgaXg7CgoJLyogQ3JlYXRlIGEgbmFtZSBhdHRyaWJ1dGUgZm9y
IElTQSBkZXZpY2VzICovCglpZiAoIWRhdGEtPmNsaWVudC5kcml2ZXIgJiYKCSAgICAoZXJyID0g
c3lzZnNfY3JlYXRlX2ZpbGUoJmRldi0+a29iaiwgJmRldl9hdHRyX25hbWUuYXR0cikpKSB7CgkJ
Z290byBleGl0OwoJfQoKCS8qIENyZWF0ZSBzdGFuZGFyZCBzeXNmcyBhdHRyaWJ1dGVzICovCglp
ZiAoKGVyciA9IHN5c2ZzX2NyZWF0ZV9ncm91cCgmZGV2LT5rb2JqLCAmZG1lMTczN19ncm91cCkp
KSB7CgkJZ290byBleGl0X3JlbW92ZTsKCX0KCgkvKiBDcmVhdGUgdGVtcCBvZmZzZXQgYXR0cmli
dXRlcyAqLwoJaWYgKChkYXRhLT50eXBlICE9IHNjaDUwMjcpICYmCgkgICAgKGVyciA9IHN5c2Zz
X2NyZWF0ZV9ncm91cCgmZGV2LT5rb2JqLAoJCQkJICAgICAgJmRtZTE3MzdfdGVtcF9vZmZzZXRf
Z3JvdXApKSkgewoJCWdvdG8gZXhpdF9yZW1vdmU7Cgl9CgoJLyogQ3JlYXRlIGZhbiBzeXNmcyBh
dHRyaWJ1dGVzICovCglmb3IgKGl4ID0gMDsgaXggPCBBUlJBWV9TSVpFKGRtZTE3MzdfZmFuX2dy
b3VwKTsgaXgrKykgewoJCWlmIChkYXRhLT5oYXNfZmFuICYgKDEgPDwgaXgpKSB7CgkJCWlmICgo
ZXJyID0gc3lzZnNfY3JlYXRlX2dyb3VwKCZkZXYtPmtvYmosCgkJCQkJCSZkbWUxNzM3X2Zhbl9n
cm91cFtpeF0pKSkgewoJCQkJZ290byBleGl0X3JlbW92ZTsKCQkJfQoJCX0KCX0KCgkvKiBDcmVh
dGUgUFdNIHN5c2ZzIGF0dHJpYnV0ZXMgKi8KCWZvciAoaXggPSAwOyBpeCA8IEFSUkFZX1NJWkUo
ZG1lMTczN19wd21fZ3JvdXApOyBpeCsrKSB7CgkJaWYgKGRhdGEtPmhhc19wd20gJiAoMSA8PCBp
eCkpIHsKCQkJaWYgKChlcnIgPSBzeXNmc19jcmVhdGVfZ3JvdXAoJmRldi0+a29iaiwKCQkJCQkJ
JmRtZTE3MzdfcHdtX2dyb3VwW2l4XSkpKSB7CgkJCQlnb3RvIGV4aXRfcmVtb3ZlOwoJCQl9CgkJ
fQoJfQoKCS8qIEluZm9ybSBpZiB0aGUgZGV2aWNlIGlzIGxvY2tlZC4gT3RoZXJ3aXNlIGNoYW5n
ZSB0aGUgcGVybWlzc2lvbnMgb2YKCSAqIHNlbGVjdGVkIGF0dHJpYnV0ZXMgZnJvbSByZWFkLW9u
bHkgdG8gcmVhZC13cml0ZWFibGUuICovCglpZiAoZGF0YS0+Y29uZmlnICYgMHgwMikgewoJCWRl
dl9pbmZvKGRldiwgIkRldmljZSBpcyBsb2NrZWQuIFNvbWUgYXR0cmlidXRlcyAiCgkJCSAid2ls
bCBiZSByZWFkLW9ubHkuXG4iKTsKCX0gZWxzZSB7CgkJLyogQ2hhbmdlIHBlcm1pc3Npb25zIG9m
IHpvbmUgYXR0cmlidXRlcyAqLwoJCWRtZTE3MzdfY2htb2RfZ3JvdXAoZGV2LCAmZG1lMTczN196
b25lX2NobW9kX2dyb3VwLAoJCQkJICAgIFNfSVJVR08gfCBTX0lXVVNSKTsKCgkJLyogQ2hhbmdl
IHBlcm1pc3Npb25zIG9mIHRlbXAgb2Zmc2V0IGF0dHJpYnV0ZXMgKi8KCQlpZiAoKGRhdGEtPnR5
cGUgPT0gZG1lMTczNyB8fCBkYXRhLT50eXBlID09IHNjaDMxMXgpKSB7CgkJCWRtZTE3MzdfY2ht
b2RfZ3JvdXAoZGV2LAoJCQkJCSAgICAmZG1lMTczN190ZW1wX29mZnNldF9jaG1vZF9ncm91cCwK
CQkJCQkgICAgU19JUlVHTyB8IFNfSVdVU1IpOwoJCX0KCgkJLyogQ2hhbmdlIHBlcm1pc3Npb25z
IG9mIFBXTSBhdHRyaWJ1dGVzICovCgkJZm9yIChpeCA9IDA7IGl4IDwgQVJSQVlfU0laRShkbWUx
NzM3X3B3bV9jaG1vZF9ncm91cCk7IGl4KyspIHsKCQkJaWYgKGRhdGEtPmhhc19wd20gJiAoMSA8
PCBpeCkpIHsKCQkJCWRtZTE3MzdfY2htb2RfZ3JvdXAoZGV2LAoJCQkJCQkmZG1lMTczN19wd21f
Y2htb2RfZ3JvdXBbaXhdLAoJCQkJCQlTX0lSVUdPIHwgU19JV1VTUik7CgkJCQlpZiAoZGF0YS0+
dHlwZSAhPSBzY2g1MDI3KSB7CgkJCQkJZG1lMTczN19jaG1vZF9maWxlKGRldiwKCQkJCQkJZG1l
MTczN19hdHRyX3B3bV9taW5fY2htb2RbaXhdLAoJCQkJCQlTX0lSVUdPIHwgU19JV1VTUik7CgkJ
CQl9CgkJCX0KCQl9CgoJCS8qIENoYW5nZSBwZXJtaXNzaW9ucyBvZiBwd21bMS0zXSBpZiBpbiBt
YW51YWwgbW9kZSAqLwoJCWZvciAoaXggPSAwOyBpeCA8IDM7IGl4KyspIHsKCQkJaWYgKChkYXRh
LT5oYXNfcHdtICYgKDEgPDwgaXgpKSAmJgoJCQkgICAgKFBXTV9FTl9GUk9NX1JFRyhkYXRhLT5w
d21fY29uZmlnW2l4XSkgPT0gMSkpIHsKCQkJCWRtZTE3MzdfY2htb2RfZmlsZShkZXYsCgkJCQkJ
CWRtZTE3MzdfYXR0cl9wd21fY2htb2RbaXhdLAoJCQkJCQlTX0lSVUdPIHwgU19JV1VTUik7CgkJ
CX0KCQl9Cgl9CgoJcmV0dXJuIDA7CgpleGl0X3JlbW92ZToKCWRtZTE3MzdfcmVtb3ZlX2ZpbGVz
KGRldik7CmV4aXQ6CglyZXR1cm4gZXJyOwp9CgpzdGF0aWMgaW50IGRtZTE3MzdfaW5pdF9kZXZp
Y2Uoc3RydWN0IGRldmljZSAqZGV2KQp7CglzdHJ1Y3QgZG1lMTczN19kYXRhICpkYXRhID0gZGV2
X2dldF9kcnZkYXRhKGRldik7CglzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gJmRhdGEtPmNs
aWVudDsKCWludCBpeDsKCXU4IHJlZzsKCglkYXRhLT5jb25maWcgPSBkbWUxNzM3X3JlYWQoY2xp
ZW50LCBETUUxNzM3X1JFR19DT05GSUcpOwoJLyogSW5mb3JtIGlmIHBhcnQgaXMgbm90IG1vbml0
b3Jpbmcvc3RhcnRlZCAqLwoJaWYgKCEoZGF0YS0+Y29uZmlnICYgMHgwMSkpIHsKCQlpZiAoIWZv
cmNlX3N0YXJ0KSB7CgkJCWRldl9lcnIoZGV2LCAiRGV2aWNlIGlzIG5vdCBtb25pdG9yaW5nLiAi
CgkJCQkiVXNlIHRoZSBmb3JjZV9zdGFydCBsb2FkIHBhcmFtZXRlciB0byAiCgkJCQkib3ZlcnJp
ZGUuXG4iKTsKCQkJcmV0dXJuIC1FRkFVTFQ7CgkJfQoKCQkvKiBGb3JjZSBtb25pdG9yaW5nICov
CgkJZGF0YS0+Y29uZmlnIHw9IDB4MDE7CgkJZG1lMTczN193cml0ZShjbGllbnQsIERNRTE3Mzdf
UkVHX0NPTkZJRywgZGF0YS0+Y29uZmlnKTsKCX0KCS8qIEluZm9ybSBpZiBwYXJ0IGlzIG5vdCBy
ZWFkeSAqLwoJaWYgKCEoZGF0YS0+Y29uZmlnICYgMHgwNCkpIHsKCQlkZXZfZXJyKGRldiwgIkRl
dmljZSBpcyBub3QgcmVhZHkuXG4iKTsKCQlyZXR1cm4gLUVGQVVMVDsKCX0KCgkvKiBEZXRlcm1p
bmUgd2hpY2ggb3B0aW9uYWwgZmFuIGFuZCBwd20gZmVhdHVyZXMgYXJlIGVuYWJsZWQvcHJlc2Vu
dCAqLwoJaWYgKGNsaWVudC0+ZHJpdmVyKSB7ICAgLyogSTJDIGNoaXAgKi8KCQlkYXRhLT5jb25m
aWcyID0gZG1lMTczN19yZWFkKGNsaWVudCwgRE1FMTczN19SRUdfQ09ORklHMik7CgkJLyogQ2hl
Y2sgaWYgb3B0aW9uYWwgZmFuMyBpbnB1dCBpcyBlbmFibGVkICovCgkJaWYgKGRhdGEtPmNvbmZp
ZzIgJiAweDA0KSB7CgkJCWRhdGEtPmhhc19mYW4gfD0gKDEgPDwgMik7CgkJfQoKCQkvKiBGYW40
IGFuZCBwd20zIGFyZSBvbmx5IGF2YWlsYWJsZSBpZiB0aGUgY2xpZW50J3MgSTJDIGFkZHJlc3MK
CQkgKiBpcyB0aGUgZGVmYXVsdCAweDJlLiBPdGhlcndpc2UgdGhlIEkvT3MgYXNzb2NpYXRlZCB3
aXRoCgkJICogdGhlc2UgZnVuY3Rpb25zIGFyZSB1c2VkIGZvciBhZGRyIGVuYWJsZS9zZWxlY3Qu
ICovCgkJaWYgKGRhdGEtPmNsaWVudC5hZGRyID09IDB4MmUpIHsKCQkJZGF0YS0+aGFzX2ZhbiB8
PSAoMSA8PCAzKTsKCQkJZGF0YS0+aGFzX3B3bSB8PSAoMSA8PCAyKTsKCQl9CgoJCS8qIERldGVy
bWluZSB3aGljaCBvZiB0aGUgb3B0aW9uYWwgZmFuWzUtNl0gYW5kIHB3bVs1LTZdCgkJICogZmVh
dHVyZXMgYXJlIGVuYWJsZWQuIEZvciB0aGlzLCB3ZSBuZWVkIHRvIHF1ZXJ5IHRoZSBydW50aW1l
CgkJICogcmVnaXN0ZXJzIHRocm91Z2ggdGhlIFN1cGVyLUlPIExQQyBpbnRlcmZhY2UuIFRyeSBi
b3RoCgkJICogY29uZmlnIHBvcnRzIDB4MmUgYW5kIDB4NGUuICovCgkJaWYgKGRtZTE3MzdfaTJj
X2dldF9mZWF0dXJlcygweDJlLCBkYXRhKSAmJgoJCSAgICBkbWUxNzM3X2kyY19nZXRfZmVhdHVy
ZXMoMHg0ZSwgZGF0YSkpIHsKCQkJZGV2X3dhcm4oZGV2LCAiRmFpbGVkIHRvIHF1ZXJ5IFN1cGVy
LUlPIGZvciBvcHRpb25hbCAiCgkJCQkgImZlYXR1cmVzLlxuIik7CgkJfQoJfSBlbHNlIHsgICAv
KiBJU0EgY2hpcCAqLwoJCS8qIEZhbjMgYW5kIHB3bTMgYXJlIGFsd2F5cyBhdmFpbGFibGUuIEZh
bls0LTVdIGFuZCBwd21bNS02XQoJCSAqIGRvbid0IGV4aXN0IGluIHRoZSBJU0EgY2hpcC4gKi8K
CQlkYXRhLT5oYXNfZmFuIHw9ICgxIDw8IDIpOwoJCWRhdGEtPmhhc19wd20gfD0gKDEgPDwgMik7
Cgl9CgoJLyogRmFuMSwgZmFuMiwgcHdtMSwgYW5kIHB3bTIgYXJlIGFsd2F5cyBwcmVzZW50ICov
CglkYXRhLT5oYXNfZmFuIHw9IDB4MDM7CglkYXRhLT5oYXNfcHdtIHw9IDB4MDM7CgoJZGV2X2lu
Zm8oZGV2LCAiT3B0aW9uYWwgZmVhdHVyZXM6IHB3bTM9JXMsIHB3bTU9JXMsIHB3bTY9JXMsICIK
CQkgImZhbjM9JXMsIGZhbjQ9JXMsIGZhbjU9JXMsIGZhbjY9JXMuXG4iLAoJCSAoZGF0YS0+aGFz
X3B3bSAmICgxIDw8IDIpKSA/ICJ5ZXMiIDogIm5vIiwKCQkgKGRhdGEtPmhhc19wd20gJiAoMSA8
PCA0KSkgPyAieWVzIiA6ICJubyIsCgkJIChkYXRhLT5oYXNfcHdtICYgKDEgPDwgNSkpID8gInll
cyIgOiAibm8iLAoJCSAoZGF0YS0+aGFzX2ZhbiAmICgxIDw8IDIpKSA/ICJ5ZXMiIDogIm5vIiwK
CQkgKGRhdGEtPmhhc19mYW4gJiAoMSA8PCAzKSkgPyAieWVzIiA6ICJubyIsCgkJIChkYXRhLT5o
YXNfZmFuICYgKDEgPDwgNCkpID8gInllcyIgOiAibm8iLAoJCSAoZGF0YS0+aGFzX2ZhbiAmICgx
IDw8IDUpKSA/ICJ5ZXMiIDogIm5vIik7CgoJcmVnID0gZG1lMTczN19yZWFkKGNsaWVudCwgRE1F
MTczN19SRUdfVEFDSF9QV00pOwoJLyogSW5mb3JtIGlmIGZhbi10by1wd20gbWFwcGluZyBkaWZm
ZXJzIGZyb20gdGhlIGRlZmF1bHQgKi8KCWlmIChjbGllbnQtPmRyaXZlciAmJiByZWcgIT0gMHhh
NCkgeyAgIC8qIEkyQyBjaGlwICovCgkJZGV2X3dhcm4oZGV2LCAiTm9uLXN0YW5kYXJkIGZhbiB0
byBwd20gbWFwcGluZzogIgoJCQkgImZhbjEtPnB3bSVkLCBmYW4yLT5wd20lZCwgZmFuMy0+cHdt
JWQsICIKCQkJICJmYW40LT5wd20lZC4gUGxlYXNlIHJlcG9ydCB0byB0aGUgZHJpdmVyICIKCQkJ
ICJtYWludGFpbmVyLlxuIiwKCQkJIChyZWcgJiAweDAzKSArIDEsICgocmVnID4+IDIpICYgMHgw
MykgKyAxLAoJCQkgKChyZWcgPj4gNCkgJiAweDAzKSArIDEsICgocmVnID4+IDYpICYgMHgwMykg
KyAxKTsKCX0gZWxzZSBpZiAoIWNsaWVudC0+ZHJpdmVyICYmIHJlZyAhPSAweDI0KSB7ICAgLyog
SVNBIGNoaXAgKi8KCQlkZXZfd2FybihkZXYsICJOb24tc3RhbmRhcmQgZmFuIHRvIHB3bSBtYXBw
aW5nOiAiCgkJCSAiZmFuMS0+cHdtJWQsIGZhbjItPnB3bSVkLCBmYW4zLT5wd20lZC4gIgoJCQkg
IlBsZWFzZSByZXBvcnQgdG8gdGhlIGRyaXZlciBtYWludGFpbmVyLlxuIiwKCQkJIChyZWcgJiAw
eDAzKSArIDEsICgocmVnID4+IDIpICYgMHgwMykgKyAxLAoJCQkgKChyZWcgPj4gNCkgJiAweDAz
KSArIDEpOwoJfQoKCS8qIFN3aXRjaCBwd21bMS0zXSB0byBtYW51YWwgbW9kZSBpZiB0aGV5IGFy
ZSBjdXJyZW50bHkgZGlzYWJsZWQgYW5kCgkgKiBzZXQgdGhlIGR1dHktY3ljbGVzIHRvIDAlICh3
aGljaCBpcyBpZGVudGljYWwgdG8gdGhlIFBXTXMgYmVpbmcKCSAqIGRpc2FibGVkKS4gKi8KCWlm
ICghKGRhdGEtPmNvbmZpZyAmIDB4MDIpKSB7CgkJZm9yIChpeCA9IDA7IGl4IDwgMzsgaXgrKykg
ewoJCQlkYXRhLT5wd21fY29uZmlnW2l4XSA9IGRtZTE3MzdfcmVhZChjbGllbnQsCgkJCQkJCURN
RTE3MzdfUkVHX1BXTV9DT05GSUcoaXgpKTsKCQkJaWYgKChkYXRhLT5oYXNfcHdtICYgKDEgPDwg
aXgpKSAmJgoJCQkgICAgKFBXTV9FTl9GUk9NX1JFRyhkYXRhLT5wd21fY29uZmlnW2l4XSkgPT0g
LTEpKSB7CgkJCQlkZXZfaW5mbyhkZXYsICJTd2l0Y2hpbmcgcHdtJWQgdG8gIgoJCQkJCSAibWFu
dWFsIG1vZGUuXG4iLCBpeCArIDEpOwoJCQkJZGF0YS0+cHdtX2NvbmZpZ1tpeF0gPSBQV01fRU5f
VE9fUkVHKDEsCgkJCQkJCQlkYXRhLT5wd21fY29uZmlnW2l4XSk7CgkJCQlkbWUxNzM3X3dyaXRl
KGNsaWVudCwgRE1FMTczN19SRUdfUFdNKGl4KSwgMCk7CgkJCQlkbWUxNzM3X3dyaXRlKGNsaWVu
dCwKCQkJCQkgICAgICBETUUxNzM3X1JFR19QV01fQ09ORklHKGl4KSwKCQkJCQkgICAgICBkYXRh
LT5wd21fY29uZmlnW2l4XSk7CgkJCX0KCQl9Cgl9CgoJLyogSW5pdGlhbGl6ZSB0aGUgZGVmYXVs
dCBQV00gYXV0byBjaGFubmVscyB6b25lIChhY3opIGFzc2lnbm1lbnRzICovCglkYXRhLT5wd21f
YWN6WzBdID0gMTsJLyogcHdtMSAtPiB6b25lMSAqLwoJZGF0YS0+cHdtX2FjelsxXSA9IDI7CS8q
IHB3bTIgLT4gem9uZTIgKi8KCWRhdGEtPnB3bV9hY3pbMl0gPSA0OwkvKiBwd20zIC0+IHpvbmUz
ICovCgoJLyogU2V0IFZSTSAqLwoJZGF0YS0+dnJtID0gdmlkX3doaWNoX3ZybSgpOwoKCXJldHVy
biAwOwp9CgovKiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KICogSTJDIGRldmljZSBkZXRlY3Rpb24gYW5kIHJlZ2lz
dHJhdGlvbgogKiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gKi8KCnN0YXRpYyBzdHJ1Y3QgaTJjX2RyaXZlciBkbWUx
NzM3X2kyY19kcml2ZXI7CgpzdGF0aWMgaW50IGRtZTE3MzdfaTJjX2dldF9mZWF0dXJlcyhpbnQg
c2lvX2NpcCwgc3RydWN0IGRtZTE3MzdfZGF0YSAqZGF0YSkKewoJaW50IGVyciA9IDAsIHJlZzsK
CXUxNiBhZGRyOwoKCWRtZTE3Mzdfc2lvX2VudGVyKHNpb19jaXApOwoKCS8qIENoZWNrIGRldmlj
ZSBJRAoJICogVGhlIERNRTE3MzcgY2FuIHJldHVybiBlaXRoZXIgMHg3OCBvciAweDc3IGFzIGl0
cyBkZXZpY2UgSUQuCgkgKiBUaGUgU0NINTAyNyByZXR1cm5zIDB4ODkgYXMgaXRzIGRldmljZSBJ
RC4gKi8KCXJlZyA9IGZvcmNlX2lkID8gZm9yY2VfaWQgOiBkbWUxNzM3X3Npb19pbmIoc2lvX2Np
cCwgMHgyMCk7CglpZiAoIShyZWcgPT0gMHg3NyB8fCByZWcgPT0gMHg3OCB8fCByZWcgPT0gMHg4
OSkpIHsKCQllcnIgPSAtRU5PREVWOwoJCWdvdG8gZXhpdDsKCX0KCgkvKiBTZWxlY3QgbG9naWNh
bCBkZXZpY2UgQSAocnVudGltZSByZWdpc3RlcnMpICovCglkbWUxNzM3X3Npb19vdXRiKHNpb19j
aXAsIDB4MDcsIDB4MGEpOwoKCS8qIEdldCB0aGUgYmFzZSBhZGRyZXNzIG9mIHRoZSBydW50aW1l
IHJlZ2lzdGVycyAqLwoJaWYgKCEoYWRkciA9IChkbWUxNzM3X3Npb19pbmIoc2lvX2NpcCwgMHg2
MCkgPDwgOCkgfAoJCSAgICAgIGRtZTE3Mzdfc2lvX2luYihzaW9fY2lwLCAweDYxKSkpIHsKCQll
cnIgPSAtRU5PREVWOwoJCWdvdG8gZXhpdDsKCX0KCgkvKiBSZWFkIHRoZSBydW50aW1lIHJlZ2lz
dGVycyB0byBkZXRlcm1pbmUgd2hpY2ggb3B0aW9uYWwgZmVhdHVyZXMKCSAqIGFyZSBlbmFibGVk
IGFuZCBhdmFpbGFibGUuIEJpdHMgWzM6Ml0gb2YgcmVnaXN0ZXJzIDB4NDMtMHg0NiBhcmUgc2V0
CgkgKiB0byAnMTAnIGlmIHRoZSByZXNwZWN0aXZlIGZlYXR1cmUgaXMgZW5hYmxlZC4gKi8KCWlm
ICgoaW5iKGFkZHIgKyAweDQzKSAmIDB4MGMpID09IDB4MDgpIHsgLyogZmFuNiAqLwoJCWRhdGEt
Pmhhc19mYW4gfD0gKDEgPDwgNSk7Cgl9CglpZiAoKGluYihhZGRyICsgMHg0NCkgJiAweDBjKSA9
PSAweDA4KSB7IC8qIHB3bTYgKi8KCQlkYXRhLT5oYXNfcHdtIHw9ICgxIDw8IDUpOwoJfQoJaWYg
KChpbmIoYWRkciArIDB4NDUpICYgMHgwYykgPT0gMHgwOCkgeyAvKiBmYW41ICovCgkJZGF0YS0+
aGFzX2ZhbiB8PSAoMSA8PCA0KTsKCX0KCWlmICgoaW5iKGFkZHIgKyAweDQ2KSAmIDB4MGMpID09
IDB4MDgpIHsgLyogcHdtNSAqLwoJCWRhdGEtPmhhc19wd20gfD0gKDEgPDwgNCk7Cgl9CgpleGl0
OgoJZG1lMTczN19zaW9fZXhpdChzaW9fY2lwKTsKCglyZXR1cm4gZXJyOwp9CgpzdGF0aWMgaW50
IGRtZTE3MzdfaTJjX2RldGVjdChzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmFkYXB0ZXIsIGludCBhZGRy
ZXNzLAoJCQkgICAgICBpbnQga2luZCkKewoJdTggY29tcGFueSwgdmVyc3RlcCA9IDA7CglzdHJ1
Y3QgaTJjX2NsaWVudCAqY2xpZW50OwoJc3RydWN0IGRtZTE3MzdfZGF0YSAqZGF0YTsKCXN0cnVj
dCBkZXZpY2UgKmRldjsKCWludCBlcnIgPSAwOwoJY29uc3QgY2hhciAqbmFtZTsKCglpZiAoIWky
Y19jaGVja19mdW5jdGlvbmFsaXR5KGFkYXB0ZXIsIEkyQ19GVU5DX1NNQlVTX0JZVEVfREFUQSkp
IHsKCQlnb3RvIGV4aXQ7Cgl9CgoJaWYgKCEoZGF0YSA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBk
bWUxNzM3X2RhdGEpLCBHRlBfS0VSTkVMKSkpIHsKCQllcnIgPSAtRU5PTUVNOwoJCWdvdG8gZXhp
dDsKCX0KCgljbGllbnQgPSAmZGF0YS0+Y2xpZW50OwoJaTJjX3NldF9jbGllbnRkYXRhKGNsaWVu
dCwgZGF0YSk7CgljbGllbnQtPmFkZHIgPSBhZGRyZXNzOwoJY2xpZW50LT5hZGFwdGVyID0gYWRh
cHRlcjsKCWNsaWVudC0+ZHJpdmVyID0gJmRtZTE3MzdfaTJjX2RyaXZlcjsKCWRldiA9ICZjbGll
bnQtPmRldjsKCgkvKiBBIG5lZ2F0aXZlIGtpbmQgbWVhbnMgdGhhdCB0aGUgZHJpdmVyIHdhcyBs
b2FkZWQgd2l0aCBubyBmb3JjZQoJICogcGFyYW1ldGVyIChkZWZhdWx0KSwgc28gd2UgbXVzdCBp
ZGVudGlmeSB0aGUgY2hpcC4gKi8KCWlmIChraW5kIDwgMCkgewoJCWNvbXBhbnkgPSBkbWUxNzM3
X3JlYWQoY2xpZW50LCBETUUxNzM3X1JFR19DT01QQU5ZKTsKCQl2ZXJzdGVwID0gZG1lMTczN19y
ZWFkKGNsaWVudCwgRE1FMTczN19SRUdfVkVSU1RFUCk7CgoJCWlmIChjb21wYW55ID09IERNRTE3
MzdfQ09NUEFOWV9TTVNDICYmCgkJICAgICh2ZXJzdGVwICYgRE1FMTczN19WRVJTVEVQX01BU0sp
ID09IERNRTE3MzdfVkVSU1RFUCkgewoJCQlraW5kID0gZG1lMTczNzsKCQl9IGVsc2UgaWYgKGNv
bXBhbnkgPT0gRE1FMTczN19DT01QQU5ZX1NNU0MgJiYKCQkJICAgdmVyc3RlcCA+PSBTQ0g1MDI3
X1ZFUlNURVBfTUlOICYmCgkJCSAgIHZlcnN0ZXAgPD0gU0NINTAyN19WRVJTVEVQX01BWCAmJgoJ
CQkgICAvKiBBbHNvIGNoZWNrIHRlc3QgcmVnaXN0ZXIgMHhiYSB0byBwcmV2ZW50IGZhbHNlCgkJ
CSAgICAqIHBvc2l0aXZlcyBmb3IgU01TQyBFTUM2RDEwM1MgY2hpcHMuICovCgkJCSAgIGRtZTE3
MzdfcmVhZChjbGllbnQsIDB4YmEpID09IDB4MGYpIHsKCQkJa2luZCA9IHNjaDUwMjc7CgkJfSBl
bHNlIHsKCQkJZXJyID0gLUVOT0RFVjsKCQkJZ290byBleGl0X2tmcmVlOwoJCX0KCX0KCglpZiAo
a2luZCA9PSBzY2g1MDI3KSB7CgkJbmFtZSA9ICJzY2g1MDI3IjsKCX0gZWxzZSB7CgkJbmFtZSA9
ICJkbWUxNzM3IjsKCX0KCWRhdGEtPnR5cGUgPSBraW5kOwoKCS8qIEZpbGwgaW4gdGhlIHJlbWFp
bmluZyBjbGllbnQgZmllbGRzIGFuZCBwdXQgaXQgaW50byB0aGUgZ2xvYmFsCgkgKiBsaXN0ICov
CglzdHJsY3B5KGNsaWVudC0+bmFtZSwgbmFtZSwgSTJDX05BTUVfU0laRSk7CgltdXRleF9pbml0
KCZkYXRhLT51cGRhdGVfbG9jayk7CgoJLyogVGVsbCB0aGUgSTJDIGxheWVyIGEgbmV3IGNsaWVu
dCBoYXMgYXJyaXZlZCAqLwoJaWYgKChlcnIgPSBpMmNfYXR0YWNoX2NsaWVudChjbGllbnQpKSkg
ewoJCWdvdG8gZXhpdF9rZnJlZTsKCX0KCglkZXZfaW5mbyhkZXYsICJGb3VuZCBhICVzIGNoaXAg
YXQgMHglMDJ4IChyZXYgMHglMDJ4KS5cbiIsCgkJIGtpbmQgPT0gc2NoNTAyNyA/ICJTQ0g1MDI3
IiA6ICJETUUxNzM3IiwgY2xpZW50LT5hZGRyLAoJCSB2ZXJzdGVwKTsKCgkvKiBJbml0aWFsaXpl
IHRoZSBETUUxNzM3IGNoaXAgKi8KCWlmICgoZXJyID0gZG1lMTczN19pbml0X2RldmljZShkZXYp
KSkgewoJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGluaXRpYWxpemUgZGV2aWNlLlxuIik7CgkJ
Z290byBleGl0X2RldGFjaDsKCX0KCgkvKiBDcmVhdGUgc3lzZnMgZmlsZXMgKi8KCWlmICgoZXJy
ID0gZG1lMTczN19jcmVhdGVfZmlsZXMoZGV2KSkpIHsKCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0
byBjcmVhdGUgc3lzZnMgZmlsZXMuXG4iKTsKCQlnb3RvIGV4aXRfZGV0YWNoOwoJfQoKCS8qIFJl
Z2lzdGVyIGRldmljZSAqLwoJZGF0YS0+aHdtb25fZGV2ID0gaHdtb25fZGV2aWNlX3JlZ2lzdGVy
KGRldik7CglpZiAoSVNfRVJSKGRhdGEtPmh3bW9uX2RldikpIHsKCQlkZXZfZXJyKGRldiwgIkZh
aWxlZCB0byByZWdpc3RlciBkZXZpY2UuXG4iKTsKCQllcnIgPSBQVFJfRVJSKGRhdGEtPmh3bW9u
X2Rldik7CgkJZ290byBleGl0X3JlbW92ZTsKCX0KCglyZXR1cm4gMDsKCmV4aXRfcmVtb3ZlOgoJ
ZG1lMTczN19yZW1vdmVfZmlsZXMoZGV2KTsKZXhpdF9kZXRhY2g6CglpMmNfZGV0YWNoX2NsaWVu
dChjbGllbnQpOwpleGl0X2tmcmVlOgoJa2ZyZWUoZGF0YSk7CmV4aXQ6CglyZXR1cm4gZXJyOwp9
CgpzdGF0aWMgaW50IGRtZTE3MzdfaTJjX2F0dGFjaF9hZGFwdGVyKHN0cnVjdCBpMmNfYWRhcHRl
ciAqYWRhcHRlcikKewoJaWYgKCEoYWRhcHRlci0+Y2xhc3MgJiBJMkNfQ0xBU1NfSFdNT04pKSB7
CgkJcmV0dXJuIDA7Cgl9CgoJcmV0dXJuIGkyY19wcm9iZShhZGFwdGVyLCAmYWRkcl9kYXRhLCBk
bWUxNzM3X2kyY19kZXRlY3QpOwp9CgpzdGF0aWMgaW50IGRtZTE3MzdfaTJjX2RldGFjaF9jbGll
bnQoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCkKewoJc3RydWN0IGRtZTE3MzdfZGF0YSAqZGF0
YSA9IGkyY19nZXRfY2xpZW50ZGF0YShjbGllbnQpOwoJaW50IGVycjsKCglod21vbl9kZXZpY2Vf
dW5yZWdpc3RlcihkYXRhLT5od21vbl9kZXYpOwoJZG1lMTczN19yZW1vdmVfZmlsZXMoJmNsaWVu
dC0+ZGV2KTsKCglpZiAoKGVyciA9IGkyY19kZXRhY2hfY2xpZW50KGNsaWVudCkpKSB7CgkJcmV0
dXJuIGVycjsKCX0KCglrZnJlZShkYXRhKTsKCXJldHVybiAwOwp9CgpzdGF0aWMgc3RydWN0IGky
Y19kcml2ZXIgZG1lMTczN19pMmNfZHJpdmVyID0gewoJLmRyaXZlciA9IHsKCQkubmFtZSA9ICJk
bWUxNzM3IiwKCX0sCgkuYXR0YWNoX2FkYXB0ZXIJPSBkbWUxNzM3X2kyY19hdHRhY2hfYWRhcHRl
ciwKCS5kZXRhY2hfY2xpZW50ID0gZG1lMTczN19pMmNfZGV0YWNoX2NsaWVudCwKfTsKCi8qIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQogKiBJU0EgZGV2aWNlIGRldGVjdGlvbiBhbmQgcmVnaXN0cmF0aW9uCiAqIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSAqLwoKc3RhdGljIGludCBfX2luaXQgZG1lMTczN19pc2FfZGV0ZWN0KGludCBz
aW9fY2lwLCB1bnNpZ25lZCBzaG9ydCAqYWRkcikKewoJaW50IGVyciA9IDAsIHJlZzsKCXVuc2ln
bmVkIHNob3J0IGJhc2VfYWRkcjsKCglkbWUxNzM3X3Npb19lbnRlcihzaW9fY2lwKTsKCgkvKiBD
aGVjayBkZXZpY2UgSUQKCSAqIFdlIGN1cnJlbnRseSBrbm93IGFib3V0IFNDSDMxMTIgKDB4N2Mp
LCBTQ0gzMTE0ICgweDdkKSwgYW5kCgkgKiBTQ0gzMTE2ICgweDdmKS4gKi8KCXJlZyA9IGZvcmNl
X2lkID8gZm9yY2VfaWQgOiBkbWUxNzM3X3Npb19pbmIoc2lvX2NpcCwgMHgyMCk7CglpZiAoIShy
ZWcgPT0gMHg3YyB8fCByZWcgPT0gMHg3ZCB8fCByZWcgPT0gMHg3ZikpIHsKCQllcnIgPSAtRU5P
REVWOwoJCWdvdG8gZXhpdDsKCX0KCgkvKiBTZWxlY3QgbG9naWNhbCBkZXZpY2UgQSAocnVudGlt
ZSByZWdpc3RlcnMpICovCglkbWUxNzM3X3Npb19vdXRiKHNpb19jaXAsIDB4MDcsIDB4MGEpOwoK
CS8qIEdldCB0aGUgYmFzZSBhZGRyZXNzIG9mIHRoZSBydW50aW1lIHJlZ2lzdGVycyAqLwoJaWYg
KCEoYmFzZV9hZGRyID0gKGRtZTE3Mzdfc2lvX2luYihzaW9fY2lwLCAweDYwKSA8PCA4KSB8CgkJ
CSAgIGRtZTE3Mzdfc2lvX2luYihzaW9fY2lwLCAweDYxKSkpIHsKCQlwcmludGsoS0VSTl9FUlIg
ImRtZTE3Mzc6IEJhc2UgYWRkcmVzcyBub3Qgc2V0LlxuIik7CgkJZXJyID0gLUVOT0RFVjsKCQln
b3RvIGV4aXQ7Cgl9CgoJLyogQWNjZXNzIHRvIHRoZSBod21vbiByZWdpc3RlcnMgaXMgdGhyb3Vn
aCBhbiBpbmRleC9kYXRhIHJlZ2lzdGVyCgkgKiBwYWlyIGxvY2F0ZWQgYXQgb2Zmc2V0IDB4NzAv
MHg3MS4gKi8KCSphZGRyID0gYmFzZV9hZGRyICsgMHg3MDsKCmV4aXQ6CglkbWUxNzM3X3Npb19l
eGl0KHNpb19jaXApOwoJcmV0dXJuIGVycjsKfQoKc3RhdGljIGludCBfX2luaXQgZG1lMTczN19p
c2FfZGV2aWNlX2FkZCh1bnNpZ25lZCBzaG9ydCBhZGRyKQp7CglzdHJ1Y3QgcmVzb3VyY2UgcmVz
ID0gewoJCS5zdGFydAk9IGFkZHIsCgkJLmVuZAk9IGFkZHIgKyBETUUxNzM3X0VYVEVOVCAtIDEs
CgkJLm5hbWUJPSAiZG1lMTczNyIsCgkJLmZsYWdzCT0gSU9SRVNPVVJDRV9JTywKCX07CglpbnQg
ZXJyOwoKCWlmICghKHBkZXYgPSBwbGF0Zm9ybV9kZXZpY2VfYWxsb2MoImRtZTE3MzciLCBhZGRy
KSkpIHsKCQlwcmludGsoS0VSTl9FUlIgImRtZTE3Mzc6IEZhaWxlZCB0byBhbGxvY2F0ZSBkZXZp
Y2UuXG4iKTsKCQllcnIgPSAtRU5PTUVNOwoJCWdvdG8gZXhpdDsKCX0KCglpZiAoKGVyciA9IHBs
YXRmb3JtX2RldmljZV9hZGRfcmVzb3VyY2VzKHBkZXYsICZyZXMsIDEpKSkgewoJCXByaW50ayhL
RVJOX0VSUiAiZG1lMTczNzogRmFpbGVkIHRvIGFkZCBkZXZpY2UgcmVzb3VyY2UgIgoJCSAgICAg
ICAiKGVyciA9ICVkKS5cbiIsIGVycik7CgkJZ290byBleGl0X2RldmljZV9wdXQ7Cgl9CgoJaWYg
KChlcnIgPSBwbGF0Zm9ybV9kZXZpY2VfYWRkKHBkZXYpKSkgewoJCXByaW50ayhLRVJOX0VSUiAi
ZG1lMTczNzogRmFpbGVkIHRvIGFkZCBkZXZpY2UgKGVyciA9ICVkKS5cbiIsCgkJICAgICAgIGVy
cik7CgkJZ290byBleGl0X2RldmljZV9wdXQ7Cgl9CgoJcmV0dXJuIDA7CgpleGl0X2RldmljZV9w
dXQ6CglwbGF0Zm9ybV9kZXZpY2VfcHV0KHBkZXYpOwoJcGRldiA9IE5VTEw7CmV4aXQ6CglyZXR1
cm4gZXJyOwp9CgpzdGF0aWMgaW50IF9fZGV2aW5pdCBkbWUxNzM3X2lzYV9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQp7Cgl1OCBjb21wYW55LCBkZXZpY2U7CglzdHJ1Y3QgcmVz
b3VyY2UgKnJlczsKCXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQ7CglzdHJ1Y3QgZG1lMTczN19k
YXRhICpkYXRhOwoJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsKCWludCBlcnI7CgoJ
cmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfSU8sIDApOwoJaWYg
KCFyZXF1ZXN0X3JlZ2lvbihyZXMtPnN0YXJ0LCBETUUxNzM3X0VYVEVOVCwgImRtZTE3MzciKSkg
ewoJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIHJlcXVlc3QgcmVnaW9uIDB4JTA0eC0weCUwNHgu
XG4iLAoJCQkodW5zaWduZWQgc2hvcnQpcmVzLT5zdGFydCwKCQkJKHVuc2lnbmVkIHNob3J0KXJl
cy0+c3RhcnQgKyBETUUxNzM3X0VYVEVOVCAtIDEpOwogICAgICAgICAgICAgICAgZXJyID0gLUVC
VVNZOwogICAgICAgICAgICAgICAgZ290byBleGl0OwogICAgICAgIH0KCglpZiAoIShkYXRhID0g
a3phbGxvYyhzaXplb2Yoc3RydWN0IGRtZTE3MzdfZGF0YSksIEdGUF9LRVJORUwpKSkgewoJCWVy
ciA9IC1FTk9NRU07CgkJZ290byBleGl0X3JlbGVhc2VfcmVnaW9uOwoJfQoKCWNsaWVudCA9ICZk
YXRhLT5jbGllbnQ7CglpMmNfc2V0X2NsaWVudGRhdGEoY2xpZW50LCBkYXRhKTsKCWNsaWVudC0+
YWRkciA9IHJlcy0+c3RhcnQ7CglwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBkYXRhKTsKCglj
b21wYW55ID0gZG1lMTczN19yZWFkKGNsaWVudCwgRE1FMTczN19SRUdfQ09NUEFOWSk7CglkZXZp
Y2UgPSBkbWUxNzM3X3JlYWQoY2xpZW50LCBETUUxNzM3X1JFR19ERVZJQ0UpOwoKCWlmICghKChj
b21wYW55ID09IERNRTE3MzdfQ09NUEFOWV9TTVNDKSAmJgoJICAgICAgKGRldmljZSA9PSBTQ0gz
MTFYX0RFVklDRSkpKSB7CgkJZXJyID0gLUVOT0RFVjsKCQlnb3RvIGV4aXRfa2ZyZWU7Cgl9Cglk
YXRhLT50eXBlID0gc2NoMzExeDsKCgkvKiBGaWxsIGluIHRoZSByZW1haW5pbmcgY2xpZW50IGZp
ZWxkcyBhbmQgaW5pdGlhbGl6ZSB0aGUgbXV0ZXggKi8KCXN0cmxjcHkoY2xpZW50LT5uYW1lLCAi
c2NoMzExeCIsIEkyQ19OQU1FX1NJWkUpOwoJbXV0ZXhfaW5pdCgmZGF0YS0+dXBkYXRlX2xvY2sp
OwoKCWRldl9pbmZvKGRldiwgIkZvdW5kIGEgU0NIMzExeCBjaGlwIGF0IDB4JTA0eFxuIiwgY2xp
ZW50LT5hZGRyKTsKCgkvKiBJbml0aWFsaXplIHRoZSBjaGlwICovCglpZiAoKGVyciA9IGRtZTE3
MzdfaW5pdF9kZXZpY2UoZGV2KSkpIHsKCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBpbml0aWFs
aXplIGRldmljZS5cbiIpOwoJCWdvdG8gZXhpdF9rZnJlZTsKCX0KCgkvKiBDcmVhdGUgc3lzZnMg
ZmlsZXMgKi8KCWlmICgoZXJyID0gZG1lMTczN19jcmVhdGVfZmlsZXMoZGV2KSkpIHsKCQlkZXZf
ZXJyKGRldiwgIkZhaWxlZCB0byBjcmVhdGUgc3lzZnMgZmlsZXMuXG4iKTsKCQlnb3RvIGV4aXRf
a2ZyZWU7Cgl9CgoJLyogUmVnaXN0ZXIgZGV2aWNlICovCglkYXRhLT5od21vbl9kZXYgPSBod21v
bl9kZXZpY2VfcmVnaXN0ZXIoZGV2KTsKCWlmIChJU19FUlIoZGF0YS0+aHdtb25fZGV2KSkgewoJ
CWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIHJlZ2lzdGVyIGRldmljZS5cbiIpOwoJCWVyciA9IFBU
Ul9FUlIoZGF0YS0+aHdtb25fZGV2KTsKCQlnb3RvIGV4aXRfcmVtb3ZlX2ZpbGVzOwoJfQoKCXJl
dHVybiAwOwoKZXhpdF9yZW1vdmVfZmlsZXM6CglkbWUxNzM3X3JlbW92ZV9maWxlcyhkZXYpOwpl
eGl0X2tmcmVlOgoJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgTlVMTCk7CglrZnJlZShkYXRh
KTsKZXhpdF9yZWxlYXNlX3JlZ2lvbjoKCXJlbGVhc2VfcmVnaW9uKHJlcy0+c3RhcnQsIERNRTE3
MzdfRVhURU5UKTsKZXhpdDoKCXJldHVybiBlcnI7Cn0KCnN0YXRpYyBpbnQgX19kZXZleGl0IGRt
ZTE3MzdfaXNhX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQp7CglzdHJ1Y3Qg
ZG1lMTczN19kYXRhICpkYXRhID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7CgoJaHdtb25f
ZGV2aWNlX3VucmVnaXN0ZXIoZGF0YS0+aHdtb25fZGV2KTsKCWRtZTE3MzdfcmVtb3ZlX2ZpbGVz
KCZwZGV2LT5kZXYpOwoJcmVsZWFzZV9yZWdpb24oZGF0YS0+Y2xpZW50LmFkZHIsIERNRTE3Mzdf
RVhURU5UKTsKCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIE5VTEwpOwoJa2ZyZWUoZGF0YSk7
CgoJcmV0dXJuIDA7Cn0KCnN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGRtZTE3MzdfaXNh
X2RyaXZlciA9IHsKCS5kcml2ZXIgPSB7CgkJLm93bmVyID0gVEhJU19NT0RVTEUsCgkJLm5hbWUg
PSAiZG1lMTczNyIsCgl9LAoJLnByb2JlID0gZG1lMTczN19pc2FfcHJvYmUsCgkucmVtb3ZlID0g
X19kZXZleGl0X3AoZG1lMTczN19pc2FfcmVtb3ZlKSwKfTsKCi8qIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogKiBN
b2R1bGUgaW5pdGlhbGl6YXRpb24gYW5kIGNsZWFudXAKICogLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICovCgpzdGF0
aWMgaW50IF9faW5pdCBkbWUxNzM3X2luaXQodm9pZCkKewoJaW50IGVycjsKCXVuc2lnbmVkIHNo
b3J0IGFkZHI7CgoJaWYgKChlcnIgPSBpMmNfYWRkX2RyaXZlcigmZG1lMTczN19pMmNfZHJpdmVy
KSkpIHsKCQlnb3RvIGV4aXQ7Cgl9CgoJaWYgKGRtZTE3MzdfaXNhX2RldGVjdCgweDJlLCAmYWRk
cikgJiYKCSAgICBkbWUxNzM3X2lzYV9kZXRlY3QoMHg0ZSwgJmFkZHIpKSB7CgkJLyogUmV0dXJu
IDAgaWYgd2UgZGlkbid0IGZpbmQgYW4gSVNBIGRldmljZSAqLwoJCXJldHVybiAwOwoJfQoKCWlm
ICgoZXJyID0gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZkbWUxNzM3X2lzYV9kcml2ZXIpKSkg
ewoJCWdvdG8gZXhpdF9kZWxfaTJjX2RyaXZlcjsKCX0KCgkvKiBTZXRzIGdsb2JhbCBwZGV2IGFz
IGEgc2lkZSBlZmZlY3QgKi8KCWlmICgoZXJyID0gZG1lMTczN19pc2FfZGV2aWNlX2FkZChhZGRy
KSkpIHsKCQlnb3RvIGV4aXRfZGVsX2lzYV9kcml2ZXI7Cgl9CgoJcmV0dXJuIDA7CgpleGl0X2Rl
bF9pc2FfZHJpdmVyOgoJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJmRtZTE3MzdfaXNhX2Ry
aXZlcik7CmV4aXRfZGVsX2kyY19kcml2ZXI6CglpMmNfZGVsX2RyaXZlcigmZG1lMTczN19pMmNf
ZHJpdmVyKTsKZXhpdDoKCXJldHVybiBlcnI7Cn0KCnN0YXRpYyB2b2lkIF9fZXhpdCBkbWUxNzM3
X2V4aXQodm9pZCkKewoJaWYgKHBkZXYpIHsKCQlwbGF0Zm9ybV9kZXZpY2VfdW5yZWdpc3Rlcihw
ZGV2KTsKCQlwbGF0Zm9ybV9kcml2ZXJfdW5yZWdpc3RlcigmZG1lMTczN19pc2FfZHJpdmVyKTsK
CX0KCglpMmNfZGVsX2RyaXZlcigmZG1lMTczN19pMmNfZHJpdmVyKTsKfQoKTU9EVUxFX0FVVEhP
UigiSnVlcmcgSGFlZmxpZ2VyIDxqdWVyZ2hAZ21haWwuY29tPiIpOwpNT0RVTEVfREVTQ1JJUFRJ
T04oIkRNRTE3Mzcgc2Vuc29ycyIpOwpNT0RVTEVfTElDRU5TRSgiR1BMIik7Cgptb2R1bGVfaW5p
dChkbWUxNzM3X2luaXQpOwptb2R1bGVfZXhpdChkbWUxNzM3X2V4aXQpOwo=
------=_Part_6770_22556584.1202196709342
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_Part_6770_22556584.1202196709342--
