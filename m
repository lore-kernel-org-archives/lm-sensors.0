From: nemesis-lists@icequake.net (Ryan Underwood)
Date: Sat, 25 Jun 2005 00:46:44 +0000
Subject: [lm-sensors] lm78 fan speeds have too high minimum
Message-Id: <20050624224610.GJ8920@dbz.icequake.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050624220454.GI8920@dbz.icequake.net>
In-Reply-To: <20050624220454.GI8920@dbz.icequake.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Sat, Jun 25, 2005 at 12:17:13AM +0200, Jean Delvare wrote:
> Hi Ryan,
> 
> > This is a LM78 chip on a PR440FX board.  lm-sensors is 2.9.1 from
> > Debian 'sarge'.
> 
> Which kernel?

2.6.8-2-686-smp which shipped with sarge.

> Unless a bug was introduced here, these values either come from the chip
> itself, or from your configuration file, depending on whether you ran
> "sensors -s" or not.

The configuration file is the default that ships with lm-sensors, AFAIK.
I've only changed it to fix the limit on -12V rail (which appears to be
defective on my PSU).

> Setting the correct "set fanN_min" lines in the lm78-* section of the
> /etc/sensors.conf and running "sensors -s" afterwards should do.

Yes, this fixed it.  Would it make sense to add fanX_min prototypes to
the lm78 section, since at least my chip seems to have incorrect
minimums?  I wonder if anyone else with lm78 has noticed this.

> > I'm also looking for a way to disable the chassis intrusion alarm
> > through software since no connector for it is available on my
> > motherboard.
> 
> You can't disable it at the driver level, but you should be able to do
> so at the libsensors level by adding the following line to
> /etc/sensors.conf (in the lm78-* section, obviously):
> 
>    ignore alarms

Excellent!  This cleared up all the issues I was having.

Thanks,

-- 
Ryan Underwood, <nemesis@icequake.net>
