From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 25 Jul 2014 07:50:03 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (pwm-fan) Add proper #ifdef CONFIG_OF guard for of_device_id tab
Message-Id: <20140725095003.00400e02@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406258073.9778.3.camel@phoenix>
In-Reply-To: <1406258073.9778.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter, Axel,

On Thu, 24 Jul 2014 21:56:00 -0700, Guenter Roeck wrote:
> On 07/24/2014 09:46 PM, Axel Lin wrote:
> > 2014-07-25 12:29 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
> >> The driver won't instantiate if OF is not configured.
> > You are right.
> > Then how about adding OF dependency to config SENSORS_PWM_FAN?
> 
> Then it won't compile with allmodconfig on x86. I prefer to be able
> to compile it. So we would have to add COMPILE_TEST as secondary
> dependency, and things would get more and more complex.
> Not really sure if I want to go along that route.
> 
> Jean, any thoughts ?

depends on OF || COMPILE_TEST

is good and not complex at all, just do that :) Note that you can put
this on a line on its own, this is the recommended way to keep
functional (build-time) dependencies and run-time dependencies clearly
separated.

FWIW I have been speaking loudly in various occasions in favor of
generalizing the use of run-time dependencies in combination with
COMPILE_TEST. So I would be very happy if the hwmon subsystem goes down
that road too.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
