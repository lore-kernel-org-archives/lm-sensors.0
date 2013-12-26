From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Thu, 26 Dec 2013 08:39:35 +0000
Subject: Re: [lm-sensors] [PATCH 2/5] input: sun4i-ts: Add support for temperature sensor
Message-Id: <20131226093935.28890a14@skate>
List-Id: <lm-sensors.vger.kernel.org>
References: <1387923847-1294-1-git-send-email-hdegoede@redhat.com>
	<1387923847-1294-3-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1387923847-1294-3-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

Dear Hans de Goede,

On Tue, 24 Dec 2013 23:24:04 +0100, Hans de Goede wrote:

> +	of_property_read_u32(np, "ts-attached", &ts_attached);

ts-attached should be a boolean property, and therefore you should use
of_property_read_bool() here.

And in your Device Tree, you should use:

	ts-attached;

when a touchscreen is attached. And nothing when no touchscreen is
attached.

Note that this patch is also changing the DT binding, so it should
update the DT binding documentation created in the first patch.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
