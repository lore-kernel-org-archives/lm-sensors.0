From: kress@hal.saar.de (Michael Kress)
Date: Mon, 16 Oct 2006 21:45:24 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors
Message-Id: <4533FD74.2050404@hal.saar.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:
> The previous version of the pc87427 driver (i2c-isa-based) should work
> on 2.6.9 with minor adjustments, but I admit I'm not really interested
> in you testing this, as the version of the driver which will be merged
> is the platform-based one anyway.
>   

yes, I can understand that.

>> I can't get another kernel than 2.6.16, because all the xen patches rely
>> on this version and I need xen.
>> I will try the newest from the 2.6.16.y series, give me another day to
>> try it, I think xen provided the oldest 2.6.16 one it could find. I'll
>> tell you if I got further with that.
>>     
>
> OK, thanks.
>   

Sorry, I can't get .29 running under xen-3.0.2. The whole thing
compiles, but doesn't boot properly.
I didn't have the time to fiddle about getting it booted, just had time
to check the basics, but it was no use, so I had to skip the test, sorry.

>> Maybe it's also related with the "nobody cared" phenomena from
>> http://www.ussg.iu.edu/hypermail/linux/kernel/0610.1/0101.html - I
>> suspect the irq issue to be Supermicro related.
>>     
>
> I see no relation between the two problems.
>
> Anyway my plan is now to get my pc87427 driver in -mm. If others report
> the same problem you had, we'll have more data points to investigate.
>   

Good idea, as "release! release! release!" is one of the principles of
Open Source. So release it! :)

Sorry, can't be no good help today.

ciao - Michael

P.S.: I changed the subject :)

-- 
Michael Kress, kress at hal.saar.de
http://www.michael-kress.de / http://kress.net
P E N G U I N S   A R E   C O O L


