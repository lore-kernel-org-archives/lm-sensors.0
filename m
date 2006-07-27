From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Thu, 27 Jul 2006 08:19:17 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <44C87705.6000301@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Sunil Kumar wrote:
> On 7/26/06, Hans de Goede <j.w.r.degoede at hhs.nl> wrote:
>>
>> Hmm, how did you measure this? According to top gkrellm on my system
>> never comes above the 0.7 percent, then again on my system the wait
>> function usually returns pretty fast.
> 
> 
> by simply staring at the gkrellm chart where it plots cpu usage and shows a
> number in %age for it as well. The jump from 2% to 4% is easily noticeable,
> particulalrly when it happens every 5 second on a quiet system, but I think
> a more detailed analysis should probably be done.
> 
> 

Ah, just about as scientific as my way.

> My worries are because abituguru_wait gets called 148 times for one
> 
> 
> So many reads actually make the case for  tight loop weaker and for
> sleeping
> stronger, because the loop actually will run 250*148~7000 times per
> update
> without doing anything useful apart from seeing if its ok to read. I am
> sure
> lesser CPUs will see more %age being used every 5 seconds. May be we can
> have someone with 1ghz cpu to monitor gkrellm with and without abituguru
> and
> report.
> 

Erm, that is incorrect twice. First of all on average it will only do
40-50 iterations in the loop. The 250 is a worst case scenario, and
appearantly in reality not enough (with your motherboard). This is
exactly why I've suggested lowering ABIT_UGURU_WAIT_TIMEOUT to 100, so
that we make the worsecase scenario burn less CPU, without slowing down
the normal case. We can lower it now, since normally all waits will
succeed within that 100, and in the few exceptions we have the sleep
now, which should be more then enough a wait for the uguru to respond if
it was distracted.

Also the CPU usage will be CPU-speed independent. This loops execution
speed is throttled by the ISA bus which runs at 7Mhz fixed. So the
execution time (and thus %age) will be the same independent of CPU-speed.


> update! So on a system running at 100 HZ, that could get translated to
>> blocking the program trying to read a sensor for 1.5 seconds.
> 
> 
> This is the unfortunate part. People with 100 hz will suffer terrible delay
> if the read state is not reached fast. But we are talking about a
> monitoring
> program, not some essential kernel component which can fail something
> critical. For 1000hz it is only 150ms. Note that it is advised to run linux
> 2.6 with HZ 1000. May be we can make the determination of how early to
> go to
> sleep based upon the value of HZ, by adjusting the difference between
> TIMEOUT and TIMEOUT_SLEEP dynamically based on HZ. Please also realize that
> with every 1 jiffy sleep, the chances of reaching the next sleep reduce
> tremendously (unless uguru has died and not responding at all...:)) But I
> have a feeling that sleep in steps of 1 jiffy is in order if loop times out
> 50 or so iterations.
> 
> Also, someone using 100 hz will never like a long tight loop in anything
> periodic like sensors because the whole point of choosing hz 100 was to
> give
> as much cpu to useful work as possible (like on a server). But, as I said,
> its an unfortunate conflicting requirement.
> 

Thats because of the unfortunate bad uGuru interface design :|
Anyways as said before could you please give the last version I mailed
you with ABIT_UGURU_WAIT_TIMEOUT changed to 100 a try, I think that will
cure most of you CPU usage problem in a nice simple and clean way.

Regards,

Hans


