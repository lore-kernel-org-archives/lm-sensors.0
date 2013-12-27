From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 27 Dec 2013 14:59:54 +0000
Subject: [lm-sensors] [PATCH v2 0/5] input: Add new sun4i-ts driver for Allwinner sunxi
Message-Id: <1388156399-29677-1-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Corentin LABBE <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org

Hi Dimitri et al,

Here is v2 of my sun4i-ts patch-set.

Changes since v1:
-Use devm_kzalloc and devm_hwmon_device_register_with_groups as suggested
 by Guenter Roeck
-Various small cleanups suggested by Thomas Petazzoni
-Add open/close methods and enable/disable the input related interrupts from
 there as suggested by you (Dimitri)

Assuming there is no more feedback, can you please add the 1st 2 patches
to your tree for 3.14 ?

Maxime, can you please add the dts bits to your dts tree for 3.14 ?

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
