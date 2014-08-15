From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Aug 2014 21:09:24 +0000
Subject: Re: [lm-sensors] [RFT PATCH] hwmon: (k10temp) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53EE7704.2060500@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1408120361-26570-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1408120361-26570-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/15/2014 01:57 PM, Clemens Ladisch wrote:
> Guenter Roeck wrote:
>> Use devm_hwmon_device_register_with_groups() to simplify the code
>> and reduce code size.
>>
>> Cc: Clemens Ladisch <clemens@ladisch.de>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> Would be great if someone with access to hardware can test this patch
>> and let me know if it works. Thanks!
>
> The {name,temp*} files moved from /sys/devices/pci0000:00/0000:00:18.3/ to
> /sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon3/.  (And my own little script
> of course does not use libsensors.)
>
Yes, with the new API the attributes are attached to the hwmon device.

>
> Tested-by: Clemens Ladisch <clemens@ladisch.de>
>
Thanks!

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
