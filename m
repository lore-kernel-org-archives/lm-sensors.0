From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: [PATCH 2.6] w83781d fan_div code refactoring
Message-Id: <1080723615.406a889f428ff@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040317220839.373babf0.khali@linux-fr.org>
In-Reply-To: <20040317220839.373babf0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

According to Mark M. Hoffman:

> I disagree, but I see that I'm a little late on this one since
> patches have already been accepted.

You can still propose a different solution. If we tend to agree that
it's better, there's no reason we wouldn't change from "my" method to
yours. My main concern was to have a specific issue fixed. Now that
this is done we have more time to discuss a more global solution if you
want.

> As I mention in another message, I just don't think that the update
> speed of these drivers is worth any extra code... and I really do
> mean *any at all*.

As mentioned in a previous post, it's not necessarily a matter of speed,
it's also a matter of i2c bus load.

> What is the value of returning a result 1/2 second faster using
> "sensors" at the command line?

Not much, agreed.

> More likely people are using something like gkrellm, or capturing
> the data in a script and plotting it, so they never experience that
> delay anyway.

I don't quite agree there. The fact that they don't experience the delay
doesn't mean that the load isn't there. And now that you point this
out, such uses of the drivers are quite different from runnig sensors
manually in that the values are repeatedly read. I think that for
example gkrellm users can configure it so that it updates the values
every 2 seconds or so. And most people will do, since they want to see
their CPU temperature changes in near real-time. Now you may be
refreshing all the registers of your chip (probably near 40 for some of
them) every 2 seconds. This is likely to have the chip stop quite often
for quite a long time. And in the case of a noisy-poker BIOS, the
likeliness of collisions becomes quite high. Again, my work on the
w83l785ts influences me much in my views.

That said:
1* All this probably only applies to I2C (as opposed to ISA) chip
drivers.
2* I am not going to convert all drivers to Philip Pokorny's method. It
is more like I was asking if I would start a thermonuclear war by
implementing the same in the w83l785ts driver.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
