From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 26 May 2008 10:06:10 +0000
Subject: Re: [lm-sensors] Future plans for sensors-detect
Message-Id: <20080526120610.1062c97e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080521114013.074cde02@hyperion.delvare>
In-Reply-To: <20080521114013.074cde02@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 25 May 2008 23:20:40 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Note: when sensors-detect goes non-interactive, you are more likely to
> > notice how slow SMBus probing is. For now, most time is wasted waiting
> > for the user to answer questions, so you don't really notice, unless
> > you're using HZ0.
> 
> Are you really planning on doing non interactive i2c probing from the 
> initscript? To me that feels wrong:

Not from init script, that would be too costly to do the detection
again at each boot. I was thinking of adding it as part of the
distribution installation (actually post-install of the sensors
package.) This won't cover the case where the user changes motherboards
without reinstalling his/her system. Maybe we can have a detection of
this case at boot (based on DMI data for example) and we restart the
detection conditionally then.

> 1) Only 101% safe probing should be done non interactive

Same is true of an interactive script. If the default answers aren't
101% safe, we're doing something wrong. That was the case of
sensors-detect up to version 3.0.1, and honestly it might still be the
case in 3.0.2. That's the reason why I proposed to revert the order of
the probes, and to skip probing the SMBus if we have already found a
Super-I/O with sensors or an ISA hardware monitoring chip. Other
possibilities to explore would be to change the probe order of the I2C
addresses (probing 0x2c-0x2f first, 0x48-0x4f second, and only then try
the other addresses, would make a lot of sense IMHO) or doing some
probes conditional (for example, no point in searching for FSC chips on
non-FSC machines).

Don't get me wrong, I'm not going to make sensors-detect
non-interactive and add it to some init script unconditionally
tomorrow. This is part of a much longer process, first making
sensors-detect safer than it is (lot of work here), adding DMI-based
detection to skip probing entirely on known machines (again, lot of
work here), and only then implementing a non-interactive mode. The
non-interactive mode might not do all the possible probings, i.e. we
exclude any probe that we think is dangerous. This might as well mean
not doing any SMBus detection at all, although I hope that we can do
some.

> 2) Even if we can safely determine which hwmon drivers should be loaded,
>     we still should not load them without also having a valid
>     matching motherboard sensors.conf
> 
> The reason for 2 is that its better to show no readings to an uneducated users 
> then to show wrong readings which make him/her think his/her machine is about 
> to blow up.

Again this is unrelated to making sensors-detect non-interactive. We
already ship a default sensors.conf file which includes arbitrary
labels for many chips, which may or may not match the user's
motherboard. This is IMHO plain wrong, I agree with you that
unconfigured sensors are better than misconfigured sensors. I believe
that we should strip down sensors.conf.eg to only include labels which
we know are always correct (e.g. internal voltage labels.) This would
also make libsensors initialization much faster - for now we waste
users' time reading long configuration sections for chips they don't
even have.

> > After removing the word register cache (recent changes to the script
> > make it hardly worth caching word reads) and the instrumentation code,
> > the patch only adds 8 lines of code. The diffstat reads:
> 
> I guess its worth it then :)

I'll commit it later today.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
