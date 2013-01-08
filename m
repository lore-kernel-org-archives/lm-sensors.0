From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 08 Jan 2013 13:50:39 +0000
Subject: Re: [lm-sensors] Help to make lm-sensors work with an Asus TUSL2-C
Message-Id: <20130108145039.17abf535@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <50DB2017.8010403@tiscali.it>
In-Reply-To: <50DB2017.8010403@tiscali.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 08 Jan 2013 14:34:55 +0100, Mauro Molinari wrote:
> Some progress is made compared to the version I have in my Linux 
> distribution, because the latest script says:
> 
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
> Found unknown chip with ID 0x5953
>      (logical device 9 has address 0x290, could be sensors)

Very strange, I wouldn't expected an unknown Super-I/O chip on such an
old board. Can you find the chip's name by visual inspection of the
board or from the documentation?

> However, later it still says:
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> 
> And finally again:
> Sorry, no sensors were detected.
> 
> So, it seems like something is present at 0x290, but nothing lm-sensors 
> can detect. The strange thing is that from what I read on the Internet 
> (as stated in my previous mail message), my mainboard (Asus TUSL2-C) 
> should actually have a AS99127F chip, supported by the w83781d driver.
> 
> Please note I have the following warning message at boot:
> [   10.092229] i801_smbus 0000:00:1f.3: PCI INT B -> GSI 17 (level, low) 
> -> IRQ 17
> [   10.092243] ACPI: I/O resource 0000:00:1f.3 [0xe800-0xe80f] conflicts 
> with ACPI region SM00 [0xe800-0xe806]
> [   10.092291] ACPI: If an ACPI driver is available for this device, you 
> should use it instead of the native driver
> 
> However I did some research on the Internet and found out that this 
> should not be a problem and simply means that the native driver is not 
> used, because an AHCI interface to the i801 SMBus device is available. 
> Actually, the sensors-detect correctly queries that device:
> Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801BA ICH2
> but it still doesn't find any sensor there, however I don't think this 
> is in any way related to my problem.

The above message means that sensors-detect knows which driver should
be used for the ICH2 SMBus. That doesn't mean the driver did
successfully bind to the device. And if device binding failed (as the
log messages pasted above suggest) then scanning isn't possible.

The AS99127F is an SMBus chip. Please boot with
acpi_enforce_resources=lax and run sensors-detect again, it should find
your AS99127F chip then.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
