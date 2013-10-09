From: Wei Ni <wni@nvidia.com>
Date: Wed, 09 Oct 2013 08:57:30 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (lm90) Add support for TI TMP451
Message-Id: <52551A7A.6080905@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1381297248-13375-1-git-send-email-wni@nvidia.com> <20131009102323.169965ff@endymion.delvare>
In-Reply-To: <20131009102323.169965ff-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 10/09/2013 04:23 PM, Jean Delvare wrote:
> Hi Wei,
> 
> On Wed, 9 Oct 2013 13:40:48 +0800, Wei Ni wrote:
>> TI TMP451 is mostly compatible with ADT7461, except for
>> local temperature low byte and max conversion rate.
>> Add support to the LM90 driver.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  Documentation/hwmon/lm90 |    6 ++++++
>>  drivers/hwmon/lm90.c     |   45 +++++++++++++++++++++++++++++++++++++--------
>>  2 files changed, 43 insertions(+), 8 deletions(-)
> 
> If the lm90 driver supports and detects this chip then sensors-detect
> should as well. I can do that for you if you provide a register dump of
> your TMP451 chip (use the i2c-dev driver and i2cdump from the i2c-tools
> package.)

localhost device # i2cdump -f 0 0x4c
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x4c, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 5d 69 00 04 08 bf 00 ff 53 00 00 00 00 00 00 00    ]i.???..S.......
10: a0 00 00 00 00 f0 00 00 00 a9 00 00 00 00 00 00    ?....?...?......
20: b8 0a 01 00 00 XX 00 00 00 00 0e 00 00 00 00 00    ???..X....?.....
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 55 00    ..............U.
localhost device #

Thanks.
Wei.

> 
> Thanks,
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
