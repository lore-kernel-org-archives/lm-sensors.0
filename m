From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 04 Mar 2006 16:02:26 +0000
Subject: [lm-sensors] new [PATCH] I2C: add new rx8025 driver
Message-Id: <20060304170226.21caf195.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060203134225.GA4398@digi.com>
In-Reply-To: <20060203134225.GA4398@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Uwe,

Sorry for the late answer.

> here comes a reworked driver (in a seperate e-mail to ease applying it).
> I didn't implemented all your suggestions, as commented below.
> 
> I didn't (yet) used Alessandro's rtc core as it doesn't compile on
> current HEAD.  (Moreover my driver has to work on 2.6.12.5, because
> that's the version our customer has to stick to.)

True, but if we merge your driver in the main Linux tree, it'll happen
at best in 2.6.17-rc1 so the version we'll merge will not be compatible
with 2.6.12.5 anyway. You must have noticed that the i2c subsystem had
a few minor changes in the last few Linux releases. So, given that you
will have to maintain a separate version for your customer anyway, we
better make the merged driver comply with the latest standards.

These latest standards include Alessandro Zummo's rtc core and kzalloc,
but also the new mutex implementation, and in a near future (I hope...)
the new explicit i2c client attach method.

> Still open: I don't know if the mutex is needed.  I didn't see it in
> other drivers but in my eyes it must be there.  Any comments?

On second read, I think it is needed, but maybe not for the reasons you
thought. It is needed to make sure that the i2c client won't be freed
while you're using it. It is not needed for I2C transfers themselves,
as the i2c-core already handles the locking there. So, it looks to me
like you are not always holding the lock when you need it. For example,
in rx8025_get_rtctime, you release the lock, then right after you use
&rx8025_rtcclient->dev. This doesn't look correct to me.

Anyway, Alessandro told me that the rtc core may handle that kind of
lock, so it's probably not worth investigating until your driver has
been converted to that subsystem.

> I hope I catched all the remaining points to your satisfaction.

Seems so, or at least enough for me to accept your driver, except that
I'd like it to be ported to the rtc core instead, as explained above. I
think Alessandro is willing to help with that, so please see with him
how you want to handle it; it shouldn't be very difficult.

Thanks,
-- 
Jean Delvare

