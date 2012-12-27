From: Mauro Molinari <mauromol@tiscali.it>
Date: Thu, 27 Dec 2012 11:29:08 +0000
Subject: Re: [lm-sensors] Help to make lm-sensors work with an Asus TUSL2-C
Message-Id: <50DC3104.3040608@tiscali.it>
List-Id: <lm-sensors.vger.kernel.org>
References: <50DB2017.8010403@tiscali.it>
In-Reply-To: <50DB2017.8010403@tiscali.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Il 26/12/2012 21:11, Andrey Repin ha scritto:
>> I'm writing because I need help to configure lm-sensors to work on an
>> old Asus TUSL2-C motherboard. I read a lot of documentation on
>> lm-sensors website and wiki and I did some searches with Google, however
>> I can't understand what I'm doing wrong.
>
> Have you tried downloading newer sensors-detect script from the website?

Hi Andrey, thanks for your help!
I just downloaded the latest version of sensors-detect from here:
http://www.lm-sensors.org/wiki/iwizard/NoSensorsDetected

Some progress is made compared to the version I have in my Linux 
distribution, because the latest script says:

Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found unknown chip with ID 0x5953
     (logical device 9 has address 0x290, could be sensors)

However, later it still says:
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

And finally again:
Sorry, no sensors were detected.

So, it seems like something is present at 0x290, but nothing lm-sensors 
can detect. The strange thing is that from what I read on the Internet 
(as stated in my previous mail message), my mainboard (Asus TUSL2-C) 
should actually have a AS99127F chip, supported by the w83781d driver.

Please note I have the following warning message at boot:
[   10.092229] i801_smbus 0000:00:1f.3: PCI INT B -> GSI 17 (level, low) 
-> IRQ 17
[   10.092243] ACPI: I/O resource 0000:00:1f.3 [0xe800-0xe80f] conflicts 
with ACPI region SM00 [0xe800-0xe806]
[   10.092291] ACPI: If an ACPI driver is available for this device, you 
should use it instead of the native driver

However I did some research on the Internet and found out that this 
should not be a problem and simply means that the native driver is not 
used, because an AHCI interface to the i801 SMBus device is available. 
Actually, the sensors-detect correctly queries that device:
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801BA ICH2
but it still doesn't find any sensor there, however I don't think this 
is in any way related to my problem.

Any suggestion?

Mauro

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
