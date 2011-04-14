From: =?UTF-8?B?0JDQvdGC0L7QvSDQmtC+0YfQutC+0LI=?= <anton.kochkov@gmail.com>
Date: Thu, 14 Apr 2011 04:11:17 +0000
Subject: Re: [lm-sensors] ITE IT85xx support request
Message-Id: <BANLkTim1w4ZPKO+Dbse=YL9SQbdthEGdGg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Attached bit reversed part of code for working with ec, when do system
bios flashing (part from BIOS rom, after 'ZFLPF' signature.

http://paste.pocoo.org/show/371339/

Best regards,
Anton Kochkov.




2011/4/14 Антон Кочков <anton.kochkov@gmail.com>:
> Good day!
>
> Are there any chances to support this chip?
>
> Best regards,
> Anton Kochkov.
>
>
>
>
> 2011/3/13 Антон Кочков <anton.kochkov@gmail.com>:
>> Good day!
>> I'm have notebook with soldered in it ITE8502
>> Google notebook have IT8500 EC with hwmon
>> Is it possible add support of these chips in the lm-sensors?
>>
>> Registers description/dump, etc available in the code of superiotool
>> http://www.coreboot.org/Superiotool
>> But, as I'm have inventek-manufactured laptop i'm cant activate
>> SuperIO part of EC.
>>
>> Here is output of ectool:
>>
>> EC RAM:
>>
>> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 10: e0 00 09 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 20: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 40: 53 41 4e 59 4f 00 00 00 00 00 00 00 00 00 00 00
>> 50: 44 45 4c 4c 41 43 30 36 35 00 00 00 00 00 4c 69
>> 60: 50 00 00 00 00 00 09 00 20 00 00 00 00 00 00 00
>> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 90: 00 00 88 ff 01 10 00 16 30 30 00 00 2b 30 00 00
>> a0: 00 c0 21 00 64 00 5f 00 cb 0a cb 0a b8 0b 08 47
>> b0: 00 00 00 00 00 00 00 00 00 55 01 00 00 00 00 00
>> c0: 44 45 4c 4c 20 34 34 39 54 58 39 43 4d 00 00 00
>> d0: 00 00 00 00 00 00 f0 0b 00 00 0e 30 5c 2b 00 00
>> e0: 31 39 35 30 33 33 43 4e 30 54 4e 38 30 30 37 33
>> f0: 32 34 35 39 41 4c 30 37 33 35 41 30 30 82 b9 ff
>>
>> Also attached ACPI dump
>>
>> Simple disassembly of EC firmware attached also
>>
>> If you need something additional
>>
>> Best regards,
>> Anton Kochkov.
>>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
