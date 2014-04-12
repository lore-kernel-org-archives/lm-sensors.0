From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 12 Apr 2014 17:39:21 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm70) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <53497A49.5060806@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1397187944-1662-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1397187944-1662-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/12/2014 10:31 AM, Jean Delvare wrote:
> On Thu, 10 Apr 2014 20:45:44 -0700, Guenter Roeck wrote:
>> Use devm_hwmon_device_register_with_groups API to attach attributes
>> to hwmon device, simplify code, and reduce code size.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/lm70.c |   62 ++++++++++++--------------------------------------
>>   1 file changed, 14 insertions(+), 48 deletions(-)
>> (...)
>
> I can't test, but this looks alright to me.
>
Hi Jean,

The patches I am sending out are all tested on real hardware
(unless mentioned in the commit log), so the risk should be low
unless I am missing something in my test.

> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
Thanks a lot!

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
