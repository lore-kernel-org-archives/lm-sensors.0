From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Thu, 03 Jul 2008 20:00:43 +0000
Subject: Re: [lm-sensors] PATCH: abituguru3-fix-detect.patch
Message-Id: <200807032100.44016.alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4836D061.9080501@hhs.nl>
In-Reply-To: <4836D061.9080501@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Sunday 08 June 2008 16:16:33 Mark M. Hoffman wrote:
> > It has been reported that the abituguru3 driver fails to load after a
> > BIOS update. This patch fixes this by loosening the detection routine so
> > that it will work after the BIOS update too. To compensate for the now
> > very loose detection an additional check is added on the DMI Base Board
> > vendor string to make sure we only load on Abit motherboards, this is the
> > same as the check in the abituguru (1 / 2) driver.
> >
> > Signed-of-by: Hans de Goede <j.w.r.degoede@hhs.nl>
>
> Applied to hwmon-2.6.git/testing, thanks.
>
> (will include in final batch to Linus for 2.6.26 also)

After updating my BIOS (from 16 to 17) the driver has stopped loading
again. This is with 2.6.26-rc8. The reason is that the command byte has
changed value to 0xFF (this is reproducible across cold and warm starts).

The following diff fixes it, but the "probe" is now looking even more creaky..

---

Fix loading of abituguru3 on Abit IP35 Pro with BIOS 17. The magic bytes have
changed value (again).

Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index f00f497..53ee148 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -1118,7 +1118,7 @@ static int __init abituguru3_detect(void)
 	u8 cmd_val = inb_p(ABIT_UGURU3_BASE + ABIT_UGURU3_CMD);
 	if (((data_val = 0x00) || (data_val = 0x08)) &&
 			((cmd_val = 0xAC) || (cmd_val = 0x05) ||
-			 (cmd_val = 0x55)))
+			 (cmd_val = 0x55) || (cmd_val = 0xFF)))
 		return ABIT_UGURU3_BASE;
 
 	ABIT_UGURU3_DEBUG("no Abit uGuru3 found, data = 0x%02X, cmd = "


-- 
Cheers,
Alistair.

137/1 Warrender Park Road, Edinburgh, UK.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
