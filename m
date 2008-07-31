From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 31 Jul 2008 10:30:05 +0000
Subject: [lm-sensors] PATCH: abituguru3-fix-detect.patch
Message-Id: <4891942D.4080304@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070901090508010709040401"
List-Id: <lm-sensors.vger.kernel.org>
References: <4836D061.9080501@hhs.nl>
In-Reply-To: <4836D061.9080501@hhs.nl>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070901090508010709040401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

As discussed I'm sending this patch directly to you for 2.6.27 inclusion as 
Mark seems to be out of the loop at the moment.

Alistair John Strachan wrote:

"After updating my BIOS (from 16 to 17) the driver has stopped loading
again. This is with 2.6.26-rc8. The reason is that the command byte has
changed value to 0xFF (this is reproducible across cold and warm starts).

The following diff fixes it."

Regards,

Hans

--------------070901090508010709040401
Content-Type: text/x-patch;
 name="abituguru3-fix-detect.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="abituguru3-fix-detect.patch"

Fix loading of abituguru3 on Abit IP35 Pro with BIOS 17. The magic bytes have
changed value (again).

Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>

--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -1118,7 +1118,7 @@ static int __init abituguru3_detect(void)
 	u8 cmd_val = inb_p(ABIT_UGURU3_BASE + ABIT_UGURU3_CMD);
 	if (((data_val == 0x00) || (data_val == 0x08)) &&
 			((cmd_val == 0xAC) || (cmd_val == 0x05) ||
-			 (cmd_val == 0x55)))
+			 (cmd_val == 0x55) || (cmd_val == 0xFF)))
 		return ABIT_UGURU3_BASE;
 
 	ABIT_UGURU3_DEBUG("no Abit uGuru3 found, data = 0x%02X, cmd = "

--------------070901090508010709040401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070901090508010709040401--
