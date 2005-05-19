From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Gnome hangs after sensors installation
Message-Id: <20030731170031.1927abeb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BB4EE262.6D4C%zdavatz@ywesee.com>
In-Reply-To: <BB4EE262.6D4C%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > grep sensors -ir /etc/rc2.d/*
> I have nothing in there. The command returns nothing.

OK, no init script (at first sight).

> > (BTW I'm surprised you are in runlevel 2, it's unusual.)
> What runlevel do you expect me to be in? Xserver starts fine,  as does
> gdm..

This usually corresponds to runlevel 4 or 5. But nevermind.

Can you take a look at /etc/modules.conf? If you see anything that looks
i2c- or lm_sensors-related, delete it (or simply comment it with a #)
and see if it goes any better.

If not, try the following:

cd /lib/modules/$(uname -r)/kernel/drivers/i2c

(make sure this command succeeded before running the rm commands below)

rm *.o
rm -r busses
rm -r chips

With no more sensor modules installed, everything should be back to
normal I guess.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
