From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 14 Jul 2014 17:25:56 +0000
Subject: Re: [lm-sensors] hwmon: question about the sysfs interface
Message-Id: <20140714172556.GA3753@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140714164728.GA1041@elysium.lan>
In-Reply-To: <20140714164728.GA1041@elysium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gianni Vialetto <gianni@rootcube.net>
Cc: nouveau@lists.freedesktop.org, lm-sensors@lm-sensors.org

On Mon, Jul 14, 2014 at 06:47:28PM +0200, Gianni Vialetto wrote:
> Hello guys,
> 
> For a patch to this nouveau bug [1] I'm trying to implement the sysfs
> interface for two properties (linear_min and linear_max) nouveau uses
> internally to decide when to raise the fan speed. The initial idea was
> to have them as custom sysfs attributes, but I was advised to try to
> fit them into the hwmon sysfs interface.
> 
> And this is when I hit a little roadblock. If my understanding is
> correct (and I'm not ashamed to admit it probably isn't) trip points
> are used to tie together a specific fan speed to a specific
> temperature. Unfortunately nouveau does not quite work that way: those
> two properties above mark the temperature the driver uses to decide
> when to start and stop the *scaling* of the fan speed (from a specific
> minimum value all the way to 100%).
> 
> Now, could I strech the trip point definition above to mean that a
> trip point specify a *minimum* value for the fan speed at a specific
> temperature, and that the driver can decide to use an higher speed as
> needed when the temperature goes above the one specified in the trip
> point without fear of breaking some convention/userspace tool that
> expect a constant fan speed? Is this an acceptable/correct usage for
> the interface?
> 
For automatic fan control we don't really have a well defined ABI.
Part of the problem is that the mechanisms used by various chips are
quite different.

Please have a look into Documentation/hwmon/nct6775. It is by far
the driver with the most comprehensive fan control mechanisms and
attributes. Would any of the attributes or atribute groups in this
driver meet your needs ? I could imagine that pwm1_target_temp
for the upper temperature limit and pwm1_temp_tolerance for the difference
between upper and lower limit might do. Then there are other attributes
such as pxm1_start, pwm1_floor, pwm1_step, and pwm1_max which you
could use to control pwm values further is that is possible with the
driver.

An alternative would be to use two sets of pwm_auto_point attributes,
where the first set specifies the start pwm limit and the second
specifies the upper temperature and limit. So you would have something
like

	pwm1_auto_point1_pwm	pwm at low temperature
	pwm1_auto_point1_temp	low temperature

	pwm1_auto_point2_pwm	pwm at high temperature
	pwm1_auto_point2_temp	high temperature

After all, there is no requirement that pwm must exactly match the configured
value; the above only means that the chip uses those values to calculate
the necessary fan speed. In addition to that, you could still have some
of the other attributes as needed, such as pwm1_min, pwm1_max, and so on.

Hope this helps,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
