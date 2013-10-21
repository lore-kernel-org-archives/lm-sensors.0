From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 21 Oct 2013 18:49:39 +0000
Subject: Re: [lm-sensors] [REGRESSION?] sensors and fancontrol not seeing armada_thermal on 3.12-rc series
Message-Id: <87y55mpigs.fsf@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ppqzolsu.fsf@natisbad.org> <52642DAF.8080301@roeck-us.net>
	<1382322502.2410.12.camel@rzhang1-mobl4>
In-Reply-To: <1382322502.2410.12.camel@rzhang1-mobl4> (Zhang Rui's message of
	"Mon, 21 Oct 2013 10:28:22 +0800")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zhang Rui <rui.zhang@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Eduardo Valentin <eduardo.valentin@ti.com>, Jean Delvare <khali@linux-fr.org>, linux-pm@vger.kernel.org, lm-sensors@lm-sensors.org, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>

Hi,

Zhang Rui <rui.zhang@intel.com> writes:

>> > Is that expected? As for sensors, it *seems* to be bothered to find a
>> > device/ folder in /sys/class/hwmon/hwmon1/ w/o no name entry in it.
>> >
>
> I agree. And it should be caused by this commit.
>
> commit b82715fdd4a5407f56853b24d387d484dd9c3b5b
> Author: Eduardo Valentin <eduardo.valentin@ti.com>
> Date:   Fri Aug 23 17:07:58 2013 -0400
>
>     drivers: thermal: parent virtual hwmon with thermal zone

FWIW, the one-liner reverting this commit in your tree (6ddcb7e635
Revert "drivers: thermal: parent virtual hwmon with thermal zone")
does indeed makes sensors and fancontrol happy again.

Cheers,

a+

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
