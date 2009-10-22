From: Adam Nielsen <a.nielsen@shikadi.net>
Date: Thu, 22 Oct 2009 23:20:37 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <4AE0E8C5.9020806@shikadi.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Here's a standalone driver for you to try:
> http://khali.linux-fr.org/devel/misc/it87/
>
> Build with "make", then as root, "rmmod it87&&  insmod it87.ko".

Works fine!  The "cpu0_vid" and "vrm" files disappear from the it87 sysfs 
directory, and 'sensors' no longer reports a value for the VID.  There is a 
log message telling me in3 is VCC (+5V), but no log message to tell me the VID 
is disabled.  Not sure if that's worth including, in case somebody is trying 
to figure out why their it87 behaves differently to someone else's.

Everything else seems to work as before.

Cheers,
Adam.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
