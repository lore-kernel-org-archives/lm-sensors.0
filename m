From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Ticket 1319 - lm_sensors-2.8.0-cvs linux-2.4.20-smp-i386
Message-Id: <20030710095827.47a22bb6.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030710085158.42e68c95.zdavatz@ywesee.com>
In-Reply-To: <20030710085158.42e68c95.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 10 Jul 2003 09:53:48 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> [PLEASE DON'T REPLY TO ME ONLY. REPLY TO THE LIST INSTEAD.]
Ok, sorry.

> Rather logical. Debian is shipping an old (and stable) version of our
> package, which has less devices supported.
Ok.

> Please make sure you uninstall all Debian i2c and lm_sensors packages
> before trying CVS. If you don't, there will be old i2c headers lying
> around and lm_sensors may accidentally get those instead of ours when
> you try to compile it. That too could explain the errors you get.
Ok. I uninstalled i2c-source, lm-sensors-source and lm-sensors

Still get the same error.

Did I miss anything?

Thanks for your Feedback.

Zeno
