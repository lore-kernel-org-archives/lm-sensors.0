From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 07 Jul 2007 18:58:47 +0000
Subject: Re: [lm-sensors] add f71882fg sensors.conf.eg entry
Message-Id: <468FE267.8020608@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070707203611.7fc66d12@hyperion.delvare>
In-Reply-To: <20070707203611.7fc66d12@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
>>       Author: jwrdegoede
>>         Date: Sat Jul  7 18:57:07 2007
>> New Revision: 4580
>>    Changeset: http://lm-sensors.org/changeset/4580
>>
>> Modified:
>>    lm-sensors/branches/lm-sensors-3.0.0/etc/sensors.conf.eg
>>
>> Log:
>> add f71882fg sensors.conf.eg entry
> 
>> +# Fans
>> +    label fan1        "CPU"
>> +    ignore fan2
>> +    ignore fan3
>> +    ignore fan4
> 
> I don't think that having ignore statements by default is a very good
> idea. I can already hear users asking on the mailing list where are
> their missing fan values. The entries in sensors.conf.eg should be
> relatively generic.

Good point, I guess the motherboard may haven connectors, I just haven't 
plugged anything in. I'll try to see how the connectors are labeled this monday 
and update sensors.conf.eg accordingly.

> If you have a good configuration file for your
> motherboard, better add it to the wiki.
>

Already done :)

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
