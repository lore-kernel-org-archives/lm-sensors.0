From: Matt Roberds <mattroberds@cox.net>
Date: Wed, 03 Jun 2009 03:00:00 +0000
Subject: Re: [lm-sensors] Power Supply Monitoring
Message-Id: <Pine.LNX.4.64.0906022142400.26151@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090602164941.uz55en9rms0okkg0@blastoid.drak.net>
In-Reply-To: <20090602164941.uz55en9rms0okkg0@blastoid.drak.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2 Jun 2009, Jacob Steinberger wrote:
> I'm trying to do power supply monitoring to detect if we're having a
> problem (loss of grid power, loss of UPS power, voltage issues, etc).

The voltage readings you get from lm-sensors are usually of the DC
output of the computer power supply.  The readings also tend to have a
relatively low update rate - maybe a few times a second max.  If your
input AC power is really bad, you might be able to see it by looking at
the output, but if the AC power only glitches out occasionally, you
probably won't see it this way.

UPSes tend to have various amounts of AC power monitoring available,
and that might be a better place to look.  Network UPS Tools
http://www.networkupstools.org/ runs on Linux and can talk to many
types of UPSes.

Beyond that, the next step is usually to go to the site and look for
any obvious problems - do half the machines reboot when the machine
shop downstairs fires up the arc welder?  Did somebody set up 42U of
servers on a 100 foot 16 gauge (30 m 1.0 mm^2) extension cord?  Then
you start poking at it... depending on how subtle the problem is and
your budget, you start with a $30 Kill-a-Watt meter, then move up to
a $200 Fluke multimeter, and then maybe a multi-thousand-dollar Fluke
or Dranetz data logger.

> Does either ipmisensors or i5k_amb support voltage type statistics?

As far as I can tell, i5k_amb is just a temperature sensor.  If you have
any voltage sensors (which is likely), they will come through the
ipmisensors driver.  If you've ever been into the BIOS setup screens of
this machine, and one of them displayed the power supply voltages, there
is a decent chance that ipmisensors will be able to show you those
voltages as well.

Standard disclaimers apply; I don't get money or other consideration
from any companies mentioned.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
