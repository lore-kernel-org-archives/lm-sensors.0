From: sylvain@gomjabbar.ath.cx (Sylvain Jeaugey)
Date: Thu, 08 Jun 2006 07:51:32 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <Pine.LNX.4.62.0606080940500.1376@gomjabbar>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Wed, 7 Jun 2006, David Hubbard wrote:

>> Mapping fans...setting all PWMs to 100%
>>      fan 1 2083 RPM:
>>          pwm1 RPM highly variable? ignored.
>>          pwm2 2136 RPM
>>          pwm3 2109 RPM
>
> The highly variable message and the fact that it didn't find anything
> here just means that the fan1 input isn't connected to any of the
> pwms. That's what you said here, right?
Not exactly. My PSU has got a fan connector, so that I can monitor my 
PSU's RPMs. But on this fan connector, only the RPM wire is connected (and 
the ground I believe). Plus, the reported RPMs are quite .. variable (some 
glitches at 20000-30000 RPMs sometimes). So maybe pwm1 does affect fan1, 
but I'll need using a standard fan to test that (I just received it !).

About fan3/ pwm3, I only have 2 fans.

> Okay, so it starts testing the fan 2 - pwm2 stuff:
>
>> Testing fan 2 - pwm2 ... div OK, PWM/DC OK
>> Failure: 50% 3479 RPM, disabled (100%) 3515 RPM.
>
> What that means is that it set pwm2 to 50, then measured the RPM (3479
> RPM). Then it disabled pwm2, which should set pwm2 to 100. It got 3515
> RPM. That's not a significant change. However, I wouldn't say the
> disabled mode is broken. I'd say that the regression test script isn't
> robust enough, and should maybe take more samples at 50% before
> disabling and sampling at 100%. Anyway, I'll tweak it and see if the
> problem goes away. One thing is--the more samples it takes, the longer
> the script takes to run. :-(
Mmm. When the script ended, it left my fan speed at 100% (huge noise). So 
I had to rapidly figure out how to set fan speed down to 20%. I tried 
doing
$ echo 27 > pwm2
It didn't work. I messed a little with pwm2_enable / pwm2_mode (setting 
their values to other ones, then setting them back to original) and 
retried setting pwm to 27. This time, the fan slowed down.
I'll need to do further testing to understand what's going on.

After it worked, I could set my fan speed from 40 to 255 and hear the fan 
accelerate slowly.

> I'm still thinking about the best way to test all this stuff. But I
> like getting test results!
No problem, I like controling my fan so precisely :)

Sylvain

