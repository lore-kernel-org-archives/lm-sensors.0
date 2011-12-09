From: =?iso-8859-1?Q?Bj=F6rn_Gerhart?= <oss@extracloud.de>
Date: Fri, 09 Dec 2011 20:12:50 +0000
Subject: Re: [lm-sensors] [PATCH] f75375s: added Fintek f75387 support
Message-Id: <E3219EEB-223B-44CF-9CBE-ED212FE71BE4@extracloud.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABRa2TKyTHBSZiWMxZZqC2Y=ZZNTQQt_3BXTrt6JzQzj0OsfNw@mail.gmail.com>
In-Reply-To: <CABRa2TKyTHBSZiWMxZZqC2Y=ZZNTQQt_3BXTrt6JzQzj0OsfNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

2011/12/8 Guenter Roeck <guenter.roeck@ericsson.com>:
> Hi Bjoern,
> 
> On Thu, Dec 08, 2011 at 05:04:54PM -0500, Bjoern Gerhart wrote:
>> Hi Guenter,
>> 
>> so for solving the other issues you mentioned, I'd first apply your
>> set of 4 patches on the original f75375s. Then I'd implement my f75387
>> related modifications within your latest review proposals, test the
>> resulting binary module on my f75387 hardware and then create a fifth
>> patch.
>> 
>> Would that order lead to a valid set of patches?
>> 
> Yes, that would be the best way to proceed, only it is 5 patches by now.
> Did I copy you on the last one ?
> 
Yes - today I noticed that I already had received your latest (fifth) f75375s related patch.

> If you use git, it should be straightforward to merge your patch on top of mine.
> I would have done that, only I had trouble applying yours because it was somehow
> corrupted.
> 
I'm not quite familiar with using git yet, so up to now using the classical diff / patch commands for creating and applying patches. It seems that the googlemail web interface inserts line feeds after about 70 characters, which leads to the corrupted patch. I try another mail client for the next patch to send...

> Of course, it would also help tremendously if you would fine the time to review
> my patches :).
> 
Yeah, I reviewed each of the f75375s related patches. Beside the functionality stuff and improved error handling I noticed some guideline related improvements also. But in fact I could not detect nonconformities or code fussiness, so there's no idea for improvements on my side.

> Thanks,
> Guenter

--
Bjoern Gerhart


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
