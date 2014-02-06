From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 06 Feb 2014 14:07:20 +0000
Subject: Re: [lm-sensors] randconfig build error with next-20140206, in drivers/hwmon/ltc2945.c
Message-Id: <52F39718.9070205@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CA+r1ZhgB-DpgshX24HmzuqZPQr5wsueg4GYACy-669RmTL4xRA@mail.gmail.com>
In-Reply-To: <CA+r1ZhgB-DpgshX24HmzuqZPQr5wsueg4GYACy-669RmTL4xRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jim Davis <jim.epost@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, jdelvare@suse.de, lm-sensors@lm-sensors.org

On 02/06/2014 05:57 AM, Jim Davis wrote:
> Building with the attached random configuration file,
>
> drivers/built-in.o: In function `ltc2945_set_value':
> ltc2945.c:(.text+0x58b1ad): undefined reference to `__udivdi3'
> ltc2945.c:(.text+0x58b1cc): undefined reference to `__udivdi3'
> ltc2945.c:(.text+0x58b1dd): undefined reference to `__udivdi3'
> ltc2945.c:(.text+0x58b1fb): undefined reference to `__udivdi3'
> make: *** [vmlinux] Error 1
>

I really love those auto-builders :-)

Should be fixed in the next version of -next.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
