From: Steve Sakoman <sakoman@gmail.com>
Date: Wed, 04 May 2011 14:31:58 +0000
Subject: Re: [lm-sensors] [PATCH 0/2 v5] twl4030-madc driver
Message-Id: <BANLkTik=DkTud2Fj0zNAKPXcr1AVAvPTAg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298986926-31180-1-git-send-email-j-keerthy@ti.com>
	<20110302101512.GC16181@sortiz-mobl>
	<BANLkTimc6uz353DDb9Ent6s6WjfY7f-xuA@mail.gmail.com>
	<BANLkTi=zt1j_s1uDfjL=SRG6_LS1pa3xAg@mail.gmail.com>
	<BANLkTik2B_w5Rn+Q-erPhQs6VbfrNz2mcA@mail.gmail.com>
	<BANLkTimyxpfBLUTPUostFjHkCUSW7wzyVA@mail.gmail.com>
In-Reply-To: <BANLkTimyxpfBLUTPUostFjHkCUSW7wzyVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, mikko.k.ylinen@nokia.com, amit.kucheria@canonical.com, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

On Tue, May 3, 2011 at 9:23 PM, J, KEERTHY <j-keerthy@ti.com> wrote:
> On Wed, May 4, 2011 at 9:41 AM, Steve Sakoman <sakoman@gmail.com> wrote:
>> On Tue, May 3, 2011 at 12:49 PM, J, KEERTHY <j-keerthy@ti.com> wrote:
>>> Hello Steve,
>>>
>>> Can you try adding this patch?
>>
>> Thanks!
>>
>> I tried the patch and it did indeed fix the issue. =A0We should try to
>> get this in mainline since the hwmon driver won't work without it.
>>
>
> Yes Steve. I am posting a patch today.

I've also found that the madc clock needs to be enabled:

From: Steve Sakoman <steve@sakoman.com>
Date: Sat, 23 Jan 2010 14:26:54 +0000 (-0800)
Subject: mfd: twl-core: enable madc clock
X-Git-Url: http://www.sakoman.com/cgi-bin/gitweb.cgi?p=3Dlinux-omap-2.6.git=
;a=3Dcommitdiff_plain;h=A1f1a1a6420f15e8351a0c5d63a81aa2444874f4

mfd: twl-core: enable madc clock

Now that the madc driver has been merged it is also necessary to
enable the clock to the madc block

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index d9435e4..9096d7d 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -222,6 +222,11 @@

 /* Few power values */
 #define R_CFG_BOOT			0x05
+#define R_GPBR1				0x0C
+
+/* MADC clock values for R_GPBR1 */
+#define MADC_HFCLK_EN			0x80
+#define DEFAULT_MADC_CLK_EN		0x10

 /* some fields in R_CFG_BOOT */
 #define HFCLK_FREQ_19p2_MHZ		(1 << 0)
@@ -992,6 +997,9 @@ static void clocks_init(struct device *dev,

 	e |=3D unprotect_pm_master();
 	/* effect->MADC+USB ck en */
+	if (twl_has_madc())
+		e |=3D twl_i2c_write_u8(TWL_MODULE_INTBR,
+				MADC_HFCLK_EN | DEFAULT_MADC_CLK_EN, R_GPBR1);
 	e |=3D twl_i2c_write_u8(TWL_MODULE_PM_MASTER, ctrl, R_CFG_BOOT);
 	e |=3D protect_pm_master();

diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 0c0d1ae..cbbf3b3 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -74,6 +74,7 @@

 #define TWL_MODULE_USB		TWL4030_MODULE_USB
 #define TWL_MODULE_AUDIO_VOICE	TWL4030_MODULE_AUDIO_VOICE
+#define TWL_MODULE_INTBR	TWL4030_MODULE_INTBR
 #define TWL_MODULE_PIH		TWL4030_MODULE_PIH
 #define TWL_MODULE_MADC		TWL4030_MODULE_MADC
 #define TWL_MODULE_MAIN_CHARGE	TWL4030_MODULE_MAIN_CHARGE

I'll submit this patch separately.

Steve

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
