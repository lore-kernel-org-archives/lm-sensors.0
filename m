From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 Apr 2010 18:08:01 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ltc4245) Read GPIO registers
Message-Id: <20100403200801.785d9ff6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100330225704.GF20635@ovro.caltech.edu>
In-Reply-To: <20100330225704.GF20635@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ira,

On Fri, 2 Apr 2010 11:09:38 -0700, Ira W. Snyder wrote:
> But it *does* make sense to change this one: to let you use all 3 GPIO
> pins as voltage sensors. Especially if your board is already very dense,
> and you don't have enough space to fit another component.

I think you're off the point. It's not a matter of fitting another
component, it's a matter of picking the right component to start with.
If you had 15 voltage lines you wanted to monitor, you should have
chosen a chip which can monitor 15 voltage lines right away, rather
than one that can monitor "only 13 and maybe 2 more if I add funky code
to the driver and run user-space applications in some specific way".

> Right, in my application, I attempt to read the sensors every 500ms.
> Hence the 3s update time for the chip. I'm aware that not everyone reads
> their sensors this fast.
> 
> Would you accept a patch that zeroed out stale values (older than a few
> seconds)? I'm aware that it is suboptimal, but I think that zeroes would
> be better than hours-old values. I could add a big warning to the code
> and in the Documentation directory.

I don't quite agree. You're trading one evil for another. Instead of
getting an old reading, you'll get a zero which is statistically more
wrong. The only benefit is that it is more obviously incorrect, but it
is also totally unfriendly for monitoring applications. Think of people
running sensord, for example. 2 out of 3 reading cycles will return 0
and the user will end up with totally unusable graphs.

> As the only known user of this driver, I'm trying to play nice and
> follow the "get it upstream before you ship it" mantra.

I fail to see how it matters here.

> Remember the recent fiasco with the Google Android folks?

No, I have no idea what you are talking about, sorry.

> The fact is, I've got a board with this chip, and it is wired in a way
> you don't like, but is within the capabilities of the chip. I don't want
> to forward port these changes forever. Can we please try and decide on
> something that will make this chip work the way I have it hooked up?
> From my point of view, you're just telling me "I don't like it, go away"
> while I'm trying to make a chip work.

You got my point totally right as I see. I understand you don't like
it, I wouldn't like it if I were you.

Don't get me wrong, you're a nice guy, that's nothing personal. Simply,
none of your workaround proposals so far pleased me, and I can't think
of anything better myself. I don't want to have in mainline a driver
which behaves strangely until you read the documentation. Especially if
this would mean making life difficult for users who did wire their own
chip in a smart way (that is, at most one GPIO used for analog voltage
monitoring.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
