From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Thu, 06 Feb 2014 15:07:20 +0000
Subject: Re: [lm-sensors] randconfig build error with next-20140206, in drivers/hwmon/ltc2945.c
Message-Id: <CAP=VYLrOBrkgnmC818a-Ke_UkDBsgMjbTx3WBZ2wqqPOmFMrCQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CA+r1ZhgB-DpgshX24HmzuqZPQr5wsueg4GYACy-669RmTL4xRA@mail.gmail.com>
 <52F39718.9070205@roeck-us.net>
In-Reply-To: <52F39718.9070205@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jim Davis <jim.epost@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, jdelvare@suse.de, lm-sensors@lm-sensors.org

On Thu, Feb 6, 2014 at 9:07 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 02/06/2014 05:57 AM, Jim Davis wrote:
>>
>> Building with the attached random configuration file,
>>
>> drivers/built-in.o: In function `ltc2945_set_value':
>> ltc2945.c:(.text+0x58b1ad): undefined reference to `__udivdi3'
>> ltc2945.c:(.text+0x58b1cc): undefined reference to `__udivdi3'
>> ltc2945.c:(.text+0x58b1dd): undefined reference to `__udivdi3'
>> ltc2945.c:(.text+0x58b1fb): undefined reference to `__udivdi3'
>> make: *** [vmlinux] Error 1
>>
>
> I really love those auto-builders :-)
>
> Should be fixed in the next version of -next.

Looks like the same problem cropped up in mips allmodconfig, but
w/o the nice pointer to the line number in the source...

  CC [M]  lib/notifier-error-inject.o
  CC [M]  lib/pm-notifier-error-inject.o
ERROR: "__udivdi3" [drivers/hwmon/ltc2945.ko] undefined!
make[2]: *** [__modpost] Error 1
make[1]: *** [modules] Error 2
make: *** [sub-make] Error 2

http://kisskb.ellerman.id.au/kisskb/buildresult/10578301/

I'll check back tomorrow :)

Thanks,
Paul.
--

>
> Guenter
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-next" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
