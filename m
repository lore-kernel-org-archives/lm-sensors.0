From: Robert Rosengren <robert.rosengren@axis.com>
Date: Tue, 27 Jan 2015 19:54:34 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads7828) Make sample interval configurable
Message-Id: <4BEA3FF3CAA35E408EA55C7BE2E61D05943B6DD753@xmail3.se.axis.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1421409922-28299-1-git-send-email-robert.rosengren@axis.com>
 <54B92596.2040206@roeck-us.net> <20150116183020.GA6262@roeck-us.net>
 <54C74567.9020201@axis.com>,<54C79B87.8040607@roeck-us.net>
In-Reply-To: <54C79B87.8040607@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>
Cc: Johan Adolfsson <johana@axis.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Guenter and Jean, 

To sum up, my problems was related my kernel and hardware configuration, and it now works. Many thanks for your input!

However, the values retrieved from hwmon sysfs is not the same as before the regmap patch. Guenter, the byte swap for the regval retrieved by regmap_read. In what order is the bits returned from that function, because it seems as if I disabled that code I get values as I expect (i.e. before the regmap patch).

BR,
Robert


> On 01/26/2015 11:59 PM, Robert Rosengren wrote:
>> On 01/16/2015 07:30 PM, Guenter Roeck wrote:
>>> I sent a couple of patches a minute ago which should take care of the issue.
>>> Would be great if you can test it.
>> I applied the v2 versions of the patches for a quick test, but it was not successful. Haven't done any further investigation on what the problem might be, but when trying to read the sysfs driver I get "read error: No such device or address".
>>
>> The sysfs path have moved with the REGMAP settings, from /sys/bus/i2c/devices/<x>/in0_input to /sys/bus/i2c/devices/<x>/hwmon/hwmon0/in0_input.
>>
>> Any ideas? Haven't had REGMAP configured in my kernel earlier, might it be some specific configuration I miss?
>>
>
> Did you configure REGMAP ? That would now be necessary.
> The "official" sysfs path would be /sys/class/hwmon/hwmonX (hwmon0 in your case).
>
> Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
