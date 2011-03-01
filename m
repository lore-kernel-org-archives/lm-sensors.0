From: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Tue, 01 Mar 2011 18:19:02 +0000
Subject: Re: [lm-sensors] f75375s detected but no temp output
Message-Id: <AANLkTinF5sD4BsWM98Jaqms5VO8M1Tc0xW0+5HVA5DTh@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimosNm7_k9scygyWZuWZPunJ=wteQ+UgFB2-Gn8@mail.gmail.com>
In-Reply-To: <AANLkTimosNm7_k9scygyWZuWZPunJ=wteQ+UgFB2-Gn8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

2011/2/6 Jean Delvare <khali@linux-fr.org>:
> On Sun, 6 Feb 2011 11:41:35 +0100, Pali Rohár wrote:
>> 2011/1/6 Jean Delvare <khali@linux-fr.org>:
>> > On Sat, 25 Dec 2010 14:15:46 +0100, Pali Rohár wrote:
>> >> Where is the problem? And why is no f75375s temp detected by lm sensors?
>> >
>> > Nvidia binary driver, right? It misses four lines of code that would let
>> > hwmon drivers bind to its I2C adapters. The code exists for 4 or 5
>> > years now, it's even included in Gentoo [1] but Nvidia never bothered
>> > applying it. Complain to them.
>> >
>> > [1] http://gentoo.zugaina.org/portage/x11-drivers/nvidia-drivers/files/NVIDIA_i2c-hwmon.patch
>> >
>> > --
>> > Jean Delvare
>> >
>>
>> Yes, I'm using nvidia binary driver. I applied this patch on nvidia
>> driver but still does not working (same problem). I checked
>> I2C_CLASS_HWMON is defined to (1<<0)
>
> In fact it looks like your hwmon chip is not on the same bus as other
> graphics cards, so you should drop the (port = 2) test in the patch,
> and just set pI2cAdapter->class = I2C_CLASS_HWMON for all adapters.
>
> --
> Jean Delvare
>

I commented code ..if ( port = 2 ).. there is only

pI2cAdapter->class = I2C_CLASS_HWMON

so it is called for every port. But sensors still not working :( Any
other hints?

-- 
Pali Rohár
pali.rohar@gmail.com

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
