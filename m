From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Dec 2009 09:41:03 +0000
Subject: Re: [lm-sensors] How to expose/clear historical faults
Message-Id: <20091218104103.2f803754@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ira,

Sorry for the late answer.

On Tue, 25 Aug 2009 15:24:39 -0700, Ira W. Snyder wrote:
> I'm the author of the ltc4215 and ltc4245 drivers.
> 
> In the ltc4245 driver, I used the fault registers on the chip to display
> the alarm outputs. These are not self-clearing (write 0 to clear).
> 
> In the ltc4215 driver, I used the status register on the chip to display
> the alarm outputs. This is self clearing; it contains the status of the
> chip at the time it is read. There is also a fault register, which has
> historical status. It works exactly like the ltc4245 fault register.
> 
> For my application, I'm happy to have the ltc4245's alarms stay asserted
> forever after they've been tripped once. However, I think it might be
> beneficial to provide a way for userspace to clear the alarms. Alarms
> are defined in the sysfs-interface document to be read-only.
> 
> For the ltc4215, the most useful output for my application are the
> historical values: I'd like to know if the power supply was tripped in
> the past due to overcurrent. Of course, I'd like a way to clear this
> alarm, too. Is there an acceptable way to display both the immediate and
> historical status to userspace?
> 
> I can always work around the above issues using the i2cget/i2cset
> program to read/write the bits I need to, but this seems ugly.
> 
> Are there any thoughts about the above issues?

The way alarm flags are supposed to work is as follows:
* When a limit is exceeded, the corresponding alarm flag is raised.
* A raised alarm flag stays up until it is read by user-space. That
  way, even transient faults can be spotted, even if the faulty
  condition has gone by the time the user checks.
* Reading an alarm flag clears it. Most monitoring chips do that
  automatically. For others, it is the driver's responsibility to write
  0 or 1 to the relevant register bits to clear the alarms.
* If the fault condition is still present, the alarm flag will be
  raised again during the next monitoring cycle, so it doesn't matter
  whether the flags are cleared or not when the fault condition is
  still present.

If the hardware itself doesn't latch fault conditions, then it is
acceptable for the driver to merely report the real-time status. This
should then be documented for clarity.

Apparently your ltc4215 driver falls into this last category, although
by design rather than necessity. The ltc4245 driver doesn't follow any
of the allowed implementations. It would be great if you could fix both
drivers to implement the standard behavior.

If you are interested in historical faults, then it is up to the
application to remember them. This isn't a bad design anyway, because
physically there's a single alarm flag, while multiple applications may
be interested in processing the results. Some may want real-time, some
may want history. The current design makes it possible to make everyone
mostly happy.

There's one minor flaw, which is that when multiple applications are
reading the sysfs files, one may prevent the other from seeing
once-only faults, depending on the polling frequency of each
application. To work around this, applications which can't afford
losing alarms should make sure to poll faster than the driver's cache
lifetime.

I hope I answered your question. Maybe part of my explanation should be
added to Documentation/hwmon/sysfs-interface?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
