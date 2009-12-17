From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 17 Dec 2009 13:12:43 +0000
Subject: Re: [lm-sensors] [patch 1/5] hwmon: Convert fschmd to unlocked_ioctl
Message-Id: <20091217141243.770dba04@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091015202722.372890083@linutronix.de>
	<20091015202758.400949170@linutronix.de>
	<20091106141542.12404c5c@hyperion.delvare>
	<alpine.LFD.2.00.0911061655060.12138@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.0911061655060.12138@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, lm-sensors@lm-sensors.org, Hans de Goede <hdegoede@redhat.com>

Hi Thomas,

On Fri, 6 Nov 2009 16:56:34 +0100 (CET), Thomas Gleixner wrote:
> On Fri, 6 Nov 2009, Jean Delvare wrote:
> > I'm not sure why we need to hold the mutex here? My understanding is
> > that watchdog_data_mutex protects watchdog_data_list and each
> > watchdog's kref. And the above code doesn't touch either.
> > 
> > What I am more worried about is why ident is declared static. This
> > looks like a bug to me. Instead of abusing watchdog_data_mutex to
> > workaround this, I'd rather remove the "static". I guess that the
> > current code happens to work because neither data->revision nor
> > nowayout can change over time, but this looks needlessly fragile.
> 
> Right, we can change ident to be non static instead of abusing the
> mutex. Stupid me. Will fix.

This was quite some time ago and I can't seem to find an updated version
of your patch that I could apply. Care to send one?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
