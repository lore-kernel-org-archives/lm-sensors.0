From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 26 Dec 2013 22:19:53 +0000
Subject: Re: [lm-sensors] [linux-sunxi] Re: [PATCH 2/5] input: sun4i-ts: Add support for temperature sensor
Message-Id: <20131226221953.GB18562@core.coreip.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1387923847-1294-1-git-send-email-hdegoede@redhat.com>
 <1387923847-1294-3-git-send-email-hdegoede@redhat.com>
 <20131225103723.GA18256@roeck-us.net>
 <52BAB963.30707@redhat.com>
In-Reply-To: <52BAB963.30707-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

On Wed, Dec 25, 2013 at 11:54:27AM +0100, Hans de Goede wrote:
> On 12/25/2013 11:37 AM, Guenter Roeck wrote:
> >On Tue, Dec 24, 2013 at 11:24:04PM +0100, Hans de Goede wrote:
> >>  struct sun4i_ts_data {
> >>  	struct device *dev;
> >>  	void __iomem *base;
> >>  	struct input_dev *input;
> >>+	struct device *hwmon;
> >>+	atomic_t temp_data;
> >
> >Unless I am missing something, this variable does not have to be an atomic.
> >Either it was written or it wasn't, but the order should not matter.
> 
> That is true, but it does assume that 32 bit int accesses are atomic, in the
> sense that we can never have a case where one core has only written ie the
> lower 8 bits when the other reads the variable. I believe that is the
> case on ARM (the only architecture relevant here), but rather safe then
> sorry. So I plan to keep this as is until someone, who knows more about
> these things then me, tells me it is safe to turn it into a regular int.

I believe on all arches that we support writes to aligned double word
memory locations will not be split.

Thanks.

-- 
Dmitry

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
