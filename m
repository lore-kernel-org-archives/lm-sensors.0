From: Ed Lucas <ejl@eberian.com>
Date: Thu, 29 Mar 2007 14:18:57 +0000
Subject: Re: [lm-sensors] Motherboard-specific configurations (sensors4mobo)
Message-Id: <460BCAD1.1070700@eberian.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46084A44.4070101@eberian.com>
In-Reply-To: <46084A44.4070101@eberian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Folks,

Ivo Manca wrote:
...
> One thing I noticed, looking through your code, was the fact that your 
> script is capable of finding multipe matches. I wonder whether or not 
> this is something we want to have there?
> Giving a random, unique DMI string, there should only be one possible 
> configuration, unless the dmistrings are bogus.
>
> It is possible that users want to improve the config, but then he or 
> she should just modify the existing and upload it, isn't it?
> So I don't really see a point of supporting more matches. Maybe I'm 
> overlooking something.
Erm, that was speculative - The fear was that a BIOS update might change 
the dmidecode info. In that case, it would be cleanest to allow multiple 
matches in the one file instead of forcing users to create duplicate 
sensors.conf files for each BIOS.

I don't know if this is actually a real risk or not. Has anyone found 
BIOS updates changing the six key parameters?


>> I have also added a "tags" field in which you can add a fixed set of 
>> tags to describe the file: so far I have thought of "broken", 
>> "experimental" and "beta". Perhaps this goes some way 
>> towardsemulating your "unsure" database flag, Ivo? I went for the 
>> name "tags" rather than "status" so that other info could be added 
>> with minimal api changes. This is more for my sensors overlay work, 
>> so feel free to disregard it if it doesn't fit your goals.
>
> Sounds good. Maybe add a final as well?
I was thinking it would be easier to make that implicit? i.e. only add a 
tag in the special cases. It might well be worth putting in though, as a 
seal of approval.


>> Can anyone point me towards a description of the "dynamic chips 
>> support" for libsensors that Jean mentioned. (Sorry, my googling 
>> failed on this).
>>
>> For motherboard specific sensors.conf files, would it make sense to 
>> use the same fan labels that are used in the manual and on the 
>> motherboard itself? (What is the offical naming policy? - grepping  
>> sensors.conf shows a range of names)
>
> I've seen it being mentioned various times, but I don't think I can 
> help you out with it.
I will keep looking.

Gook luck,
    Ed


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
