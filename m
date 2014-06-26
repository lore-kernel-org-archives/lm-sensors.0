From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 26 Jun 2014 15:11:48 +0000
Subject: Re: [lm-sensors] [PATCH v2] sensors-detect: Add detection of NCT7802Y
Message-Id: <53AC3834.2050803@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DDE1CFF.1020906@appeartv.com>
In-Reply-To: <4DDE1CFF.1020906@appeartv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/26/2014 06:55 AM, Jean Delvare wrote:
> On Thu, 26 Jun 2014 06:28:14 -0700, Guenter Roeck wrote:
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Don't attempt to detect chip if register bank 1 is selected.
>>      Document all used registers.

...

>>
>>   # Registers used:
>> +#   0x00: Bank selection (Bank 0, 1)
>
> Not sure the "(Bank 0, 1)" makes much sense any longer.
>
On the other side, it doesn't hurt, so I left it in.

> Looks good otherwise, feel free to commit.
>

Thanks!

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
