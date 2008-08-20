From: Ben Hutchings <bhutchings@solarflare.com>
Date: Wed, 20 Aug 2008 20:12:58 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] lm87: Add support for configuration
Message-Id: <20080820201257.GM7908@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080819150228.GI7908@solarflare.com>
In-Reply-To: <20080819150228.GI7908@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Ben,
> 
> On Tue, 19 Aug 2008 19:30:36 +0100, Ben Hutchings wrote:
[...]
> > In case (1) platform_data is not set and in case (2) it is.  I don't think
> > there is a third case where we would want to set the channel but not reset
> > the chip.
> 
> Hmm, OK, this makes some sense. I'm still not sure what is the point of
> resetting the chip though. If the firmware had initialized it, you
> loose the settings. If it didn't, the reset is a no-op.

It seems like a good idea to make sure we're starting from a known state.

> And resetting the chip at removal time makes even less sense to me.
> While I would understand that you stop the monitoring (if and only if
> the chip wasn't already running at load time), resetting it but letting
> it run seems pointless.

Resetting it does stop it.  But what I'll do in the next iteration is to
restore the initial configuration register on removal.

[...]
> Not that I care much... After all, you'll be the only user of that
> code, at least for now, and it can evolve later if others have
> different needs. But I am still worried that you are defining a
> non-intuitive interface and do not document it. If you were to add a
> paragraph to Documentation/hwmon/lm87 about how platform code can
> influence the initialization, I'd probably buy it.
[...]

I'll synch it with the header comment in lm87.c.

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
