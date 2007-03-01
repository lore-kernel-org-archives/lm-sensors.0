From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 01 Mar 2007 07:34:01 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <20070301083401.25074dba.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans-J?rgen,

On Wed, 28 Feb 2007 17:08:16 +0100, Hans-J?rgen Koch wrote:
> Thanks a lot for testing, Matej! Jean, what do you say to that? If you think 
> you can apply this I'll update the documentation file.

Thanks for all the work you've been doing on the driver lately. I am
waiting for Corentin Labbe to comment before I do the final review and
merge the driver - I know he found some more things that could be fixed
or improved since his first review, some of which I think you addressed
yesterday, some not.

I look briefly at the new options you implemented. They are definitely
better as module options than hardcoded in the driver code, however I'm
not sure we really want all of them to be module options.

General remark: the module parameters are driver-wide and not
device-specific, so they must me checked at module load time (in
sensors_max6650_init). Also, for all settings that are not forced by
the user, it might be convenient to print in the logs the value that
was found for each chip.

voltage_12V: Must indeed be an option, although the convention you
chose is a bit strange IMHO. What about a parameter named "fan_voltage"
with possible values 0 (default, no change), 5 and 12?

(BTW, is this an output voltage? input voltage? both?)

prescaler: What does it do? It smells like a fan clock divider to me.
In that case it would be better implemented as a fan1_div sysfs file,
which the user can adjust at runtime.

clock: OK.

mode: This smells like fan speed control parameters, which we typically
implement as the pwm1_enable sysfs file. Please take a look at the
description in Documentation/hwmon/sysfs-interface and tell me what
you think.

counttime: This one too seems to be related to a fan clock divider? How
does it functionally differ from prescaler?

Thanks,
-- 
Jean Delvare

