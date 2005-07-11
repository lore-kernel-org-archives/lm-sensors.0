From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 11 Jul 2005 11:49:11 +0000
Subject: [lm-sensors] Fwd: [Bug 16755] [lm_sensors] ASSIGNED: [PATCH] Bad
Message-Id: <SR2mx36W.1121074887.2185110.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200507111118.03565@totor.bouissou.net>
In-Reply-To: <200507111118.03565@totor.bouissou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Salut Michel,

On 2005-07-11, Michel Bouissou wrote:
> So they asked me to bug you ;-))

And quite rightly so, this is indeed not acceptable that sensors -s has
to be ran twice.

Unfortunately your report isn't as complete as it would need to be for
us to help you. We would need to know:

* Which version of the Linux kernel you are using.

* If this kernel has patches applied which could affect the i2c subsystem
or the it87 driver, we need to know which they are and what they do.

* Which version of "sensors" and "libsensors" you are using.

* If lm_sensors has patches applied, we need a list.

* What is your it87-compatible chip? IT8705? IT87012F? Which revision, if
you happen to know? Is it accessed through the SMBus or as an ISA device?

* The complete sensors initialization script used.

* Which limits exactly don't get set by the first "sensors -s"? All?
Please provide the output of "sensors" before the first "sensors
-s", after the first "sensors -s" and after the second "sensors -s".

* Anything in the logs?

Please keep in mind that this is *expected* that reported alarms won't
disappear immediately after changing the limits. You will always see
them once after that, per chip design (you must not miss once-only
alarms).

> (BTW the sensors@stimpy.netroedge.com email address mentioned on the
> http://www2.lm-sensors.nu/~lm78/support.html web page bounces with "User
> unknown"...)

Correct, I just asked our administrator to fix it. Thanks for reporting.

--
Jean Delvare
