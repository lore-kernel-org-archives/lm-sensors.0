From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 14 Sep 2008 17:50:41 +0000
Subject: Re: [lm-sensors] hwmon: Add a driver for the ADT7475 thermal sensor
Message-Id: <48CD4EF1.7010505@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080908174853.GG24308@cosmic.amd.com>
In-Reply-To: <20080908174853.GG24308@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans, Jordan,
> 
> Le samedi 13 septembre 2008, Hans de Goede a écrit :
>> Jordan Crouse wrote:
>>> Okay - I have generated a new patch.  I implemented all of your suggestions -
>>> the only one I had any concerns about was the hystersis (hystersis makes
>>> more sense to me as an offset rather then an absolute), but consistancy
>>> among hwmon drivers is rather more important.
>>>
>>> There is one possible issue in the patch - I pulled the decimal point
>>> from the pwmX_freq numbers since I wasn't sure if we wanted to express
>>> the number in milihertz.  If we do, then it is an easy fix.
>>>
>>> Compile tested and run on an ADT7475 platform.
>>>
>> Hi Jordan et all,
>>
>> I've given this a quick review (not as thorough as I would have liked to do but 
>> I simply don't have enough time for a really thorough review) and I've found no 
>> issues. So this patch is now:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Am I the only one seeing these warnings at build time?
> 

No as said I didn't have all that much time, so I just reviewed it I didn't 
actually try to build it (I assumed Jordan alreayd build it).

>   CC [M]  drivers/hwmon/adt7475.o
> drivers/hwmon/adt7475.c: In function ‘adt7475_update_device’:
> drivers/hwmon/adt7475.c:1043: warning: array subscript is above array bounds
> 

<snip>

> Apparently struct adt7475_data should be changed from
> 	s16 temp[6][3];
> to
> 	s16 temp[7][3];
> 

Looking closer at the code: you are completely right

Also while looking closer:

This snippet in adt7475_update_device() :

         data->temp[HYSTERSIS][0] = (u16) adt7475_read(REG_REMOTE1_HYSTERSIS);
         data->temp[HYSTERSIS][1] = (u16) adt7475_read(REG_REMOTE1_HYSTERSIS);
         data->temp[HYSTERSIS][2] = (u16) adt7475_read(REG_REMOTE2_HYSTERSIS);

Should be rewritten to:
         data->temp[HYSTERSIS][0] = (u16) adt7475_read(REG_REMOTE1_HYSTERSIS);
         data->temp[HYSTERSIS][1] = data->temp[HYSTERSIS][0];
         data->temp[HYSTERSIS][2] = (u16) adt7475_read(REG_REMOTE2_HYSTERSIS);

To avoid 1 (slow) unnecessary i2c transaction.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
