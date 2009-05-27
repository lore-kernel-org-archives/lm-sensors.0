From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 27 May 2009 12:06:57 +0000
Subject: Re: [lm-sensors] TI TMP421 chip address
Message-Id: <4A1D2CE1.8040909@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090527091514.GB4422@ubuntu>
In-Reply-To: <20090527091514.GB4422@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On 05/27/2009 01:59 PM, Jean Delvare wrote:
> On Wed, 27 May 2009 13:08:19 +0200, Hans de Goede wrote:
>>
>> On 05/27/2009 11:15 AM, Andre Prendel wrote:
>>> Hi Hans,
>>>
>>> looking in the datasheet of the TMP421 sensor chip
>>>
>>> http://focus.ti.com/docs/prod/folders/print/tmp421.html,
>>>
>>> I saw the following addresses.
>>>
>>> TMP421  100 11xx
>>> TMP422  100 11xx
>>> TMP423A 100 1100
>>> TMP423B 100 1101
>>>
>>> But the preliminary driver of your students uses 0x2a.
>>>
>>>    /* Addresses to scan */
>>>    static unsigned short normal_i2c[] = { 0x2a, I2C_CLIENT_END };
>>>
>>> 0x2a = 010 1010b, right?
>>>
>> Right.
>>
>>> Do I misunderstand something?
>> No, what my students did in there was wrong, they only put the
>> address in there to which the sample I gave them is wired
>>
>> The addresses to scan should be:
>> static unsigned short normal_i2c[] = { 0x1c, 0x1d, 0x1e, 0x1f,
>>     0x2a, 0x4c, 0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
>>
>> But we better run those past Jean, to see if any of
>> those are dangerous to scan by default, Jean ?
>
> 0x2a and 0x4c-0x4f are very popular addresses for hardware monitoring
> chips and can be scanned. 0x1c-0x1f is something new, sensors-detect
> doesn't even scan 0x1c-0x1e at the moment, only 0x1f is scanned (for
> the Maxim MAX6650/MAX6651.)
>
> Where do the 0x1c-0x1f and 0x2a addresses come from?

 From the data sheet, the tmp421 has 2 pins which can be 0, floating or 1
and by that combination it can be made to listen on a number of addresses
including 0x1c-0x1f and 0x2a, the sample I was using (I'm mailing it to
Andre) has both pins floating resulting in it listening on 0x2a, I can
confirm atleast this part of the table from the datasheet checks out.

 > The possible
> addresses listed above by Andre were only 0x4c-0x4f.
>
> On which systems are these chips found?

Currently, none that I know of, I ordered samples for the tmp401/tmp411
(which was for an embedded system) and ordered those for the 421
too while I was at it.

> If only on embedded systems and
> not on PC, the safe option would be to only scan 0x2a and 0x4c-0x4f.

Ok, then lets do that.

> On
> embedded systems, probing won't be used anyway, so devices can be
> instantiated at any address, regardless of what the driver lists.
>

Ack.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
