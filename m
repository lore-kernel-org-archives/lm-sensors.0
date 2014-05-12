From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 May 2014 02:20:58 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon/emc1403.c: add support for emc1412
Message-Id: <5370300A.8070102@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140511130023.GA501@dashie> <536FFC55.2080009@roeck-us.net>
In-Reply-To: <536FFC55.2080009@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Josef Gajdusek <atx@atx.name>, jdelvare@suse.de
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On 05/11/2014 03:40 PM, Guenter Roeck wrote:
[ ... ]

>>
>>       id = i2c_smbus_read_byte_data(client, THERMAL_REVISION_REG);
>> -    if (id != 0x01)
>> +    if (id != 0x01 && id != 0x04) {
>>           return -ENODEV;
>
> This should be a separate patch, as it applies to emc1403/emc1404 as well,
> so we can backport it into -stable.
>

Also, the chip datasheet suggests that chip revision 3 exists as well.
Given that, I would suggest to replace the revision number check with
something like
	if (id < 0x01 || id > 0x04)
		return -ENODEV;

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
