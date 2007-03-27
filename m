From: "Ivo Manca" <pinkel@gmail.com>
Date: Tue, 27 Mar 2007 16:07:38 +0000
Subject: Re: [lm-sensors] Motherboard-specific configurations (sensors4mobo)
Message-Id: <008901c7708a$0c0c5100$0901a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <46084A44.4070101@eberian.com>
In-Reply-To: <46084A44.4070101@eberian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey Jean,

Sorry if it sounded like "Jean will just make enough time available to fix 
it all", I didn't mean that :)

Anyway, I agree that having more than one project is everything but 
desireble. Since we started to add these functions to sensors-detect anyway, 
I think it is best if we just continue with it and take the best practices 
from the other projects. I think it is also the best if this functionality 
is added to the sensors-detect script, instead of (multiple?) other scripts.

So, thanks for your time, and you'll be hearing from us every now and then,

Ivo
----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "Ivo Manca" <pinkel@gmail.com>
Cc: "Ed Lucas" <ejl@eberian.com>; <lm-sensors@lm-sensors.org>; "Weg, G. van 
der" <g.vanderweg@student.hhs.nl>; <J.W.R.deGoede@hhs.nl>
Sent: Tuesday 27 March 2007 17:39
Subject: Re: [lm-sensors] Motherboard-specific configurations (sensors4mobo)


> Hi Ivo, Ed,
>
> Ed, please fix your Reply-To.
>
> On Tue, 27 Mar 2007 08:03:58 +0200, Ivo Manca wrote:
>> We (three students from the Netherlands) are running quite a similar 
>> project
>> right now: adding DMI support to sensors-detect, which tries to find a 
>> match
>> with a local-database, then extracts the corresponding configuration. It
>> sounds quite like the project you made.
>>
>> I don't have time to look into the software you made right now, but I 
>> will
>> tonight. But it sounds like it is at least "very useful".
>>
>> I wonder what Jean (and ofcourse: everyone else) will think about it,
>
> Jean didn't have enough time to look into one project, he hardly has
> more time looking into two :( So I'll leave it up to you (Ivo and Ed)
> and Hans to pick the best ideas and come up with one common solution. I
> really don't think we want to have two or more projects doing the same
> thing.
>
> As Hans underlined earlier, getting the dynamic chips support in
> libsensors first should address a number of problems.
>
> Thanks,
> -- 
> Jean Delvare 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
