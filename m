From: Volker Braun <vbraun.name@gmail.com>
Date: Sat, 06 Sep 2014 14:04:32 +0000
Subject: [lm-sensors] Asus X99 Deluxe sensors
Message-Id: <loom.20140906T155415-367@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The board seems to have a known sensor chip:

Found `Nuvoton NCT6791D Super IO Sensors'                   Success!
    (address 0x290, driver `nct6775')

But when loading it, the kernel complains:

Sep 06 14:32:01 localhost.localdomain kernel: nct6775: Found NCT6791D or 
compatible chip at 0x2e:0x290
Sep 06 14:32:01 localhost.localdomain kernel: ACPI Warning: SystemIO range 
0x0000000000000295-0x0000000000000296 conflicts with OpRegion 
0x0000000000000290-0x0000000000000299 (\_GPE.HWM_) (20140214/utaddress-258)

I read the FAQ about the asus_atk0110 module, but that is nowhere to be seen 
in the DSDT. So I guess Asus discontinued that in their new motherboards. I 
understand that ACPI references 0x295, but I don't understand what it does 
with it (if anything at all): 

http://boxen.math.washington.edu/home/vbraun/ASUS_X99_DELUXE_BIOS_0801/dsdt.
dsl

    Name (IOHW, 0x0290)
    [...]
    OperationRegion (HWM, SystemIO, IOHW, 0x0A)
    Field (HWM, ByteAcc, NoLock, Preserve)
    {
        Offset (0x05), 
        HIDX,   8, 
        HDAT,   8
    }

Full acpi data: 
http://boxen.math.washington.edu/home/vbraun/ASUS_X99_DELUXE_BIOS_0801/


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
