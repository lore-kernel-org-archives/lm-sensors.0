From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 08 Jan 2009 19:21:35 +0000
Subject: Re: [lm-sensors] abituguru3: no Abit uGuru3 found
Message-Id: <4966523F.60809@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <49657F3B.3060607@NickAndBarb.net>
In-Reply-To: <49657F3B.3060607@NickAndBarb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Alistair John Strachan wrote:
> On Thursday 08 January 2009 17:09:43 Jean Delvare wrote:
>> On Thu, 08 Jan 2009 13:02:38 +0100, Hans de Goede wrote:
>>> Nick Pasich wrote:
>>>> No BIOS update....
>>>>
>>>> Here's the output from "dmidecode" Attached...
>>> Hmm, nasty. We've got "IP35 Pro(Intel P35-ICH9R)" as identifaction string
>>> in the driver, and your DMI table has: "IP35 PRO(P35+ICH9R)"
>>>
>>> You should be able to work around your problem (for now) by doing this
>>> (as root):
>>>
>>> modprobe abituguru3 force=1
>>>
>>> After that, please do "dmesg" and copy paste the relevant (abituguru
>>> related) lines in your mail, that will help us diagnose this.
>> Might be worth reading this discussion thread again:
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-October/024522.html
>>
>> We gave up on fixing it back then, but apparently there really is a
>> need. Alistair, do you have a patch?
> 
> I think the consensus we came to at the time was to switch to strncmp'ing a 
> subset of the DMI string, but in this case we'll need strncasecmp. This isn't 
> too terrible as false positives are pretty unlikely (we already check the 
> board manufacturer too, which does seem to be unchanging). Hans?
> 

That was my idea too, just make the dmi string stored in the driver: "IP35 Pro" 
and do a strncasecmp for the length of the string in the driver, with the one 
from the BIOS, if it is a match assume we have found an abituguru3 equipped 
motherboard.

> Of course, if Abit start putting arbitrary spaces and hyphens into the names 
> too, all bets are off. But I read that their motherboard division was ceasing 
> operation soon so (alas) this shouldn't be a problem. :-)
> 

I didn't know that.

> Find attached a patch that should fix it (Nick, please test this if you can).
> 

Yes that is exactly what I had in mind, +1 :

Reviewed-By: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
