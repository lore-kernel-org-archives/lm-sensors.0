From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Porting the fscpos driver to 2.6
Message-Id: <20041218215406.7468f9db.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041217184827.36da6d90@bart.desire.ch>
In-Reply-To: <20041217184827.36da6d90@bart.desire.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I've been using the lm_sensors fscpos driver on 2.4 kernels for quite
> a while. Since I switched to 2.6 I really miss that driver. That's why
> I decided to just try and port it. 

This is good news :)

> I'm not much of a C coder (as in "I hardly know any C") and even less
> of a kernel hacker. What I did was to see, how the lm78 driver changed
> from 2.4 to 2.6 and change the fscpos module in more or less the same
> way (and, of course, I read the porting-clients document).

I would suggest that you base your work on fscher, not lm78. fscher and
fscpos have significant similarities, it'll make your work much easier.

Also make sure you read the i2c/sysfs-interface document if you need to
add interface files the Hermes chip doesn't have.

> In order to
> get started I only tried to implement the temperature sensor. The
> module I created can now be compiled and loaded and even creates a
> directory under /sys/bus/i2c/drivers, but there's nothing in there.

I would say that your chip isn't properly detected then. If it were, you
would have a new directory in /sys/bus/i2c/devices (as I see no problem
in that part of your code). Try adding some printks in the detection
function and see where the failure occurs.

If you don't see any message, maybe you have a problem with the bus
driver. Which bus driver do you use? Are you able to see the Poseidon
chip using i2cdetect, and dump its contents using i2cdump?

> Now, I don't know whether you would be interested in a 2.6 version of
> said driver, but if so, could you please give me some advice about
> what I might be missing? The current (very ugly - contains a hell of a
> lot of commented code) version of what I did is attached to this
> message.

We are of course interested. As long as a driver still has even only a
couple users, it's worth porting it to 2.6. You never know, maybe other
people are interested but just don't know what to do.

What you have here looks promising. Take a look at the fscher driver for
hints on how you can clean things up (the 2.4 driver might not be
exactly clean, the 2.4 version of old drivers like this one rarely are).
Once you find what the problem was, adding the next interface files
shouldn't be too hard.

-- 
Jean Delvare
http://khali.linux-fr.org/
