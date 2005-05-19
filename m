From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: IBM BIOS version: V75SV4C
Message-Id: <200406250818.i5P8IWCl005562@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40DB781D.1080608@snowdream.org>
In-Reply-To: <40DB781D.1080608@snowdream.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>I just finished installing lm_sensors-2.8.7 on my linux machine with
>kernel 2.6.7 installed.
>Then when I run sensors-detect I encounter the following message:
>
> System vendor: IBM
> BIOS version: V75SV4C
>Sorry, we won't let you go on. IBM systems are known to have
>serious problems with lm_sensors, resulting in hardware failures.
>For more information, see README.thinkpad or
>http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/README.thinkpad.
>
>Now, as far as I'm concerned this only applies to the thinkpad series.
>Is there a fix for this, so I can get lm_sensors on my machine within
>the next days. I don't have the patience to wait a few hundred days for
>it to be fixed.

The problem was reported (once) on an non-Thinkpad as well (which is why
we play it safe).

Anyway, the problem is supposed to be fixed in sensors-detect now. We
have kept the warning in place until we know for sure that the
workaround has no side effect. We'll probably remove it entirely within
a few months.

>Please give me some advice on what to do next. Grateful for any answer.

Edit sensors-detect, seach for "sub safe_system_vendor", replace the
final "exit;" with "return 0;". At your own risk, of course. Let us
know how it goes though.

This will let you run sensors-detect, but possibly it'll tell you that
you need a protected driver (i2c-piix4). If this is the case, I'll tell
you what to do.

Jean Delvare
