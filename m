From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 28 Jan 2015 04:06:13 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads7828) Make sample interval configurable
Message-Id: <54C86035.9080605@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1421409922-28299-1-git-send-email-robert.rosengren@axis.com>	<54B92596.2040206@roeck-us.net>	<20150116183020.GA6262@roeck-us.net>	<54C74567.9020201@axis.com>	<54C79B87.8040607@roeck-us.net>	<4BEA3FF3CAA35E408EA55C7BE2E61D05943B6DD753@xmail3.se.axis.com>	<20150127200553.GA5689@roeck-us.net> <20150127233455.0c62457e@endymion.delvare>
In-Reply-To: <20150127233455.0c62457e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>
Cc: Robert Rosengren <robert.rosengren@axis.com>, lm-sensors@lm-sensors.org, Johan Adolfsson <johana@axis.com>, linux-kernel@vger.kernel.org

On 01/27/2015 02:34 PM, Jean Delvare wrote:
> On Tue, 27 Jan 2015 12:05:53 -0800, Guenter Roeck wrote:
>> On Tue, Jan 27, 2015 at 08:54:34PM +0100, Robert Rosengren wrote:
>>> Guenter and Jean,
>>>
>>> To sum up, my problems was related my kernel and hardware configuration, and it now works. Many thanks for your input!
>>>
>>> However, the values retrieved from hwmon sysfs is not the same as before the regmap patch. Guenter, the byte swap for the regval retrieved by regmap_read. In what order is the bits returned from that function, because it seems as if I disabled that code I get values as I expect (i.e. before the regmap patch).
>>>
>> Trying to understand. Are you saying everything works as expected
>> if you keep byte_swap set to false ?
>>
>> That might well be, though it might mean that regmap has a bug
>> in how it treats i2c word read operations. I'll have to look into it
>> some more.
>
> Remember that SMBus specifies that the LSB comes first (and i2c-core
> implement things that way) while real I2C devices typically send the MSB
> first. This has always caused confusion. This is why a lot of drivers
> need byte-swapping.
>

regmap specifies "normal" i2c accesses as MSB first. When SMBus accesses
are used, it specifies LSB first. I guess that means that regmap assumes
the more common case of MSB first, meaning the driver would not need a byte
swap since the chip reports data with MSB first.

I just hope I interpret it correctly this time.

There is also a configuration flag "val_format_endian" which can be set to
REGMAP_ENDIAN_BIG or REGMAP_ENDIAN_LITTLE. Maybe that can be used as well
if needed. Either case I'll wait for the samples before I send an updated
version of the patch.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
