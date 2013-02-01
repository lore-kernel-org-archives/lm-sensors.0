From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 01 Feb 2013 21:57:49 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Add device tree support
Message-Id: <20130201225749.4b17d42d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1359753502-13240-1-git-send-email-vpalatin@chromium.org>
	<20130201213640.GA1606@roeck-us.net>
In-Reply-To: <20130201213640.GA1606@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Vincent Palatin <vpalatin@chromium.org>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-kernel@vger.kernel.org, Olof Johansson <olofj@chromium.org>, Sameer Nanda <snanda@chromium.org>

On Fri, 1 Feb 2013 13:36:40 -0800, Guenter Roeck wrote:
> On Fri, Feb 01, 2013 at 01:18:22PM -0800, Vincent Palatin wrote:
> > When the kernel has device tree support, we avoid doing the auto-detection
> > as probing the busses might mess-up sensitive I2C devices or trigger long
> > timeouts on non-functional busses.
> (...)
> As for the detect function, I am not entirely sure if we want or should get
> rid of it just because OF is configured. That may have unintended side effects.
> Either case, I would argue that if we do want to do that, it should be done
> for _all_ I2C devices and not just for the lm90 driver. In other words, it
> should be done in the I2C subsystem, maybe with a separate configuration option.

I can't think of any reason for doing that. Detection only happens on
I2C buses which request it (by setting i2c_adapter.class.) I2C system
bus drivers for OF-based platforms would simply not set any class flag,
so detection won't be triggered on them.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
