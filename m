From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 27 Nov 2014 10:18:56 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] hwmon: ina2xx: bail-out from ina2xx_probe() in case of configuration er
Message-Id: <20141127111856.5b6fda60@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1416930423-12179-1-git-send-email-bgolaszewski@baylibre.com>
	<1416930423-12179-2-git-send-email-bgolaszewski@baylibre.com>
	<5474A72D.2000309@roeck-us.net>
	<CAMpxmJUrs-3oXwYyNh26EnuZRH9bpXrmBBLKM7tmKGx=gSwyuQ@mail.gmail.com>
	<5474B564.9080902@roeck-us.net>
	<CAMpxmJVGE444t3gE-=u8kuK_B9rJ=0fw9ZYVuYgQRPdswiPj7Q@mail.gmail.com>
	<5474C36C.1020004@roeck-us.net>
	<CAMpxmJUhpX+AAmOS2gcgtJGr0dkeQ7YRyae12oRoW2NkT5drBA@mail.gmail.com>
	<5474CAC6.8030608@roeck-us.net>
	<54754364.80705@roeck-us.net>
	<54759F8A.20303@baylibre.com>
	<54762443.90701@roeck-us.net>
In-Reply-To: <54762443.90701@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Benoit Cousson <bcousson@baylibre.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, LKML <linux-kernel@vger.kernel.org>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

On Wed, 26 Nov 2014 11:04:35 -0800, Guenter Roeck wrote:
> On 11/26/2014 01:38 AM, Benoit Cousson wrote:
> > Unfortunately, that's not dynamic enough for all the use cases we need to support with the probes.
> > In fact, most customers will rather put the shunts on their board and thus use a shunt-less version of the probe to do the measurement. In that case, there is no way we can hard code, even in a DTS, the shunt value.
> >
> > That's for that kind of usage that we do need to be able to set the shunt value at runtime. The probe in that case can be pluged dynamically on different board jumpers to do the measurement.
> >
> > Later, thanks to the web UI, the user will be able to configure the shunt value based on the way they were plugged to its boards.
> >
> > sysfs seems to be the easiest way to do that. I don't think DT overlay can handle that, since it is depend of the targeted system and not on the measurement system.
> >
> 
> I just noticed that you did not copy the lm-sensors mailing list.
> 
> I am not really happy with this, and want to get some more feedback
> from the list before I accept more or less arbitrary attributes.
> Jean, any comments ?

No opinion on the matter, sorry.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
