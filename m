From: Gabriel C <crazy@frugalware.org>
Date: Wed, 23 Apr 2008 15:50:47 +0000
Subject: Re: [lm-sensors] ASUS P5E-VM DO and unknown chip with ID 0x0b00
Message-Id: <480F5AD7.9020502@frugalware.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <48077504.4000905@frugalware.org>
In-Reply-To: <48077504.4000905@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Wed, 23 Apr 2008 11:03:14 +0200, Gabriel C wrote:
>> Rudolf Marek wrote:
>>> Hi Gabriel,
>>>
>>> Please send us a dsdt table. You can use following commands:
>>>
>>> cat /proc/acpi/dsdt > /tmp/dsdt.bin
>>> cd /tmp
>>> iasl -d dsdt.bin
>>>
>>> To obtain a text based table (dsdt.asl/dsl)
>> Sorry for the lag.
>>
>> There the dsl file :
>>
>> http://frugalware.org/~crazy/ASUS_P5E-VM_DO/dsdt.dsl
> 
> Lots of hardware monitoring-related code in there. I suggest that you
> do not load the w83627ehf driver on this machine. The ACPI BIOS is
> supposed to take care about your hardware.

Ok will unload it.

> 
> Maybe we could write an ACPI driver for your motherboard... I see the
> ATK0110 ID,

I think all newer ASUS motherboards got that ATK0110 ID.

> I seem to remember someone had written an experimental
> driver for it. Rudolf should know more.
>

Do you mean this one ?

http://lkml.org/lkml/2007/5/13/209

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
