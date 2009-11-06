From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 06 Nov 2009 13:22:49 +0000
Subject: Re: [lm-sensors] [patch 1/5] hwmon: Convert fschmd to unlocked_ioctl
Message-Id: <200911061422.49596.arnd@arndb.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091015202722.372890083@linutronix.de> <20091015202758.400949170@linutronix.de> <20091106141542.12404c5c@hyperion.delvare>
In-Reply-To: <20091106141542.12404c5c@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, lm-sensors@lm-sensors.org, Hans de Goede <hdegoede@redhat.com>

On Friday 06 November 2009, Jean Delvare wrote:
> I'm not sure why we need to hold the mutex here? My understanding is
> that watchdog_data_mutex protects watchdog_data_list and each
> watchdog's kref. And the above code doesn't touch either.
> 
> What I am more worried about is why ident is declared static. This
> looks like a bug to me. Instead of abusing watchdog_data_mutex to
> workaround this, I'd rather remove the "static". I guess that the
> current code happens to work because neither data->revision nor
> nowayout can change over time, but this looks needlessly fragile.
> 
> Hans, any comment?

The data copied into the watchdog_info data structure is completely
static. To make that clearer, I'd suggest moving it outside of
the ioctl function, and initializing it from fschmd_init.
Then it becomes obvious that the mutex is not needed to protect it.

	Arnd <><

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
