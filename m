From: Corey Minyard <minyard@acm.org>
Date: Wed, 03 Oct 2007 18:00:06 +0000
Subject: Re: [lm-sensors] [Openipmi-developer] IPMI and ipmisensors on an
Message-Id: <4703D8A6.4020503@acm.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4701E789.5020103@jordet.net>
In-Reply-To: <4701E789.5020103@jordet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Stian Jordet wrote:
> On ons, 2007-10-03 at 10:53 -0500, Corey Minyard wrote:
>   
>> Well, I lied, there was no 0.9 support in the driver, there was one 
>> thing that had to be handled a little differently.
>>
>> However, Stian gave me access to the system, and I added support.  Patch 
>> is attached, I will work on getting it into the 2.6.24.
>>
>> Thanks, Stian, for access to the system.  Patch is in your sources and 
>> currently running, but not installed in /lib/modules.
>>     
>
> Great! Thanks Corey, works perfectly. The ipmisensors module does indeed
> work, although there seems to be some bugs (while 'ipmiutil sensor' seem
> to get it right, so it should not be impossible!). But I'll take that
> with the ipmisensors author (if he someday replies to me :)
>
> Unless of course I can persuade you into making OpenIPMI IPMI 0.9
> compatible? Just kidding :)
>   
I actually have no idea how hard that would be, but I'd be willing to 
accept patches :).  Glad I could help with this.

-corey

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
