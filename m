From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 06 Sep 2014 15:24:59 +0000
Subject: Re: [lm-sensors] Asus X99 Deluxe sensors
Message-Id: <540B274B.8000704@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20140906T155415-367@post.gmane.org>
In-Reply-To: <loom.20140906T155415-367@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 09/06/2014 07:04 AM, Volker Braun wrote:
> The board seems to have a known sensor chip:
>
> Found `Nuvoton NCT6791D Super IO Sensors'                   Success!
>      (address 0x290, driver `nct6775')
>
> But when loading it, the kernel complains:
>
> Sep 06 14:32:01 localhost.localdomain kernel: nct6775: Found NCT6791D or
> compatible chip at 0x2e:0x290
> Sep 06 14:32:01 localhost.localdomain kernel: ACPI Warning: SystemIO range
> 0x0000000000000295-0x0000000000000296 conflicts with OpRegion
> 0x0000000000000290-0x0000000000000299 (\_GPE.HWM_) (20140214/utaddress-258)
>
> I read the FAQ about the asus_atk0110 module, but that is nowhere to be seen
> in the DSDT. So I guess Asus discontinued that in their new motherboards. I
> understand that ACPI references 0x295, but I don't understand what it does
> with it (if anything at all):
>
> http://boxen.math.washington.edu/home/vbraun/ASUS_X99_DELUXE_BIOS_0801/dsdt.
> dsl
>
>      Name (IOHW, 0x0290)
>      [...]
>      OperationRegion (HWM, SystemIO, IOHW, 0x0A)
>      Field (HWM, ByteAcc, NoLock, Preserve)
>      {
>          Offset (0x05),
>          HIDX,   8,
>          HDAT,   8
>      }
>
> Full acpi data:
> http://boxen.math.washington.edu/home/vbraun/ASUS_X99_DELUXE_BIOS_0801/
>

Maybe it is a leftover, but there is nothing we can do about it.
You could ask Asus, but unless they changed their policy they'll
tell you that they do not support Linux on their desktop boards.

You can try to boot with acpi_enforce_resources=lax on your own risk.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
