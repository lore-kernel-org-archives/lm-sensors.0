From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 26 Jul 2006 20:43:37 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <44C7D3F9.3040202@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Sunil Kumar wrote:
> Hans, I have done some very rudimentary performance analysis of this driver
> and I have a feeling that some tuning may be in order. All I did was to
> look
> at gkrellm with abituguru loaded and unloaded. gkrellm updates sensors
> every
> 5 seconds (which is kinda high I think) and I see that the cpu usage is
> 0-2%
> if module is unloaded. If module is loaded the cpu usage is as high as 4%
> every 5 seconds (more than half of it red). System is quiet and nothing
> else
> is being done on it.
> 
> I suspect its to do with the while loop in abitugru_wait(). What I did was
> to make the following change on top of what you sent and cpu usage
> became 2%
> every 5 seconds. So, it remains between 0-2%.
> 

Hmm, how did you measure this? According to top gkrellm on my system
never comes above the 0.7 percent, then again on my system the wait
function usually returns pretty fast.

> I don't think there is any harm in sleeping because most sensor user
> programs are working at seconds level and we are talking about ms sleep.
> And
> in most cases first sleep for 1 jiffy will be enough. But this probably
> needs testing by our volunteers to see if there are any ill-effects,
> although it works perfectly here.
> 

My worries are because abituguru_wait gets called 148 times for one
update! So on a system running at 100 HZ, that could get translated to
blocking the program trying to read a sensor for 1.5 seconds.

However on my system the uGuru usually responds within 50 polls in
abituguru wait with 1 in 10 waits only succeeding after 90 polls. So if
we can agree to make ABIT_UGURU_WAIT_TIMEOUT_SLEEP 150 instead of 200
then I think your patch can go in to help those with uGuru's which are
slower to respond like yours is.

The 1.5 seconds mentioned above assumes 1 sleep per wait, and with your
current code it could become much more sleeps. Thinking about this some
more, with your current code it could become 200 / 150 sleeps per wait!

I think the correct fix for this would be to just lower
ABIT_UGURU_WAIT_TIMEOUT from 250 to 100 now that we have the sleep
before final try code. That way we wil not sleep more then once per
wait() and we should still get the desired effect of lowering cpu usage.
Since your last version (sleep 1 ms before final try) worked always
without errors. I'm pretty sure we can just lower
ABIT_UGURU_WAIT_TIMEOUT to 100, those missed 150 reads won't make much
of a difference timing wise when compared with that msleep(1), so things
should still work as expected. The only differences being that wait()
will go to sleep sooner, resulting in the decreased cpu usage you want.

Could you give the last version I send you with ABIT_UGURU_WAIT_TIMEOUT
changed to 100 a try? I think that should do the trick.

Regards,

Hans


