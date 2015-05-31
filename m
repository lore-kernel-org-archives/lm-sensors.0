From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 31 May 2015 22:40:18 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (nct6775) Add missing sysfs attibute initialization
Message-Id: <556B8DD2.3010706@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1432829756-14595-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1432829756-14595-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/31/2015 03:25 PM, Alexey Orishko wrote:
> On Fri, May 29, 2015 at 10:49 AM, Jean Delvare <jdelvare@suse.de> wrote:
>> On Thu, 28 May 2015 09:15:55 -0700, Guenter Roeck wrote:
>>> The following error message is seen when loading the nct6775 driver
>>> with DEBUG_LOCK_ALLOC enabled.
>>>
>>> BUG: key ffff88040b2f0030 not in .data!
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 0 PID: 186 at kernel/locking/lockdep.c:2988
>>>                                lockdep_init_map+0x469/0x630()
>>> DEBUG_LOCKS_WARN_ON(1)
>>>
>>> Caused by a missing call to sysfs_attr_init() when initializing
>>> sysfs attributes.
>>>
>>> Reported-by: Alexey Orishko <alexey.orishko@gmail.com>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

[ ... ]

>>
>> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
> Tested on ASRock E3C222D4U motherboard with kernel 4.0.3; reported
> problem is fixed.
> Tested-by: Alexey Orishko <alexey.orishko@gmail.com>
>
Hi Alexey,

Great, thanks a lot for testing!

The fix is already available in mainline, and should eventually find its way into 4.0.x.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
