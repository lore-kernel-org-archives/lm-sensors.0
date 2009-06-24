From: Andre Prendel <andre.prendel@gmx.de>
Date: Wed, 24 Jun 2009 09:26:31 +0000
Subject: Re: [lm-sensors] Another possible hwmon project
Message-Id: <20090624092631.GC4949@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090624081700.GB4949@ubuntu>
In-Reply-To: <20090624081700.GB4949@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

D'oh! Forgot to CC Jean.

On Mon, Jun 22, 2009 at 12:03:13AM +0200, Hans de Goede wrote:
>
>
> On 06/21/2009 10:35 AM, Andre Prendel wrote:
>> On Fri, Jun 19, 2009 at 09:15:39AM +0200, Hans de Goede wrote:
>>> Hi,
>>
>> Hi Hans,
>>
>> First, sorry for bad response times. I'm very busy with private stuff
>> at the moment. I'll change the company I'm working for. This is
>> related with moving back to my hometown (Dresden).
>>
>
> Ok, np.
>
>>>
>>> <snip>
>>>
>>>> Thanks for all the material. I read some stuff about DMI and SMBIOS
>>>> yesterday. Further I checked out the dmidecode source code. I will
>>>> go on with investigation by reading the mailing list discussions etc.
>>>>
>>> I don't think you need to dig that deep wrt DMI,
>>
>> I want to know how things work at low level. This makes things easier
>> to understand for me.
>>
>>> what we will most likely
>>> and up doing is looking for the strings found inside
>>> /sys/devices/virtual/dmi/id/board_name
>>> /sys/devices/virtual/dmi/id/board_vendor
>>
>> I can't see these files in sysfs. What driver is responsible for creation?
>>
>
> Hmm, strange, I dunno on all my systems they just exists. Weird, maybe you
> are running a somewhat old kernel ?

Ok, I've found the files on my system under /sys/class/dmi/id/. Driver
/drivers/firmware/dmi-id.c creates the files. The driver was
introduced in 2007.

Jean, could you bring some light into the darkness? I've seen you did
some work on the DMI stuff.

I'm using the most recent mainline kernel form git. Hans, what version
do you use?

BTW, Jean. Hans asked me for working on the automatic configuration of
sensors using DMI information.

>>> Which contain the DMI info in 100% ready for use fashion (as
>>> plain ASCII strings)
>>>
>
> Regards,
>
> Hans

Thanks,
Andre

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
