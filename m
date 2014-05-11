From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 11 May 2014 08:06:24 +0000
Subject: [lm-sensors] [PATCH v4 0/2] input: Add new sun4i-ts driver for Allwinner sunxi SoC's rtp controller
Message-Id: <1399795586-18919-1-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org

Hi All,

Since Maxime rightfully pointed out an error in my resend of v3, here is v4
with that fixed.

Note the second patch which adds hwmon functionality has been reviewed by
the hwon subsystem maintainer, and the sun?i*.dts changes to enable this
have already been upstreamed.

Changes since v1:
-Use devm_kzalloc and devm_hwmon_device_register_with_groups as suggested
 by Guenter Roeck
-Various small cleanups suggested by Thomas Petazzoni
-Add open/close methods and enable/disable the input related interrupts from
 there as suggested by Dmitry

Changes since v2:
-Addressed review comments from Dmitry
-Addressed review comments from Guenter
-Addressed review comments from Maxime
-Initialize ignore_fifo_data to true, the very first coordinate can be
 wrong too

Changes since v3:
-Rename compatible from sun4i-ts to sun4i-a10-ts to match the dts entries
 which are already upstream

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
