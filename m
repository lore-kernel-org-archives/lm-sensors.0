From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 28 Feb 2016 15:38:29 +0000
Subject: Re: [lm-sensors] Datasheet for Fintek F71868a
Message-Id: <56D31475.3000308@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT147-W1A9746D160B8ED3C0290AB3A40@phx.gbl>
In-Reply-To: <SNT147-W1A9746D160B8ED3C0290AB3A40@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/28/2016 03:46 AM, Fulcrum wrote:
>
>
> On 02/25/2016 01:56 PM, Guenter Roeck wrote:
>> On 02/23/2016 01:40 AM, Foxtrot Mike wrote:
>>> Hi everybody
>>>
>>> I have an MSI MB with fintek F71868a chip for hardware monitoring. As
>>> you might know, this chip is currently not suported by Linux. I was
>>> going through the source code of F71805f chip driver and realized that
>>> I might be able to write a driver for the F71868a chip. Atleast, I
>>> should give it a try.
>>>
>> Did you try the f71882fg driver with a recent kernel version ?
>>
>> Guenter
>>
>
> Hi
>
> I did try the F71882fg driver. I was going through the source code of this driver and realized that F71686a is mentioned in multiple arrays and structures in the source code yet still you have to force the driver for f71686a chip using another chip's ID. You have to forcefully load this driver for F71868a chip using:
>
> #modprobe f71882fg force_id=0x1007
> or
> #modprobe f71882fg force_id=0x1106
>
> 0x1007 is the chip ID of F71869a, and,
> 0x1106 is the chip ID of F71868
>
> Referring to 'linux-4.4.2/drivers/hwmon/f71882fg.c', I found that:
>
> 1- Towards the top of the driver, the chipset ID of F71686 is mentioned. The ID of F71868a is not given.
>
So what is the chip ID of your chip ? There is no "F71868" chip as far as I know.
Sure, one could nitpick that the constant is not named SIO_F81866A_ID but
SIO_F81866_ID, but usually we are not that picky. The chip ID for F71868A
is supposed to be 0x1106.

Guenter

> 2- You'll find entries against F71868a in multiple arrays (f71882fg_names[], f71882fg_has_in[] f71882fg) in the driver code. There is no entry against F71868 in any array.
>
> 3- Not all the registers of F71882fg and f71868a are the same. For example, register 69h is reserved for F71868a but in case of F71882fg, it refers to 'F71882FG_REG_TEMP_CONFIG'
>
> I have no knowledge of driver development but the inability to autoload this driver for F71868a chip (although the source code 'seems' to support this chip) is a little baffling. May be there's a bug?
>
> Regards,
> Fulcrum
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
