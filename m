From: Mario.Holbe@RZ.TU-Ilmenau.DE (Mario 'BitKoenig' Holbe)
Date: Thu, 19 May 2005 06:24:54 +0000
Subject: sensord: rrd database and timeslots
Message-Id: <20040422090442.GA19063@darkside.22.kls.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040421222823.GA14256@pc.aurel32.private>
In-Reply-To: <20040421222823.GA14256@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

(I'm the user who suggested the patch)

On Thu, Apr 22, 2004 at 12:28:23AM +0200, Aurelien Jarno wrote:
> On IRC, Jean Delvare suggests to disable the interpolation function of

Afaik you cannot disable the interpolation of rrd, except you
store data exactly at the 'official timeslots'.

> On my side, I suggest to use the second part of the patch only, which
> means that the sensors are sampled at fixed time slots. It's also the 
> solution given in the examples given with rrd. I don't see why sensord
> should fake that the sensors were read exactly on the timeslot. In most
> cases the sensors would be read exactly on the time slot, however if it
> is not the case (for example on a system with a very high load, if there
> is a problem on smbus/i2c, etc.) the data would be interpolated.

I'm currently running the modified sensord with both parts
of my patch (sampling at fixed timeslots and 'faking' the
samle time) on a quite fast machine (P3-1000) with quite low
load (something around 0.5). But even there, according to
the modification time of the rrd, it happens quite often,
that the update happens one second after the official timeslot
(for example at 00:00:01 instead of 00:00:00).
This is no big issue, if the RRD update interval is something
like 5 minutes: the deviance in this case would be something
around 0.3%. However, the issue grows with smaller update
intervals: with 1 minute update interval you get a deviance
of 1.6%, which leads to a noticeable interpolation.

That's why I'd suggest to apply the first part of my patch
(giving the timeslot to rrd instead of 'N'(ew)) too.


regards,
   Mario
-- 
"Why are we hiding from the police, daddy?"      | J. E. Guenther
"Because we use SuSE son, they use SYSVR4."      | de.alt.sysadmin.recovery
