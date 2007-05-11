From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 11 May 2007 14:55:19 +0000
Subject: Re: [lm-sensors] Fintek F71882FG Driver -> Problems with non EPoX
Message-Id: <464483D7.9070804@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <000301c793d8$678c3790$20140a0a@EA002>
In-Reply-To: <000301c793d8$678c3790$20140a0a@EA002>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans Edgington wrote:
> Hi All,
> 
> Two weeks ago I posted the beta-version driver for the Fintek F71882FG. I
> just wanted to let everyone know how things are standing at the moment. 
> 
> The driver has been tested by quite a few people. Results are that the
> driver works on 2 different EPoX mobo's, but fails to work on a jetway and
> all MSI mobo's. In all cases it does correctly detect the fintek chipset,
> and select the proper device and enable it if needed. Only the register it
> is supposed to read from is empty. It seems that the region is reserved for
> pnp, which cannot be disabled in the bios. This seems to be the case on the
> 3 MSI mobo's. I don't know how to deal with this problem..
> 
> I would be grateful if someone could have a look at the driver, if they have
> the time, and comment on it.
> If you are wondering why the driver doesn't output any voltages that is
> because it wasn't working correctly on my system. So I removed it to make
> sure it didn't cause any problems on someone else system.
> 

Good to see you working on this! Can you explain the "It seems that the region 
is reserved for pnp", a bit more?

Are you talking about the IO-address used by the sensors logical device of the 
super/io chip, or about ... ?

Does your driver need to enable the sensors part on those MSI mobo's? Then 
maybe it also needs to search for a free io-space and program that into to 
superio config registers for the sensors logical device, before enabling it.

If its already enabled, maybe its memory-mapped instead of io-mapped, some 
super-io devices support this. Or maybe even, its mapped to the smbus instead?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
