From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 03 Jul 2013 16:25:45 +0000
Subject: Re: [lm-sensors] 3.10: Intel HWMON/NIC temperature sensor question
Message-Id: <20130703162545.GA12506@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <002401ce77e9$da6524b0$8f2f6e10$@lucidpixels.com>
 <20130703144845.GB10323@roeck-us.net>
 <20130703170838.326894c6@endymion.delvare>
In-Reply-To: <20130703170838.326894c6@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Wed, Jul 03, 2013 at 05:08:38PM +0200, Jean Delvare wrote:
> On Wed, 3 Jul 2013 07:48:45 -0700, Guenter Roeck wrote:
> > 82575 and 82599. Doesn't matter much, though, since they don't export the "name"
> > attribute from their driver, meaning the sensors command won't find the sensors.
> > Also, they enerate the hwmon device first and then create the attributes, which
> > is the wrong order and creates a potential race condition with demons.
> 
> Yes and no. For devices which are only implementing hwmon features,
> hwmon is just a link and the attributes belong to the device. So we can
> create the attributes first and the hwmon device second.
> 
> However for devices which are primarily something else and only
> register a hwmon device as a side object, the hwmon attributes are
> attached to the hwmon class device and not the main device. In that
> case the hwmon device has to be created first and the attributes
> second. Yes, this is racy. The only clean way around it AFAIK is to
> implement all the attributes as proper class attributes rather than
> creating them manually - but it would take a whole redesign of the
> hwmon core module.
> 

Actually, there would be a simple solution. We can add an API call such as
hwmon_device_register_groups(), which in addition to passing the parent device
would also pass "struct attribute_groups **". It would have to create the device
manually instead of calling device_create(), but would add the groups to the
device structure prior to calling device_register(). The core device handling
code would then automatically create all attributes (and remove them later on).

We might even be able to convince the device core maintainers to let us add a
"device_register_groups()" API into the device core code.

Code itself should be straightforward. Worth a try ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
