From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 28 Dec 2013 01:13:04 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/5] input: sun4i-ts: Add support for temperature sensor
Message-Id: <20131228011304.GB14188@core.coreip.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1388156399-29677-1-git-send-email-hdegoede@redhat.com>
 <1388156399-29677-3-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1388156399-29677-3-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Corentin LABBE <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org

On Fri, Dec 27, 2013 at 03:59:56PM +0100, Hans de Goede wrote:
>  
> +Optional properties:
> + - ts-attached: boolean set this to tell the driver that an actual touchscreen
> +		is attached and that it should register an input device,
> +		without this it only registers the builtin temperate sensor

I believe the guidance is to avoid describing kernel behavior in DT
property so I think it should say:

 - ts-attached: boolean indicating that an actual touchscreen is
		attached to the controller.

Thanks.

-- 
Dmitry

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
