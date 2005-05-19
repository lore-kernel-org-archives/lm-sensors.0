From: armenb@cs.umass.edu (Armen Babikyan)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: Hardware sensors problem with 2.4.21 on IBM eServer 335/345
Message-Id: <9BC242DA-65D6-11D9-9300-003065F94C4C@cs.umass.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I am trying to get hardware sensors (i.e. cpu temp, fan speed, and 
voltage sensors) working on an IBM eServer 335 system that is running 
RedHat (Enterprise edition) with kernel 2.4.21 (2.4.21-27 actually - it 
has lm sensors 2.6.5).

The driver for the sensors chip on this particular mainboard is found 
using sensors-detect:

Use driver `i2c-piix4' for device 00:0f.0: ServerWorks CSB5 South Bridge

However, the driver failed to load with the following error:

i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-piix4.o version 2.6.5 (20020915)
i2c-piix4.o: Found CSB5 device
dmi_scan.o version 2.6.5 (20020915)
dmi_scan.o: SM BIOS found
i2c-piix4.o: IBM Laptop detected; this module may corrupt
              your serial eeprom! Refusing to load module!
i2c-piix4.o: Module insertion failed.

Obviously this machine is not an IBM Laptop!  It is, in fact, a 
rackmount server.  My question is: is this machine still at risk of 
this EEPROM corruption bug that is present in (what looks like 
exclusively) certain models of IBM Thinkpads?  I can easily comment out 
this logic and recompile, but I really don't want to break my EEPROM!  
Can anyone tell me with reasonable certainty that I won't break my 
machine by forcibly installing this module?  It looks like the new lm 
sensors logic (like before) just doesn't like this machine because the 
DMI vendor is IBM and the PCI Vendor ID is Intel:

if(dmi_ident[DMI_SYS_VENDOR] != NULL
         && strncmp(dmi_ident[DMI_SYS_VENDOR], "IBM", 3) = 0)
                 is_unsafe_smbus = 1;

together with:

if(ibm_dmi_probe() && PIIX4_dev->vendor = PCI_VENDOR_ID_INTEL)

I'd upgrade to a newer version of the linux kernel (with a newer 
version of i2c), but other users of the machine have requested the 
kernel version be kept for support reasons, if at all possible.  RedHat 
doesn't support the i2c-piix4.o module.

Any and all insight is greatly appreciated!

Thanks!

   - Armen
