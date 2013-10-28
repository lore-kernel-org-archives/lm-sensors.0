From: Chris Verges <kg4ysn@gmail.com>
Date: Mon, 28 Oct 2013 19:10:27 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: lm73: reset device during lm73_probe()
Message-Id: <20131028191027.GB31037@cverges-dev-lnx.sentient-energy.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1382976305-3625-1-git-send-email-kg4ysn@gmail.com>
In-Reply-To: <1382976305-3625-1-git-send-email-kg4ysn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 28, 2013 at 10:35:18AM -0700, Guenter Roeck wrote:
> On Mon, Oct 28, 2013 at 09:05:05AM -0700, Chris Verges wrote:
> > +	mdelay(LM73_MIN_RESET_TIME_MS);
> > +
> Datasheet says one has to wait for the conversion time, which depends
> on the configured resolution. This means that, most of the time, you
> are waiting way too long here - especially in the presumed context
> that the chip has not been initialized by the ROMMON/BIOS.

In reviewing the driver while making the other changes, I discovered
that the look-up table was already implemented for the resolution
support.  (There goes my memory!)  I've hooked it in to the delay
mechanism here.

Chris

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
