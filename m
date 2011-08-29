From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 29 Aug 2011 16:02:48 +0000
Subject: Re: [lm-sensors] Notifier in hwmon
Message-Id: <1314633768.2796.174.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E5B46A6.7010509@stericsson.com>
In-Reply-To: <4E5B46A6.7010509@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-08-29 at 03:58 -0400, Daniel Willerud wrote:
> Hi,
> 
> I need our hwmon driver to notify the sysctrl driver if there is a 
> thermal warning when powering off the system.
> 
> Please advice whether it is a good idea to add the notifier to the core 
> hwmon driver. I've attached the hwmon patch and our driver using the 
> notification.
> 
No idea either. Your code is a bit difficult to review since it is not
in patch form. Might be better to send it as series of rfc patches
instead.

Couple of comments:

There is no explanation in your code describing what the notifier is
supposed to be used for. Your calls to the notifier always pass a
boolean and NULL. The call actually registering the notifier function(s)
is not included, so it is a bit difficult to determine what the notified
code is expected to do. It gets a 1 as parameter - so what ? If the code
is supposed to be for some generic use, as the unused pointer indicates,
it should probably include some more useful parameters.

Defining a power off delay in a hwmon driver seems like a bad idea. That
kind of functionality does not belong into a hwmon driver.

The hwmon sysfs ABI defines an attribute named update_interval, which
you might want to use instead of temp_monitor_delay (which doesn't
really match its name).

Consider the following code sequence.

    bool alarm;
    ...
    if (data->min[i] != 0) {
	alarm = val < data->min[i];
	updated_min_alarm = alarm != data->min_alarm[i];
	data->min_alarm[i] = alarm;
    }

Instead of re-creating sysfs names again and again to generate sysfs
notifications, you might consider using the existing name string in the
attributes instead.

I don't think your code compiles ;). If it does, gpadc_monitor() won't
do what you expect it to do. Actually, it won't do what you expect it to
do anyway, since you don't reset the updated_xxx flags after each loop
iteration.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
