From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 20 Oct 2005 14:37:21 +0000
Subject: [lm-sensors] lm-sensors in a rollout on FC4 - Attempts fail
Message-Id: <cyjjSwhf.1129811127.5039390.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <4356F706.20904@cosc.canterbury.ac.nz>
In-Reply-To: <4356F706.20904@cosc.canterbury.ac.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hi Peter,

Peter Glassenbury wrote:
> ** 1 ** Is there a way to run the sensor-detect without prompts??
> so I can just put it in the kickstart configuration files.

No immediate way. There are tricks (see Rudolf's answer) but keep in
mind that sensors-detect was written with humans as a primary target,
and in some cases manual tweaking is needed. The actual output of the
script is also very helpful when investigating issues.

We could implement a non-interactive mode to sensors-detect, which would
silently probe for all devices and create the configuration file. It
won't work in all cases, of course, but I guess it would be useful in
some cases like yours. Is anyone willing to take a try? I do not have
the time to work on this myself.

> ** 2 ** Less portable is to fix whatever step I missed in this
> and have 5 varients for the different machines.
>
> I copy the modules into /etc/sysconfig/lm_sensors
> MODULE_0=3Di2c-viapro
> MODULE_1=3Di2c-isa
> MODULE_2=3Dlm75
> MODULE_3=EEprom
> MODULE_4=3Dsmbus-arp
> MODULE_5=3Dw83627hf

smbus-arp is an experimental thing, you don't need it. I'm also
surprised that you would need both w83627hf and lm75 - unless this is an
Intel Xeon machine, maybe. What does the output of "sensors" look like
(when it works)?

Oh, you didn't tell us what version of linux and lm_sensors you were
using.

> then a /etc/init.d/lm_sensors restart
> to modprobe them all....
> No luck finding the sensors.

What does the /etc/init.d/lm_sensors script do exactly? Does it come with
FC4, or did you install it yourself?

> Run sensor-detect then all goes... arghhh what is missing
>
> Can anyone suggest something?

sensors-detect does, in turn:
 * load i2c-dev;
 * load all suitable i2c bus drivers;
 * probe every single chip it knows about (but not load chip drivers).
Of these, only the second step can change what "sensors' prints. So my
guess would be that /etc/init.d/lm_sensors does not properly load the
bus drivers. I don't really understand how this could happen though.

Please check with lsmod which modules are loaded before running
/etc/init.d/lm_sensors, after running it, and after running
sensors-detect.

You could also check the system logs, maybe you'll find hints there.

--
Jean Delvare
