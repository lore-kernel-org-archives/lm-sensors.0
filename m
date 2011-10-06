From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 06 Oct 2011 15:46:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon class driver registration with a
Message-Id: <20111006164600.071213e1@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317834791-2803-1-git-send-email-hschauhan@nulltrace.org>
	<1317839407.3983.46.camel@groeck-laptop>
	<20111006040656.GA2125@ubuntu.ubuntu-domain>
	<20111006051955.GA22835@ericsson.com>
	<20111006094302.71ea4dfd@endymion.delvare>
	<20111006151232.GA3267@ubuntu.ubuntu-domain>
In-Reply-To: <20111006151232.GA3267@ubuntu.ubuntu-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Himanshu Chauhan <hschauhan@nulltrace.org>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

> AFAIK, the current sysfs interface is to read standard attributes from
> the device. My reasoning is:

and any other attributes.

> 1. This will give hwmon devices to have their "dev" in their sysfs folder
>    as like other classes and in turn be visible in /dev by mdev or udev.

Well there is in theory no reason a device shouldn't do that, but most
sysfs devices don't need to so making it generic seems odd.

> 2. Implementing IOCTL if required. I know that kernel hackers believe
>    they are "backdoors" and "can't be done right" but sometimes there
>    isn't any get away with them. I don't know when their support will
>    be completely removed. Rather, I see that instead of deprecation,
>    new IOCTL vectors like compat_ioctl have been introduced.

Certain things need ioctl, in fact some problems are *very* hard to
solve any other way: transactional updates (changing a set of fields at
once all or none), and query/response data being two.
 
> 2. During probing, for each device, call "hwmon_device_register_numbered"
>    and let mdev create a /dev node for it. I don't say that this interface
>    be imposed on drivers. If they want they can still call "hwmon_device_register"
>    if they don't want to implement standard ioctl, read, write calls.

I guess I don't see why a device that is more than just a monitoring
interface can't allocate a misc device or similar if it needs one.

For the more complex cases take a look at drivers/staging/iio also.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
