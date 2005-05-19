From: contact@haloscan.com (Jeevan)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: Sis 645DX problem
Message-Id: <200303161357.19874.contact@haloscan.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm running lm_sensors version 2.7.0 in Gentoo linux with kernel version 
2.4.20-gentoo-r1.

sensors-detect detects that I have the SIS645DX (which is correct--I have a 
sis645DX chip on an ASUS P4S533-E motherboard) but it fails to load the 
module. Here is the output from running sensors-detect:

---
root@halo halo # sensors-detect
<Startup info truncated>

 BIOS vendor (ACPI): ASUS
 System vendor (DMI): System Manufacturer
 BIOS version (DMI): ASUS P4S533-E ACPI BIOS Revision 1007
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-sis645' for device 00:00.0: Silicon Integrated Systems 
SIS645DX
Use driver `i2c-riva' for device 01:00.0: GeForce2 MX
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-sis645' (say NO if built into your kernel)? (YES/no):
/lib/modules/2.4.20-gentoo-r1/misc/i2c-sis645.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including 
invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.20-gentoo-r1/misc/i2c-sis645.o: insmod 
/lib/modules/2.4.20-gentoo-r1/misc/i2c-sis645.o failed
/lib/modules/2.4.20-gentoo-r1/misc/i2c-sis645.o: insmod i2c-sis645 failed
Loading failed... skipping.
---

This is the output from dmesg:
i2c-sis645.o: version 2.7.0 (20021208)
i2c-sis645.o: Error: Can't find suitable south bridge!
i2c-sis645.o: SiS645 not detected, module not inserted.

Any help would be greatly appreciated. Please email me if you need more 
information too.

Thanks.
-- 
-Jeevan
 haloscan@bellsouth.net
