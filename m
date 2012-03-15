From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 15 Mar 2012 13:11:31 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] watchdog_dev: Add support for having more then 1 watchdog
Message-Id: <20120315131131.1096f8c8@pyramind.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331812757-3491-1-git-send-email-hdegoede@redhat.com>
	<1331812757-3491-2-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1331812757-3491-2-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, LM Sensors <lm-sensors@lm-sensors.org>, Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>

> Also having this support in watchdog_dev makes developing watchdog drivers
> for watchdog hardware which happens to often be found on systems with
> multiple watchdogs a lot easier.

See the patches I posted. I (biased as ever ;)) think they way I've done
it is better, but its also produced no feedback so I'll resend them again
shortly if others also need them.

For x86 we need them as some systems can have both a TCO timer and a
management engine timer.


> +static struct miscdevice watchdog_miscdev[MAX_WATCHDOGS] = { {
> +	.minor		= WATCHDOG_MINOR,
> +	.name		= "watchdog",
> +	.fops		= &watchdog_fops,
> +}, {

The way I did it was to support a legacy /dev/watchdog and a proper range
of watchdogs on their own dynamic major.

> +	.minor		= 212,
> +	.name		= "watchdog1",

Also for submitted patches please don't go taking minor numbers from
miscdev which are statically allocating them without properly registering
them first...


> +	/* Find our watchdog_device */
> +	for (idx = 0; idx < MAX_WATCHDOGS; idx++)
> +		if (watchdog_miscdev[idx].minor = iminor(inode)) {
> +			wdd = wdd_list[idx];
> +			break;
> +		}

Locking model ?


> +	/* No need to lock */
> +	for (idx = 0; idx < MAX_WATCHDOGS; idx++)
> +		if (wdd_list[idx] = watchdog)
> +			break;

What about a parallel open ?

Alan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
