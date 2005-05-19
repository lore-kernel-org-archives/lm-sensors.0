From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: LM-Sensors
Message-Id: <200406171159.i5HBxaAo089171@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C61EE92.392A5D31@paradyne.com>
In-Reply-To: <3C61EE92.392A5D31@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hallo Horst,

>I have tested the "new" version and the result is better, but we can live
>with the "old" version too.

Magnitude of 3 definitely seems to help, as I hoped. I'll commit the
changes to our CVS repository.

>I have attached sensors.conf and a display output for the "new" version.

Still I'm a bit worried by displayed limits being rounded off by 0.01V
in various places. I don't have the "old" sensors output at hand at
the moment, but I think it wasn't that way before the magnitude change.
Most likely, what sensors displays as 2.99V, for example, is actually
2.999 (or at least 2.995) and should be rounded up to 3.00V for a nicer
display. There was no reason to have rounding done at this place before
(driver magnitude and displayed magnitude were the same) but now it
would be welcome.

Could you please confirm my suspicions by providing the contents of the
/proc/sys/dev/sensors/pc87366-isa-0fb0/in* files for your current
configuration?

Thanks.

Jean Delvare
