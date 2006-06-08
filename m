From: david.c.hubbard@gmail.com (David Hubbard)
Date: Thu, 08 Jun 2006 01:01:05 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <4dfa50520606071801t358f0b7dn892346ea4888a69e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sylvain,

Thanks for the feedback! The ls | cut stuff is broken, I know. But
it's a quick way to check that stuff. Maybe I should just remove
it--the sysfs files wouldn't ever have wrong permissions, would they?

> I tested the module with your script. Here's the output :
> * WARNING: This will run your system fans through many possible
>             combinations. There is a possibility your system will
>             overheat. Use this script at your own risk!
> Mapping fans...setting all PWMs to 100%
>      fan 1 2083 RPM:
>          pwm1 RPM highly variable? ignored.
>          pwm2 2136 RPM
>          pwm3 2109 RPM

The highly variable message and the fact that it didn't find anything
here just means that the fan1 input isn't connected to any of the
pwms. That's what you said here, right?

> Fan 1 is my PSU fan, reporting (sometimes crazy) values, but not powered
> my the motherboard. Thus, fan control won't affect it. It's perfectly
> normal.


Okay, so it starts testing the fan 2 - pwm2 stuff:

> Testing fan 2 - pwm2 ... div OK, PWM/DC OK
> Failure: 50% 3479 RPM, disabled (100%) 3515 RPM.

What that means is that it set pwm2 to 50, then measured the RPM (3479
RPM). Then it disabled pwm2, which should set pwm2 to 100. It got 3515
RPM. That's not a significant change. However, I wouldn't say the
disabled mode is broken. I'd say that the regression test script isn't
robust enough, and should maybe take more samples at 50% before
disabling and sampling at 100%. Anyway, I'll tweak it and see if the
problem goes away. One thing is--the more samples it takes, the longer
the script takes to run. :-(

I'm still thinking about the best way to test all this stuff. But I
like getting test results!

David

