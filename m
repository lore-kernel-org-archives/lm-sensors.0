From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: High, low and crit are in a boat...
Message-Id: <3F3BBE16.50001@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030814183949.5d14ed41.khali@linux-fr.org>
In-Reply-To: <20030814183949.5d14ed41.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I would suggest that the critical and hyst values belong in a *seperate* 
proc entry.  The /proc entries for temperature should always and only be:

    high, low, current
or
    over, hyst, current

as appropriate to the sensor.

Also, note that the adm1023 variant of the adm1021 driver adds the 
temperature offset inbetween low and current and doesn't compensate for 
that in libsensors, so the adm1023 doesn't print correctly.  That 
wouldn't be a problem if the offset had been placed in a seperate entry.

In the case of the lm85 and adm1026 drivers, I put some related, but 
exceptional values (temperature offset, critical, etc) in seperate files.

The whole /proc stuff is going away as Greg KH is so fond of repeating 
and with sysfs, you've only got one value per entry so this whole 
problem goes away.

:v)

Jean Delvare wrote:
> Hi all,
> 
> I'm on my way to finish the lm90 driver and am facing one more problem.
> This chipset has, for each temperature sensor, a high limit, a low
> limit, and a critical limit (plus a common, relative hysteresis value,
> but that's not the point here). I am wondering in which order I should
> make them appear in the procfs entries. As far as I could see, the only
> chipset offering more than two limits per temperature sensor is the
> lm92. Unfortunately, the order in use here is so bad that I won't use
> it, for sure. The oder is: current, high, low, crit, hyst. All other
> drivers have the current value last, and I want to stick to that. I
> think that the first value should always be high or critical, since
> these are the values people will want to change the more frequently.
> Apart from that, I admit I have no strong opinion, so if anyone has,
> speak up.
> 
> Wouldn't it be great to define an order once and for all, so that all
> drivers behave the same wrt this point?
> 
> My proposal would be to place higher values first, down to lower ones,
> for all values that are absolute. Then the relative values (I'm mostly
> thinking to chipsets where you can set a relative hysteresis for each
> sensor, and this value applies to all other limits for that sensor). And
> finally the current, read-only value.
> 
> So in my case this would be: crit, high, low, current.
> 
> Comments welcome, as usual.
> 



-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
