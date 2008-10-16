From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 16 Oct 2008 22:55:14 +0000
Subject: Re: [lm-sensors] Driver for HP harddisk protection LED
Message-Id: <20081016155514.eed60f09.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <48C984F5.5000804@tudelft.nl>
	<200809120736.06594.trenn@suse.de>
	<48CAD89F.1050806@tremplin-utc.net>
	<20081015072511.GA20607@atrey.karlin.mff.cuni.cz>
	<20081016091016.GA15439@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20081016091016.GA15439@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@suse.cz>
Cc: eric.piel@tremplin-utc.net, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, trenn@suse.de, burman.yan@gmail.com

On Thu, 16 Oct 2008 11:10:16 +0200
Pavel Machek <pavel@suse.cz> wrote:

> HP notebooks contain accelerometer-based disk protection subsystem,
> and LED that indicates hard disk is protected. This is driver for the
> LED part.

- fix comment typo

- use standard suspend/resume ifdef avoidance trick


 drivers/leds/leds-hp-disk.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/leds/leds-hp-disk.c~leds-driver-for-hp-harddisk-protection-led-fix
+++ a/drivers/leds/leds-hp-disk.c
@@ -49,7 +49,7 @@ static struct acpi_hpled adev;
 
 static acpi_status hpled_acpi_write(acpi_handle handle, int reg)
 {
-	unsigned long ret; /* Not used when writting */
+	unsigned long ret; /* Not used when writing */
 	union acpi_object in_obj[1];
 	struct acpi_object_list args = { 1, in_obj };
 
@@ -83,6 +83,9 @@ static int hpled_resume(struct acpi_devi
 	led_classdev_resume(&hpled_led);
 	return 0;
 }
+#else
+#define hpled_suspend NULL
+#define hpled_resume NULL
 #endif
 
 static int hpled_add(struct acpi_device *device)
@@ -119,10 +122,8 @@ static struct acpi_driver leds_hp_driver
 	.ops = {
 		.add     = hpled_add,
 		.remove  = hpled_remove,
-#ifdef CONFIG_PM
 		.suspend = hpled_suspend,
 		.resume  = hpled_resume,
-#endif
 	}
 };
 
_


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
