From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: SiS5595 graphics chip driver
Message-Id: <Pine.LNX.4.58.0409110920290.31786@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <2542f0f704091021006829b558@mail.gmail.com>
In-Reply-To: <2542f0f704091021006829b558@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

First I must say that you havent chosen right place :)
This project is working on hardware monitoring (temperatures, voltages...)
So no graphics stuff at all.

I would suggest you to subscribe to debian-user mailing list.
http://lists.debian.org/debian-user/ and write there.

If you open the "console" and write lspci command, you will see line
with  VGA compatible controller and there will be written what chip it
has. So its good start to include this in that email.

You can also try some "live" linux distribution like Knoppix and boot
directly from CD. They have very good autodetection so you could copy
the configuration file /etc/X11/XF86Config-4 from there to your system.

I hope this will help.

Regards

Rudolf
