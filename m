From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: PC87366 with the net4801
Message-Id: <200406280917.i5S9HhKF099052@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>I use lm sensors in a fairly specific manner (nagios monitoring). Sensors is
>run on a regular interval, and the shell script looks something sort of like
>this:
>if ( sensors | grep -q ALARM ); then
>exit $SERVICE_CRITICAL
>else
>exit $SERVICE_OK
>fi
>
>This makes things pretty easy assuming the alarms work, so perhaps you can see
>why I would ask such a question :) I do completely understand your reasoning,
>though.

Yeah, I understand what you mean and need.

Anyway, if a specific chip is known to have problems, it's better to fix
it at the driver level (even if it includes faking hardare alarms in
software). That way, not every program or script needs to handle it
specifically.

Also note that the new sysfs interface to hardware monitoring chips has
been reworked in such a way that scripts should be able to perform any
kind of tests by themselves. Each sysfs file only contains one integer
value, so you could easily read a value and its limit, and compare them
manually if you want to. That said, I insist on the fact that in most
cases you should rely on hardware alarms since they work OK.

As far as the PC87366 chip is concerned, remember that only the critical
limit is unusable, min and max limits are OK, so you'll still get an
alarm if the measured temperature goes beyond these limits.

Are there other hardware monitoring chips you are woking with and which
are causing trouble?

Jean Delvare
