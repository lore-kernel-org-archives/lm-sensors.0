From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 06 Jul 2014 08:16:41 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 1/2] hwmon: (adm9240) Avoid forward declaration
Message-Id: <53B905E9.5040702@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404395989.4895.12.camel@phoenix>
In-Reply-To: <1404395989.4895.12.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/06/2014 12:29 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sat, 05 Jul 2014 11:48:55 -0700, Guenter Roeck wrote:
>> On 07/05/2014 11:20 AM, Jean Delvare wrote:
>>> The main problem I see is that for I2C_SMBUS_BLOCK_DATA reads, the chip
>>> first returns the number of data bytes (as opposed to
>>> I2C_SMBUS_I2C_BLOCK_DATA where the controller decides how many bytes it
>>> wants to read.) There is no way the i2c-stub driver can guess that byte
>>> count, as it depends on the chip it is supposed to emulate (and might
>>> even change dynamically, at least in theory.)
>>>
>>> We could have limited support for that, but that would require extra
>>> module parameters to specify the block size for every register offset
>>> on which SMBus block reads can be attempted. This also assumes that these
>>> block sizes are static. And as you found out, that may also require
>>> allocating extra memory for every such register offset.
>>
>> I 'solved' the problem so far by only returning smbus block data after
>> it was written into a specific command. This way it is all dynamic.
>
> This is smart :-) But this assumes that block size is the same the same
> in both directions for a given register offset. This also assumes that
> block sizes do not change over time. But anyway, i2c-stub is bound to
> have such limitations, it can only emulate simple devices.
>
>>> But another difficulty is also that when SMBus block reads enter the
>>> game, the usual read/write symmetry tends to disappear. Often the
>>> registers you read with SMBus block read commands are also readable and
>>> writable at individual register addresses. i2c-stub has no way to know
>>> that. Drivers would typically use SMBus block reads for performance
>>> reason, but byte writes for convenience. So drivers operating on top of
>>> i2c-stub would get confused in no time.
>>>
>>> All these issues have so far convinced me that adding support for SMBus
>>> block read/writes to i2c-stub wasn't worth it. That being said, if you
>>> have a specific chip in mind that could be supported easily, I have no
>>> objection.
>>
>> The one I needed it for right now was lineage-pem; it was useful for me
>> since I don't have easy access to the HW anymore. Of course, problem with
>> that is what you pointed out ... with my change in the i2c-stub driver,
>> the lm93 driver now assumes that it can execute block commands. The only
>> way I see around that would be a module parameter.
>
> Actually there already is one, named "functionality". For now it can
> only be used to disable commands, because all supported commands were
> enabled by default. It would be trivial to separate the full command
> set from the default command set. That way SMBus block commands can be
> supported but not enabled by default.
>
>> That would have to be
>> one which selects if the smbus block command should be treated similar
>> to the i2c block command
>
> Do you know of any device actually behaving that way?
>
No, I thought the lm93 would do that, but as you probably know it is much
more complicated than that; I don't think it would be easy to simulate,
so I won't even try.

>> or as individual command blocks. I'll play around
>> with it some more. I'll send a patch if I find a solution which works for
>> both lm93 and lineage-pem and is not too complicated.
>
> The change I suggested to the "functionality" parameter should do.
>

Agreed.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
