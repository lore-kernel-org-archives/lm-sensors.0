From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 06 Jul 2013 19:59:57 +0000
Subject: Re: [lm-sensors] [RFC PATCH 3/5] hwmon: (ds1621) Convert to use hwmon_device_register_groups
Message-Id: <20130706215957.70ae1fdc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373131495-13465-1-git-send-email-linux@roeck-us.net>
	<1373131495-13465-4-git-send-email-linux@roeck-us.net>
	<20130706175747.GA8658@kroah.com>
	<20130706200151.70b7ac3d@endymion.delvare>
	<20130706191816.GA15066@roeck-us.net>
	<20130706193142.GA9778@kroah.com>
	<20130706194803.GA15473@roeck-us.net>
In-Reply-To: <20130706194803.GA15473@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Sat, 6 Jul 2013 12:48:03 -0700, Guenter Roeck wrote:
> Another option would be to create a class attribute to return the parent driver
> name for spi and i2c devices and otherwise the hwmon driver name. This would
> reduce the amount of code needed in the drivers. Jean, do you see a problem with
> that approach (except that we would have to remove explicit name attributes from
> existing drivers) ?

A class attribute is what I had in mind in my previous reply. However I
do not understand the "hwmon driver name" in your sentence above.
Device name != driver name. But well I'm sure I'll understand what you
mean as soon as you show us a candidate implementation ;)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
