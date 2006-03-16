From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Thu, 16 Mar 2006 11:11:26 +0000
Subject: [lm-sensors] alarm files one file per sensor vs file with
Message-Id: <441947DE.40800@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <441940D4.2050107@hhs.nl>
In-Reply-To: <441940D4.2050107@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On 2006-03-16, Hans de Goede wrote:
>> Jean I would like to submit a version of the abituguru for merging, but
>> I would like to modify it (if needed) to match your decision on this
>> first. Can you take a decisision on this please?
>>
>> Or shall I just submit the abituguru driver as is and submit an update
>> if needed later?
> 
> No, let's decide now and have your driver follow that decision right
> away, that's less work for everyone, and will let you do the user-space
> part faster too.
> 

I agree, but I didn't know if you were ready to take a decission.

> We will go with individual alarm files, as I had been proposing. I will
> not have the time to submit a new documentation patch before next week,
> but basically it's just what my previous patch was saying. Follow the
> same naming scheme for beep, alarm_mask and shutdown (the later two
> being only used by your driver AFAIK.)
> 

Ok,  got a link handy to the patch you're talking about? Otherwise I'll 
scim the archives.

> Hans, I'd like to thank you for your constructive criticism with regards
> to this technical choice we had to make. 

You're welcome.

> Now I understand that its not the best thing that could happen for your
> abituguru driver, but this is really only one driver amongst four
> dozens, and almost all other drivers will be better with this approach.
> 

I understand, no problem, this will delay the uguru patch a bit though, 
I have to find some time todo this, probably not before next week.

> sorry for being slow

No problem, processes like these take time


Thanks & Regards,

Hans

