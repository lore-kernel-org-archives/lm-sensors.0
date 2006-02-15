From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 15 Feb 2006 13:17:22 +0000
Subject: [lm-sensors] w83781d and empty /sys/class/hwmon
Message-Id: <GGu6nfHr.1140009442.6716410.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <030d01c63220$60c0ace0$5964a8c0@office.aradio.ru>
In-Reply-To: <030d01c63220$60c0ace0$5964a8c0@office.aradio.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Victor,

> > Which motherboard is this?
>
> sorry, I can't look right now, some kind of asus....

If you have dmidecode installed, it might tell you.

> > Any message in the logs when loading the w83781d driver?
>
> Nothing!

And I forgot to ask... Is there any earlier kernel which had the w83781d
driver working for you? If so please tell us which is the last version
where it worked.

Any option related to w83781d in /etc/modprobe.conf?

If you compiled your kernel by yourself, you may try to rebuild it with
I2C and Hardware Monitoring debugging options enabled, and check again
what happens when you load the w83781d module.

--
Jean Delvare

