From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 07 Jun 2006 21:19:36 +0000
Subject: [lm-sensors] [PATCH] Fix the AMD756 SMBus Controller hang
Message-Id: <448742E8.3080905@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485AD8C.5010906@sh.cvut.cz>
In-Reply-To: <4485AD8C.5010906@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

> I don't like it. This is basically doubling the amount of sleep time
> for all simple transactions. For HZ0, this means 10 ms of
> additional delay per transaction. For an EEPROM dump, this means 5
> seconds instead of 2.5 seconds, this makes a big difference. This is
> true also for I2C/SMBus hardware monitoring chips with a large number of
> registers.

Typical system has HZ 250 which is 4ms of wait. so like 1s all in all.
But more likely there is aneed to read 30 registers every 2 seconds
or so so it should be still enough.

> Given that the problem was only reported on one system by one user,
> it's quite a high price to pay, don't you think? I'd like this to be
> investigated further. Can we find other reports which could be related
> to the same problem? If not, why this one system has the problem when
> others don't? If we can understand that, maybe we can add the delay
> only when it is really needed, this would limit the impact of the
> change and make it more acceptable.

Well we cannot detect it, nor we know more. We know that this fixes the problem.
Given by cut & paste design of smbus controller it is likely to have this 
problem with others...

> Rudolf, I also see that you alreay applied this change to lm_sensors
> CVS, with the mention "backport of 2.6". That's not the right way to do
> it, sorry. For one thing you can't technically backport something
> before it was accepted and applied. For another, non-critical fixes
> should really get some broad testing in 2.6 before being actually
> backported.

Well I consider it critical because the bus will stop working at all. The delay
is anoying but "better safe than sorry"

Is anyone here with AMD southbridge for further testing?

Regards
Rudolf


