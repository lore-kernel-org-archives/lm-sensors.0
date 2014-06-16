From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 16 Jun 2014 18:24:27 +0000
Subject: [lm-sensors] [PATCH 0/2] touchscreen: sun4i-ts: fix reported temperature on A10
Message-Id: <1402943069-19420-1-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Tong Zhang <lovewilliam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org

Hi Dmitry and Maxime,

I've learned today that the temperature reported on the A10 / sun4i SoC family
is aprox twice too high, since the A10 rtp controller temperature register
seems to have double the resolution (one bit more) then that of the A13
(sun5i) and later.

Dmitry, can you please add the sun4i-ts.c patch to your tree? Ideally
as a bug-fix for 3.16 (where this driver was first added).

Maxime, can you please add the dts patch to your tree ?

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
