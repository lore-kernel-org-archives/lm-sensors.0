From: Nick Pasich <NewsLetters@NickAndBarb.net>
Date: Thu, 08 Jan 2009 18:53:06 +0000
Subject: Re: [lm-sensors] abituguru3: no Abit uGuru3 found
Message-Id: <49664B92.3090208@NickAndBarb.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <49657F3B.3060607@NickAndBarb.net>
In-Reply-To: <49657F3B.3060607@NickAndBarb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I applied the patch after applying your 2 other patches:

1) "eliminating whitespace"
2) "Switch the AW9D-MAX over from port probing to the
    preferred DMI probe method".

The patch applied and the module loaded without any problems.

Syslog Entry:
Jan 8 10:49:36 localhost kernel: abituguru3: found Abit uGuru3, 
motherboard ID: 001A


Thank You Guys Very Much,

    Nick Pasich

Alistair John Strachan wrote:
> On Thursday 08 January 2009 17:09:43 Jean Delvare wrote:
>   
>> On Thu, 08 Jan 2009 13:02:38 +0100, Hans de Goede wrote:
>>     
>>> Nick Pasich wrote:
>>>       
>>>> No BIOS update....
>>>>
>>>> Here's the output from "dmidecode" Attached...
>>>>         
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
>>>       
>> Might be worth reading this discussion thread again:
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-October/024522.html
>>
>> We gave up on fixing it back then, but apparently there really is a
>> need. Alistair, do you have a patch?
>>     
>
> I think the consensus we came to at the time was to switch to strncmp'ing a 
> subset of the DMI string, but in this case we'll need strncasecmp. This isn't 
> too terrible as false positives are pretty unlikely (we already check the 
> board manufacturer too, which does seem to be unchanging). Hans?
>
> Of course, if Abit start putting arbitrary spaces and hyphens into the names 
> too, all bets are off. But I read that their motherboard division was ceasing 
> operation soon so (alas) this shouldn't be a problem. :-)
>
> Find attached a patch that should fix it (Nick, please test this if you can).
>
> Jean, there's another DMI patch tested by Paul Hartman I've been holding onto. 
> I'll send you a proper version of the patch in this email and the other DMI 
> patch ASAP.
>
>   

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
