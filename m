From: Ben Hutchings <bhutchings@solarflare.com>
Date: Fri, 11 Nov 2011 20:46:43 +0000
Subject: Re: [lm-sensors] [RFC PATCH 0/2] HWMON: add in-kernel interfaces to
Message-Id: <1321044403.2757.23.camel@bwh-desktop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1320389433-1671-1-git-send-email-myungjoo.ham@samsung.com>
In-Reply-To: <1320389433-1671-1-git-send-email-myungjoo.ham@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, dg77.kim@samsung.com, kyungmin.park@samsung.com, myungjoo.ham@gmail.com

On Fri, 2011-11-04 at 15:50 +0900, MyungJoo Ham wrote:
> We have been reading hwmon values (TMU, the SoC-core temperature sensor,
> and NTC, the ambient or battery surface temperature sensor) for
> Charger-Manager. However, because hwmon does not have in-kernel interface,
> we have been using undesired method, including "../../../fs/*.h".
> 
> This patch is to provide in-kernel interface for hwmon:
> hwmon_get_value and hwmon_set_value. In order to use these two functions,
> the hwmon driver should provide its sysfs attributes to hwmon framework
> as well. If the hwmon driver does not provide (by providing NULL), the users
> of the hwmon won't be able to use hwmon_get/set_value();
> The sysfs attribute (struct attribuyte_group *) is provided with
> hwmon_device_register; adding the second parameter to hwmon_device_register().
> The 2/2 patch shows the changes in device drivers due to this.
[...]

This is an improvement, but I don't think it is quite enough.  As I
understand the hwmon sysfs interface, all sensor values should be
integers.  So the in-kernel interface should also work with integers,
not strings.

As a first implementation you could perhaps parse the strings back to
integers.  However in the longer term the driver API should be changed
so that hwmon drivers fully describe their sensors to the core and the
core takes care of exposing them through sysfs and the in-kernel API.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
