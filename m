From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Jun 2008 20:57:48 +0000
Subject: Re: [lm-sensors] [Bug?] W83697: Broken readings for fan speed 10%
Message-Id: <20080614225748.69f3e421@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080531220339.05dc83fd@neptune.home>
In-Reply-To: <20080531220339.05dc83fd@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 13 Jun 2008 23:31:54 +0200, Bruno Pr=E9mont wrote:
> sidenote: I would appreciate if libsensors also knew about PWM :))

This was discussed when designing libsensors 3.0.0 and we voted against
it, for the reason that PWM outputs are not sensors. The interface
needed to control fans is significantly different from what is needed
for sensors. Sensor limits are initialized once, while PWM values are
likely to evolve (based on temperature for example). Sensor values
often need scaling (in particular voltage) and giving them a proper
label is important. PWM values need no scaling factor and labelling
them doesn't sound too useful either. So the needs are clearly
different.

Also, it's easy to get things wrong (including permanent hardware
damage) when playing with PWM, while playing with sensors is normally
safe. So while it makes sense to have a sensors library for GUI apps to
interface with, I don't see a need for this for PWM. As a matter of
fact, our software fan control daemon is a simple bash script, it
doesn't need any library.

> Are there other changes between the driver's hardware knowledge and
> revision 8?

2 additional fans inputs, like the IT8716F and IT8718F have. Basically
the latest incarnations of the IT8712F have a lot in common with the
IT8716F. I don't get the point of ITE doing this, but they did, so
we'll have to support it. We add the missing features when users ask
for them... as you did.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
