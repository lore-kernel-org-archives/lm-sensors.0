From: grant_lkml@dodo.com.au (Grant Coady)
Date: Wed, 08 Jun 2005 04:23:28 +0000
Subject: [lm-sensors] (fwd) Re: 2.6.12-rc6-mm1
Message-Id: <8ilca11skni4v3pop6br8ea9o8imnfes16@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 7 Jun 2005 22:59:52 -0300, S?ren Lott <soren3@gmail.com> wrote:

>On Tuesday 07 June 2005 08:29, Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc6/2.
>>6.12-rc6-mm1/
>
>[snip]
>
>> +gregkh-i2c-i2c-Kconfig-update.patch
>> +gregkh-i2c-i2c-pcf8574-cleanup.patch
>> +gregkh-i2c-i2c-adm9240-docs.patch
>> +gregkh-i2c-i2c-device-attr-lm90.patch
>> +gregkh-i2c-i2c-device-attr-lm83.patch
>> +gregkh-i2c-i2c-device-attr-lm63.patch
>> +gregkh-i2c-i2c-device-attr-it87.patch
>> +gregkh-i2c-hwmon-01.patch
>> +gregkh-i2c-hwmon-02.patch
>> +gregkh-i2c-hwmon-03.patch
>>
>>  i2c tree updates
>>
>> +i2c-chips-need-hwmon.patch
>> +gregkh-i2c-hwmon-02-sparc64-fix.patch
>>
>>  Fix a few things in the i2c tree
>
>[snip]
>
>after those changes i don't get entries in /sys for my W83627THF chip. 
>(p4c800-D, i875,ICH5)
>
>relevant config parts:
>
>CONFIG_HWMON=y
>CONFIG_I2C=y
>CONFIG_I2C_ISA=y
>CONFIG_I2C_SENSOR=y
>CONFIG_SENSORS_W83627HF=y
>
>thanks.
>
>-SL
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

