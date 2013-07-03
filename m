From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 03 Jul 2013 15:08:38 +0000
Subject: Re: [lm-sensors] 3.10: Intel HWMON/NIC temperature sensor question
Message-Id: <20130703170838.326894c6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <002401ce77e9$da6524b0$8f2f6e10$@lucidpixels.com>
	<20130703144845.GB10323@roeck-us.net>
In-Reply-To: <20130703144845.GB10323@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Wed, 3 Jul 2013 07:48:45 -0700, Guenter Roeck wrote:
> 82575 and 82599. Doesn't matter much, though, since they don't export the "name"
> attribute from their driver, meaning the sensors command won't find the sensors.
> Also, they enerate the hwmon device first and then create the attributes, which
> is the wrong order and creates a potential race condition with demons.

Yes and no. For devices which are only implementing hwmon features,
hwmon is just a link and the attributes belong to the device. So we can
create the attributes first and the hwmon device second.

However for devices which are primarily something else and only
register a hwmon device as a side object, the hwmon attributes are
attached to the hwmon class device and not the main device. In that
case the hwmon device has to be created first and the attributes
second. Yes, this is racy. The only clean way around it AFAIK is to
implement all the attributes as proper class attributes rather than
creating them manually - but it would take a whole redesign of the
hwmon core module.

A workaround may be to create the name attribute last.

> Someone who has a board will have to fix that at some point.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
