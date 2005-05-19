From: anton@korzh.ru (Anton A. Korzh)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: i2c-core on 2.6.0-test10
Message-Id: <1070016124.1761.15.camel@phoebus>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069707536.1010.8.camel@phoebus>
In-Reply-To: <1069707536.1010.8.camel@phoebus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

? ???, 27.11.2003, ? 21:57, Jean Delvare ?????:
> > I use newwest 2.6 test10 kernel, i have MB based on Apollo 133
> > chipset,
> > 
> >  i compiled into kernel i2c support, i2c algobit, viapro,
> >  i2c_isa,via686a,eeprom.
> 
> You probably don't need i2c-algo-bit, but you could compile w83781d in.
> I have a board with a KT133 and the via868a chip is not used, instead
> there is an as99127f (this is an Asus board) which is handled by the
> w83781d driver.
> 
> > Also i downloaded 21th november cvs lm_sensors2 and compiled user
> > tools only
> 
> I invite you to update. Significant changes have been made, that could
> solve your problems.

Ok, thanks for advice. I've updated just now (28.11.03) lm_sensors2 from cvs, also i upgraded to latest 2.6.0.-test11.
 
i compiled into kernel i2c-dev, i2c-isa,i2c-viapro and all the sensors. Also i have mounted sysfs into /sys and devfs into /devfs.

My mb is Elitegroup P6VEM.


sensors gives me segfault:

[root@pueblo linux]# sensors
eeprom-i2c-1-52
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Unavailable from sysfs
ERROR: data 1
 
eeprom-i2c-1-51
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Unavailable from sysfs
ERROR: data 1
 
Segmentation fault

sensors-detect now runs ok(earlier it said that i dont have /proc/bus/i2c??? while i got 2.6, but now it seems to be fixed)

 System vendor (DMI): VIA Technologies, Inc.
 BIOS version (DMI): 6.00 PG
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:07.4: VIA Technologies VT82C686 Apollo ACPI
Probe succesfully concluded.

Next adapter: SMBus Via Pro adapter at 5000 (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x2d
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `National Semiconductor LM85'... Failed!
Probing for `Analog Devices ADM1027 or ADT7463'... Failed!
Probing for `SMSC EMC6D100 and EMC6D101'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Genesys Logic GL525SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Philips NE1619'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `Analog Devices ADM1030'... Failed!
Probing for `Analog Devices ADM1031'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x32
Client at address 0x51 can not be probed - unload all client drivers first!
Client at address 0x52 can not be probed - unload all client drivers first!
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
  Trying general detect... Success!
    (confidence 9, driver `via686a')
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

What do you think i am doing incorrectly? Do i really need lm80 module(there is no lm80 in 2.6)

thanks, Anton.

> > The problem is that sensors dont see any sensors on isa
> > bus. As i remeber (and as sensors-detect writes) i need i2c_core to
> > maitain /proc/bus/i2c??? but there are no such directories... 
> 
> /proc is for 2.4 kernels. In 2.6 we use sysfs, usually under /sys.
> Make sure you have sysfs support enabled and /sys mounted, and with
> up-to-date tools you should get your values back.
