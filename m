From: zdavatz@ywesee.com (Zeno Davatz)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Why this output?
Message-Id: <B9F92C49.4411%zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi List

I do sensors-detect and get:

System vendor: System Manufacturer
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:04.3: Intel 82371AB PIIX4 ACPI
Use driver `i2c-voodoo3' for device 01:00.0: 3Dfx Voodoo3
Probe succesfully concluded.

Then I continue with YES and get:

We will now try to load each adapter module in turn.
Load `i2c-piix4' (say NO if built into your kernel)? (YES/no):
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/dmi_scan.o: unresolved symbol
iounmap_Rsmp_5fb196d4
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/dmi_scan.o: unresolved symbol
__ioremap_Rsmp_9eac042a
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/dmi_scan.o: unresolved symbol
printk_Rsmp_1b7d4074
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/dmi_scan.o: unresolved symbol
kmalloc_Rsmp_93d4cfe6
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/dmi_scan.o: insmod
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/dmi_scan.o failed
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/dmi_scan.o: insmod i2c-piix4
failed
Loading failed ()... skipping.
Load `i2c-voodoo3' (say NO if built into your kernel)? (YES/no):
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/i2c-algo-bit.o: unresolved
symbol i2c_add_adapter_Rsmp_33b75073
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/i2c-algo-bit.o: unresolved
symbol printk_Rsmp_1b7d4074
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/i2c-algo-bit.o: unresolved
symbol schedule_Rsmp_4292364c
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/i2c-algo-bit.o: unresolved
symbol __const_udelay_Rsmp_eae3dfd6
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/i2c-algo-bit.o: unresolved
symbol __udelay_Rsmp_9e7d6bd0
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/i2c-algo-bit.o: unresolved
symbol jiffies_Rsmp_0da02d67
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/i2c-algo-bit.o: unresolved
symbol i2c_del_adapter_Rsmp_5babfe4d
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/i2c-algo-bit.o: insmod
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/i2c-algo-bit.o failed
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/i2c-algo-bit.o: insmod
i2c-voodoo3 failed
Loading failed ()... skipping.

Any idea what this onresolved symbol is doing?

Thanks for any help and hints.

Zeno
