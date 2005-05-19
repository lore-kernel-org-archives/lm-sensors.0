From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: Ticket 1303
Message-Id: <20030619142634.61e80ca5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200306191404.28560.jeldo.metz@onlinehome.de>
In-Reply-To: <200306191404.28560.jeldo.metz@onlinehome.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> ok i recompiled the kernel and Patched the kernel for v4l2 support 
> The thing is with the bttv 0.9 driver it also doesnt work.

This is a known problem. We changed the i2c interface and it's not
compatible with the old one. Drivers using i2c (such as bttv) will need
to be ported to the new interface. We are aware about the problem but
had no time to work on it yet. If someone is willing to help, s/he'll be
welcome.

In the meantime, you have to chose between a working video device and an
up-to-date version of lm_sensors, sorry.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
