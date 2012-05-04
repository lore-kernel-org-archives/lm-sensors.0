From: Wim Van Sebroeck <wim@iguana.be>
Date: Fri, 04 May 2012 12:34:34 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] watchdog_dev: Add support for having more then 1 watchdog
Message-Id: <20120504123434.GR3074@spo001.leaseweb.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331812757-3491-1-git-send-email-hdegoede@redhat.com> <1331812757-3491-2-git-send-email-hdegoede@redhat.com> <20120315131131.1096f8c8@pyramind.ukuu.org.uk> <4F61FA18.70104@redhat.com> <20120315153833.40bd2f16@pyramind.ukuu.org.uk>
In-Reply-To: <20120315153833.40bd2f16@pyramind.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-watchdog@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>, =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>

Hi Alan,

> > You do this even for watchdog0 / for the watchdog we've also registered as
> > misc_dev. I guess this is intentional and you want the watchdog to be
> > available as both misc,130 as well as as MAJOR(dog_devt),0 ?
> 
> Yes - so that it appears in the watchdog class in sysfs for example.

What happens if one program opens the miscdevice and another program opens the MAJOR(dog_devt),0 device?
I presume that the WDOG_DEV_OPEN status bit will prohibit the opening of the second device in that case...

Thanks,
Wim.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
