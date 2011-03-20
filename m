From: Andrew Lyon <andrew.lyon@gmail.com>
Date: Sun, 20 Mar 2011 13:02:28 +0000
Subject: Re: [lm-sensors] no sensors on Alix 2D13 with module lm90 and
Message-Id: <AANLkTim95JUXG_6s2WFOSeRdH+19T1_PaYHZuHbAumBA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTinPOhCOkZLEfzE9cK2j3rbUTMxmfvLtm1OP7bwq@mail.gmail.com>
In-Reply-To: <AANLkTinPOhCOkZLEfzE9cK2j3rbUTMxmfvLtm1OP7bwq@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Mar 19, 2011 at 2:16 PM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Andrew,
>
> On Sat, 19 Mar 2011 14:04:42 +0000, Andrew Lyon wrote:
>> The subject sums it up really, I've just upgraded my Alix 2D13 system
>> (http://www.pcengines.ch/alix2d13.htm) from 2.6.37 to 2.6.38 and the
>> sensors have disappeared, lm90 still loads and there are no errors but
>> no sensors are detected.
>>
>> What's really strange is that there seem to have been no changes to
>> the lm90 code between the working and broken versions:
>>
>> alixbuild src # diff linux-2.6.37-gentoo-r2/drivers/hwmon/lm90.c
>> linux-2.6.38-gentoo/./drivers/hwmon/lm90.c
>> alixbuild src # diff
>> linux-2.6.37-gentoo-r2/./include/config/sensors/lm90.h
>> linux-2.6.38-gentoo/./include/config/sensors/lm90.h
>>
>> Very strange, any ideas?
>
> The LM90 and compatible are SMBus (I2C) devices. Most likely the
> underlying SMBus or I2C controller driver changed, causing the adapter
> to disappear so the lm90 driver doesn't see its device.
>
> If you can, go back to your 2.6.37 kernel, and check in the output of
> "sensors" which SMBus or I2C adapter the LM90 or compatible device is
> connected to. This is where your investigation should start. A
> comparison of the outputs of "i2cdetect -l" between both kernels (after
> loading the required i2c-dev driver) will certainly reveal something.
>
> --
> Jean Delvare
>

Hi,

Thanks for the info, I'm not sure how it happened but scx200_acb was
not enabled, with that loaded the sensors now work again.

Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
