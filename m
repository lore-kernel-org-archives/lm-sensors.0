From: kress@hal.saar.de (Michael Kress)
Date: Wed, 18 Oct 2006 04:37:24 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors
Message-Id: <4535AF84.3000202@hal.saar.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4533FD74.2050404@hal.saar.de>
In-Reply-To: <4533FD74.2050404@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Michael Kress wrote:
>>> I can't get another kernel than 2.6.16, because all the xen patches rely
>>> on this version and I need xen.
>>> I will try the newest from the 2.6.16.y series, give me another day to
>>> try it, I think xen provided the oldest 2.6.16 one it could find. I'll
>>> tell you if I got further with that.
>>>       
> Sorry, I can't get .29 running under xen-3.0.2. The whole thing
> compiles, but doesn't boot properly.
> I didn't have the time to fiddle about getting it booted, just had time
> to check the basics, but it was no use, so I had to skip the test, sorry.
>   

xen-3.0.3-0 is released now, it comes with kernel 2.6.16.29 and runs
flawlessly so far.
I was modprob'ing and rmmod'ing pc87427 every 2 secs for some hours now,
plus I was running bonnie++ in the background.

Between these 2 secs I was able to do a clean sensors run.

No messages, no crashes, just perfect. You never know, but so far, even
my irq messages about "nobody cared" are gone.

Greetings - Michael

-- 
Michael Kress, kress at hal.saar.de
http://www.michael-kress.de / http://kress.net
P E N G U I N S   A R E   C O O L


