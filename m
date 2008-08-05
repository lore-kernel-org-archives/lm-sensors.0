From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 05 Aug 2008 00:18:48 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] abituguru3: Prefer DMI probing to
Message-Id: <20080804171848.71bc8214.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1217614619-29688-3-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1217614619-29688-3-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri,  1 Aug 2008 19:16:59 +0100 Alistair John Strachan <alistair@devzero.co.uk> wrote:

> Previously the driver was only using DMI to prevent smbus probing on
> non-Abit motherboards. However, since the manual probing method is
> brittle and prone to failure on some Abit motherboards (esp. the
> Abit IP35 Pro) it is better to use DMI to also read the board name
> and then decide whether or not to probe the bus.
>     
> At the moment, we do not have a list of valid DMI name strings to use
> for existing and supported motherboards. This patch only implements
> DMI probing for the IP35 Pro. For motherboards that can not yet use
> DMI probing, a warning will be printed to the kernel log asking those
> users to email me their dmidecode output.
>     
> The existing manual probing mechanism will be used if CONFIG_DMI is
> not enabled, if DMI probing fails (for DMI-unsupported motherboards),
> or if DMI probing fails and the "force" option is set (for
> DMI-supported motherboards). Ideally in the longer term this manual
> probing method would be removed.
>     
> This patch should be safe to apply as it does not change the probing
> behaviour for most of the supported motherboards, just the IP35 Pro,
> which already has regressions filed against it in 2.6.26.

This conflicts with your earlier
hwmon-fix-loading-of-abituguru3-on-abit-ip35-pro-with-bios-17.patch.  I
reworked
hwmon-fix-loading-of-abituguru3-on-abit-ip35-pro-with-bios-17.patch so
that it applies on top of these two later patches.

Please confirm that
hwmon-fix-loading-of-abituguru3-on-abit-ip35-pro-with-bios-17.patch is
still needed.



From: Alistair John Strachan <alistair@devzero.co.uk>

Fix loading of abituguru3 on Abit IP35 Pro with BIOS 17.  The magic
bytes have changed value (again).

Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/hwmon/abituguru3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/hwmon/abituguru3.c~hwmon-fix-loading-of-abituguru3-on-abit-ip35-pro-with-bios-17 drivers/hwmon/abituguru3.c
--- a/drivers/hwmon/abituguru3.c~hwmon-fix-loading-of-abituguru3-on-abit-ip35-pro-with-bios-17
+++ a/drivers/hwmon/abituguru3.c
@@ -1170,7 +1170,7 @@ static int __init abituguru3_detect(void
 	u8 cmd_val = inb_p(ABIT_UGURU3_BASE + ABIT_UGURU3_CMD);
 	if (((data_val = 0x00) || (data_val = 0x08)) &&
 			((cmd_val = 0xAC) || (cmd_val = 0x05) ||
-			 (cmd_val = 0x55)))
+			 (cmd_val = 0x55) || (cmd_val = 0xFF)))
 		return 0;
 
 	ABIT_UGURU3_DEBUG("no Abit uGuru3 found, data = 0x%02X, cmd = "
_


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
