From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 02 Mar 2014 16:29:11 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Do not accept name attributes which include '-'
Message-Id: <53135C57.1000403@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393612837-20042-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1393612837-20042-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 03/02/2014 08:24 AM, Guenter Roeck wrote:
> Hi Jean,
>
> On 03/02/2014 05:17 AM, Jean Delvare wrote:
>> Hi Guenter,
>>
>> On Fri, 28 Feb 2014 10:40:37 -0800, Guenter Roeck wrote:
>>> hwmon name attributes must not include '-', as specified in
>>> Documentation/hwmon/sysfs-interface. Validate the name attribute
>>> and return an error if it is invalid.
>>>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>>   drivers/hwmon/hwmon.c |    5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
>>> index e176a43..6a84df4 100644
>>> --- a/drivers/hwmon/hwmon.c
>>> +++ b/drivers/hwmon/hwmon.c
>>> @@ -22,6 +22,7 @@
>>>   #include <linux/gfp.h>
>>>   #include <linux/spinlock.h>
>>>   #include <linux/pci.h>
>>> +#include <linux/string.h>
>>>
>>>   #define HWMON_ID_PREFIX "hwmon"
>>>   #define HWMON_ID_FORMAT HWMON_ID_PREFIX "%d"
>>> @@ -99,6 +100,10 @@ hwmon_device_register_with_groups(struct device *dev, const char *name,
>>>       struct hwmon_device *hwdev;
>>>       int err, id;
>>>
>>> +    /* Do not accept '-' in hwmon name attribute */
>>> +    if (name && strchr(name, '-'))
>>> +        return ERR_PTR(-EINVAL);
>>> +
>>
>> I like it, thanks for doing that. Maybe we could check for spaces too?
>> That would break libsensors as well, and I vaguely recalled that
>> someone attempted that once already (caught during code review,
>> thankfully.)
>>
>
> Makes sense. Any other invalid characters we should look out for
> since we are at it ?
>

Newline, '\', '?', '*' comes into mind, and possibly quotes (single
and double).

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
