From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 26 Nov 2013 04:38:09 +0000
Subject: Re: [lm-sensors] [PATCH] Input: ads7846: Convert to devm_hwmon_device_register_with_groups
Message-Id: <529425B1.7000708@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1385242620-21719-1-git-send-email-linux@roeck-us.net> <20131126030308.GF31517@core.coreip.homeip.net>
In-Reply-To: <20131126030308.GF31517@core.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 11/25/2013 07:03 PM, Dmitry Torokhov wrote:
> Hi Guenter,
>
> On Sat, Nov 23, 2013 at 01:37:00PM -0800, Guenter Roeck wrote:
>> Simplify the code and create mandatory 'name' attribute by using
>> new hwmon API.
>>
>> Also use is_visible to determine visible attributes instead of creating
>> several different attribute groups.
>
> This change does not quite work without converting the rest of the
> driver to devm_ resources as it makes hwmon outlive regulator and other
> essential resources when unbinding driver from the device.
>
Ok, I'll use hwmon_device_register_with_groups instead.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
