From: Mercier Ivan <ivan.mercier@gmail.com>
Date: Fri, 30 Aug 2013 11:42:52 +0000
Subject: Re: [lm-sensors] ADT7410 No sensors found!
Message-Id: <CAMc2iep3QFqadt21g7fsNy_xouky1GyTtcLoQ8tEU32TnOVCzw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAMc2ierGCBsVEOz-GPc6f94XP84GqS6eJGJovfYga=68eQ9zjA@mail.gmail.com>
In-Reply-To: <CAMc2ierGCBsVEOz-GPc6f94XP84GqS6eJGJovfYga=68eQ9zjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I make it work by adding this to my device tree:

    adt7410@48 {
                compatible = "adi,adt7410";
                reg = <0x48>;
            };


2013/8/30 Jean Delvare <khali@linux-fr.org>:
> On Fri, 30 Aug 2013 10:33:42 +0200, Mercier Ivan wrote:
>> Hi,
>> I'm trying to use my thermal sensor on my powerpc p3041 board.
>>
>> I add CONFIG_SENSORS_ADT7410, CONFIG_HWMON, CONFIG_THERMAL and my
>> linux config (3.8.13)
>> I2c works:
>>
>> # i2cdump 1 0x48
>> No size specified (using byte-data access)
>> WARNING! This program can confuse your I2C bus, cause data loss and worse!
>> I will probe file /dev/i2c-1, address 0x48, mode byte
>> Continue? [Y/n]
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
>> 00: 0f f8 80 00 20 00 05 00 49 80 05 cb 00 00 00 00    ???. .?.I???....
>> 10: 00 00 00 00 00 00 00 00 38 00 06 00 00 00 00 00    ........8.?.....
>> 20: 0f f8 80 00 20 00 05 00 49 80 05 cb 00 00 00 00    ???. .?.I???....
>> 30: 00 00 00 00 00 00 00 00 38 00 06 00 00 00 00 00    ........8.?.....
>> 40: 00 00 80 00 20 00 05 00 49 80 05 cb 00 00 00 00    ..?. .?.I???....
>> 50: 00 00 00 00 00 00 00 00 38 00 06 00 00 00 00 00    ........8.?.....
>> 60: 00 00 80 00 20 00 05 00 49 80 05 cb 00 00 00 00    ..?. .?.I???....
>> 70: 00 00 00 00 00 00 00 00 38 00 06 00 00 00 00 00    ........8.?.....
>> 80: 00 00 80 00 20 00 05 00 49 80 05 cb 00 00 00 00    ..?. .?.I???....
>> 90: 00 00 00 00 00 00 00 00 38 00 06 00 00 00 00 00    ........8.?.....
>> a0: 00 00 80 00 20 00 05 00 49 80 05 cb 00 00 00 00    ..?. .?.I???....
>> b0: 00 00 00 00 00 00 00 00 38 00 06 00 00 00 00 00    ........8.?.....
>> c0: 00 00 80 00 20 00 05 00 49 80 05 cb 00 00 00 00    ..?. .?.I???....
>> d0: 00 00 00 00 00 00 00 00 38 00 06 00 00 00 00 00    ........8.?.....
>> e0: 00 00 80 00 20 00 05 00 49 80 05 cb 00 00 00 00    ..?. .?.I???....
>> f0: 00 00 00 00 00 00 00 00 38 00 06 00 00 00 00 00    ........8.?.....
>>
>> Probing for `Analog Devices ADT7410/ADT7420'...             Success!
>>     (confidence 3, driver `adt7410')
>>
>> # sensors
>> No sensors found!
>> Make sure you loaded all the kernel drivers you need.
>> Try sensors-detect to find out which these are.
>>
>> adt7410 is already built in the kernel....
>>
>> Does anybody have an idea?
>
> This driver does not auto-detect devices so they have to be
> instantiated explicitly, as explained in:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/i2c/instantiating-devices
>
> --
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
