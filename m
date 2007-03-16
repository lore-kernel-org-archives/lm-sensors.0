From: pinkel@gmail.com (Ivo Manca)
Date: Fri, 16 Mar 2007 13:06:08 +0000
Subject: [lm-sensors] Sensors-detect with DMI detection
Message-Id: <002b01c767cb$de49d0b0$0901a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
In-Reply-To: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey Jean,

Just a few more questions from our side ;).

First of all, is it good idea to scan for sensors in the CPU's after our 
script successfully finds a match with the DMI information?
If we don't do this, the user might have a disadvantage using the new way of 
detection, since the DMI information will only used be for mainboard 
information.
However, we are not completely sure if the CPU detection is currently 
completely safe. Do you have any idea about that? Because if it isn't, it 
might not be a good idea to "just" let that also run.

Secondly, do you prefer using the local database (/cache, which contains the 
dmi-info versus configuration) as the default option, or to prefer it when 
the default option fetching the online database first?

Downloading the online database is a big pro, since faulty and new 
configurations can be fixed and updated.

Just wondering what you think about it.

You were also saying that you could provided quite some more DMI strings to 
complement the list Rudolf send earlier. Could you please do that? Would be 
nice to find out about strange exceptions in an early stage ;).

Thanks in advance,

Ivo Manca
Gijs van der Weg
Jasper Alias


----- Original Message ----- 
From: "Jean Delvare" <khali at linux-fr.org>
To: "Hans de Goede" <j.w.r.degoede at hhs.nl>
Cc: <lm-sensors at lm-sensors.org>
Sent: Thursday 1 March 2007 9:54
Subject: Re: [lm-sensors] Sensors-detect with DMI detection


> Hi Hans,
>
> On Thu, 01 Mar 2007 09:13:36 +0100, Hans de Goede wrote:
>> Jean Delvare wrote:
>> > It might be non-trivial to determine which fields contain relevant
>> > information and which do not. If the fields are empty it's clear they
>> > aren't relevant, but sometimes vendors put random crap in the fields
>> > instead, such as "None" or "System Manufacturer" or "To Be Filled By
>> > O.E.M.". Anyway, as Hans suggested, we don't really need to find out
>> > which fields are most relevant. We can use all four fields as the key
>> > to identify the motherboard, if parts of the key aren't meaningful it
>> > doesn't really matter.
>>
>> Exactly, except when the whole key isn't relevant, iow all 4 Fields
>> contain crap / are to generic to uniquely identify a motherboard.
>
> True, this kind of board exists :(
>
>> That is why we need a queue on the website for new motherboard dmi-info
>> + lm-sensors-config submissions, and that queue needs to be checked
>> manually, we cannot expect well meaning end-users to make the decission
>> of the DMI info is unique enough. And on top of that a rating system
>> where people can say, good config works for me too, or crappy config
>> doesn't work.
>
> Another approach is to let the submissions go through but in an
> "unconfirmed" state. If two unconfirmed sumbissions have the same DMI
> signature but list different drivers, we demote them to state "bogus"
> or something similar.
>
> Anyway, I don't really care about the exact implementation, it's up to
> your students. Now that they are aware that the DMI data might not be
> 100% reliable, I'm certain they'll come up with a solution.
>
> -- 
> Jean Delvare
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors 


