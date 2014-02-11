From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Feb 2014 19:28:55 +0000
Subject: Re: [lm-sensors] [PATCH 00/12] Versatile Express updates
Message-Id: <2782419.lfJiZZjaFg@wuerfel>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org
Cc: Pawel Moll <pawel.moll@arm.com>, arm@kernel.org, linux-kernel@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, Lee Jones <lee.jones@linaro.org>, Mike Turquette <mturquette@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, lm-sensors@lm-sensors.org, Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw2@infradead.org>, Jean Delvare <jdelvare@suse.de>, Samuel Ortiz <sameo@linux.intel.com>

On Tuesday 11 February 2014 17:10:24 Pawel Moll wrote:
> This series is a set of updates following the infrastructure
> rework and depends on it. It will be finally posted once
> the main series is merged. For the time being I would really
> appreciate feedback and/or (n)acks...
> 

I haven't read the patches yet, but on a general level, do
you think this code can be (or should) be shared with
mach-versatile and mach-realview?

One of the things on my (mid-term) to-do list is to completely
convert those two platforms over to being entirely DT based
and having no board specific code so we can actually delete
the directories along with mach-vexpress. The sysreg part
seems to be almost identical, and I wonder if you have an
overview of what the difference is, if any.

If we are going to share that code, we might want to give it
a different name, as vexpress is just the latest platform
in that line.

	Arnd

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
