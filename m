From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 14 Aug 2012 08:21:29 +0000
Subject: Re: [lm-sensors] Please reconsider SCH5514
Message-Id: <502A0A89.3040407@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c966e4f2e75e94e9ebf54ef8b7a6237d.squirrel@libra-investments.com>
In-Reply-To: <c966e4f2e75e94e9ebf54ef8b7a6237d.squirrel@libra-investments.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 08/13/2012 10:02 PM, Guenter Roeck wrote:
> On Mon, Aug 13, 2012 at 11:17:55AM -0700, Norbert Schlenker wrote:
>>> Hello,
>>>
>>> Have you seen this: http://www.spinics.net/lists/lm-sensors/msg24621.html ?
>>>
>>> Without having full specifications it's hard to write a driver, and signing
>>> a NDA goes against open source (Non Disclosure Agrement <> Open Source).
>>>
>>> Regards
>>> Ian Dobson
>>
>> Thanks for the pointer.
>>
>> Email sent to Mark Hoffman asking if the driver was ever released.
>>
> I don't think so - I don't find one anywhere in the archives.
>
> Key problem, though, is really the lack of a data sheet. Even if someone would
> be able to get a data sheet under NDA, it might be impossible for that person
> to publish a driver, since publishing register details (as one has to when
> publishing a driver) would very likely violate the NDA.

That very much depends on the NDA, Linux driver are written based on datasheets
under NDA all of the time, it is just a matter of having both parties understand
that although the datasheet will fall under the NDA, the source of the driver
written with the help of the datasheet will not, and putting something like that
explicitly in the NDA. Note IANAL, and this is not legal advice :)

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
