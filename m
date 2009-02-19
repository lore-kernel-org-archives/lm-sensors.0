From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Feb 2009 10:51:09 +0000
Subject: Re: [lm-sensors] [RFC] Support of chassis intrusion detection
Message-Id: <20090219115109.6f33d988@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090217230215.5106b6c0@hyperion.delvare>
In-Reply-To: <20090217230215.5106b6c0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 19 Feb 2009 10:37:33 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > Hi all,
> > 
> > A number of users have asked us to support the chassis intrusion
> > detection feature which some hardware monitoring chip have. I've
> > created a ticket for this:
> > http://www.lm-sensors.org/ticket/2370
> > Here is a proposal.
> > 
> > sysfs interface
> > =======> > 
> > chassis_intrusion
> > 		Chassis intrusion detection
> > 		0: OK
> > 		1: intrusion detected
> > 		RW
> > 		Writing 0 clears the detection flag.
> > 		Writing other values is unsupported.
> > 

Having thought about it some more, I suspect this won't be sufficient.
This feature is like an alarm flag, which suggests that chips which
support beeping may have a beep control bit for it too. So maybe we
should define:

chassis_intrusion_alarm
chassis_intrusion_beep

I didn't look at all the datasheets yet to find out whether any chip
actually implements this, but this doesn't sound unreasonable.

> > It's not totally clear whether clearing should be done by writing 0 or
> > 1. 0 is more respectful of traditional sysfs semantics that you should
> > be able to read back what you just wrote, so it has my vote.
> > 
> > drivers
> > ===> > 
> > Drivers adm9240, w83792d and w83793 implement this feature in
> > non-standard ways. They should be converted to the new, standard
> > interface.
> > 
> > libsensors
> > =====
> > 
> > Either
> > 
> > SENSORS_FEATURE_CHASSIS_INTRUSION = 0x19
> > SENSORS_SUBFEATURE_CHASSIS_INTRUSION = SENSORS_FEATURE_CHASSIS_INTRUSION << 8
> > 
> > or rename SENSORS_FEATURE_BEEP_ENABLE to SENSORS_FEATURE_MISC and
> > 
> > SENSORS_SUBFEATURE_BEEP_ENABLE = SENSORS_FEATURE_MISC << 8
> > SENSORS_SUBFEATURE_CHASSIS_INTRUSION = (SENSORS_FEATURE_MISC << 8) + 1
> > 
> > sensors
> > ===> > 
> > Reading the value of the chassis intrusion detection subfeature is done
> > like for any other subfeature.
> > 
> > Writing, OTOH, can't be handled the same as writing limits, because we
> > certainly don't want to clear the flag automatically at lm_sensors
> > start or restart time. So we could add a dedicated flag to clear the
> > chassis intrusion detection flag (e.g. "sensors --clear-chassis").
> > 
> > If anyone has objections or comments, please speak up.
> > 
> 
> looks good to me, but I wonder if we should not prepare for the case where an 
> IC has more then one chasis intrusion detection pin.

The same question has been raised by other reviewers already. I am
shared between simplicity (we've never seen a system with more than
one, and there is no obvious scenario) and completeness (who knows...)

The point which makes me reluctant to go for multiple inputs is how we
are going to handle clearing them with "sensors". Should "sensors
--clear-intrusion" clear them all? Or do we need to provide a parameter
specifying which intrusion detector needs to be cleared? The latter
seems somewhat overkill in the usual case of a single chassis intrusion
detector. If we go for the former, we have less control but then
supporting multiple intrusion detectors is cheap.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
