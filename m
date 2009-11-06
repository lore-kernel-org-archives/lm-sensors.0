From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 06 Nov 2009 13:37:05 +0000
Subject: Re: [lm-sensors] [patch 1/5] hwmon: Convert fschmd to unlocked_ioctl
Message-Id: <200911061437.06978.arnd@arndb.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091015202722.372890083@linutronix.de> <200911061422.49596.arnd@arndb.de> <4AF42672.7040501@redhat.com>
In-Reply-To: <4AF42672.7040501@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jean Delvare <khali@linux-fr.org>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, lm-sensors@lm-sensors.org

On Friday 06 November 2009, Hans de Goede wrote:
> Moving the ident struct to the data structure would have it needlessly
> using RAM all the time, the best and simplest fix for this is to simply
> stop declaring ident static inside the ioctl function.

Ok. Considering the case of multiple watchdogs in the system, that seems
best then. Of course, the watchdog infrastructure does not allow this
right now, but it may be added at some point.

	Arnd <><

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
