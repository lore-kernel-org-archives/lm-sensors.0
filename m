From: stevenkaratnyk@rogers.com (Steven Karatnyk)
Date: Fri, 06 Jan 2006 19:34:29 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re:
Message-Id: <43BEC645.7070203@rogers.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Yuan,

Ymu at Winbond.com.tw wrote:
> Quoting Jim: 
>   
>> BTW - youd do well to drop the *misfortunate* posture.
>>     
> I will try to tell my HW colleagues your dissatisfaction...
> Thank you Jim ;) 
>
>   

There seems to be some sort of misunderstanding being perpetuated here.  
Let me correct it now -- when I stated "I have the misfortune of having 
the Windbond W83687THF Super I/O IC on my Soltek motherboard 
(SL-B9D-FGR)" it was never my intention to indicate dissatisfaction with 
Winbond.  That is simply not the case .  For the record, I have 
absolutely NO dissatisfaction with Winbond, and no offense was intended 
in my prior post.   I outlined in my response to Jim why I stated what I 
did, but to cut to the chase, it amounts to being little more then a 
statement of disappointment of not having native kernel level support 
for the chip. 

Now then, with any mis-understandings aside ;) :


> Sorry I have not read the w83687thf spec before, It seems a similar chip
> to w83627thf,
Yes, that is what I gathered from the earlier thread found here: 
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-June/012752.html


>  so I would like to give a patch to try make the driver
> work first. I'm not sure if it can work but I'm sure there should be a
> better solution.
>
> I would like to suggest you to download lm_sensors2 from the website,
> Install the user space tools, run sensors-detect and do what it suggest.
> Then patch your w83627hf.c with the patch attached.
> You can try using this w83627hf driver now.
>   

Thank you.  I will give it, and the info Jim provided,  a go over the 
weekend. 

Regards, SK


