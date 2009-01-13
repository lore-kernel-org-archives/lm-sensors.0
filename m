From: Olivier Hochreutiner <olivier.hochreutiner@gmail.com>
Date: Tue, 13 Jan 2009 14:28:57 +0000
Subject: Re: [lm-sensors] [PATCH] GPIO output support for LM93 kernel driver
Message-Id: <f967eaa30901130628j25e0b2adq7fb5016a5db5ccb6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <f967eaa30901120805y5628259co8e58e6568d677f63@mail.gmail.com>
In-Reply-To: <f967eaa30901120805y5628259co8e58e6568d677f63@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>> I have been using the LM93 kernel driver and I noticed that 'gpio'
>> file in sysfs is read-only and that the GPIO pins of the LM93 chip can
>> be used as input only.
>> I attached a patch that allows to also use GPIO pins as output, by
>> simply writing to 'gpio' in sysfs. The patch is against the current
>> git revision of the mainstream kernel.
>> I did not handle the case where the GPIO pins are used as inputs after
>> being used as output (in which case, according to the datasheet, 0s
>> should be written to the GPO register, and thus 1s should be written
>> to the 'gpio' sysfs file). Also, if some pins are used as inputs and
>> others as outputs, then, when writing to the 'gpio' file in sysfs, the
>> pins used as inputs should be set to 1 (so that the corresponding bits
>> in the GPO register are set to 0).
>>
>> Comments are welcome.
>
> IMO gpiolib would be better and more generic solution instead of creating
> some custom sysfs entry...

The sysfs entry already exists (and is present the mainstream kernel),
so that's why I preferred to use it. I don't think the sysfs entry
will be removed anyway, or will it ?

Olivier

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
