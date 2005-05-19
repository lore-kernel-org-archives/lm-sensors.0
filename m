From: toth_andras@chello.hu (=?ISO-8859-1?Q?T=F3th_Andr=E1s?=)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: #1353 still error!!
Message-Id: <3F294CF5.7090508@chello.hu>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F28DE38.70801@chello.hu>
In-Reply-To: <3F28DE38.70801@chello.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>
>
>With a bit of luck, you don't need the dmi_scan module. Try to remove it
>from the compilation process. Edit kernel/busses/Module.mk. Comment out
>the following line:
>
>KERNELBUSSESTARGETS += $(MODULE_DIR)/dmi_scan.o
>
>becomes:
>
>#KERNELBUSSESTARGETS += $(MODULE_DIR)/dmi_scan.o
>
>And try again. I don't pretend it is a very nice fix, but if it's OK for
>you... And if it still fails, at least we will have another information,
>this may help.
>

Thanks, very nice, it works at last! No errors at the dmi_scan modules 
now. Then I've run make install so it's completed now, thank you!

I've tried sensors-detect but it can't recognize my stupid Asus TUSL2-C 
mainboard's sensors. Sorry, but I really don't understand this thing... 
Can you please help me in this?


Thank you for your lot kind help!
Best regards,
Toth Andras


Here is the whole output of sensors-detect:

--
BIOS vendor (ACPI): ASUS
System vendor (DMI): System Manufacturer
BIOS version (DMI): ASUS TUSL2-C ACPI BIOS Revision 1012
We can start with probing for (PCI) I2C or SMBus adapters.
You do not need any special privileges for this.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801BA ICH2
Use driver `<DISABLED>' for device 01:00.0: GeForce2 MX2
Probe succesfully concluded.
We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
/lib/modules/2.4.18-4GB/kernel/drivers/i2c/busses/i2c-i801.o: 
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, 
including invalid IO or IRQ parameters
/lib/modules/2.4.18-4GB/kernel/drivers/i2c/busses/i2c-i801.o: insmod 
/lib/modules/2.4.18-4GB/kernel/drivers/i2c/busses/i2c-i801.o failed
/lib/modules/2.4.18-4GB/kernel/drivers/i2c/busses/i2c-i801.o: insmod 
i2c-i801 failed
Loading failed... skipping.
Do you now want to be prompted for non-detectable adapters? (yes/NO):
To continue, we need module `i2c-dev' to be loaded.
If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

We are now going to do the adapter probings. Some adapters may hang halfway
through; we can't really help that. Also, some chips will be double 
detected;
we choose the one with the highest confidence value in that case.
If you found that the adapter hung after probing a certain address, you can
specify that address to remain unprobed. That often
includes address 0x69 (clock chip).

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. Do you want to scan the ISA bus? (YES/no):
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
Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. Do you want to scan for Super I/O sensors? (YES/no):
Probing for `SMSC 47M1xx Super IO Fan Sensors'
Failed! (0x00)
Probing for `VT1211 Super IO Sensors'
Failed! (0x59)
Probing for `Winbond W83627HF Super IO Sensors'
Failed! (0x59)
Probing for `Winbond W83627THF Super IO Sensors'
Failed! (0x59)
Probing for `Winbond W83697HF Super IO Sensors'
Failed! (0x59)

Sorry, no chips were detected.
--

