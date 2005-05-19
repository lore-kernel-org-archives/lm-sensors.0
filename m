From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Ticket number 1467
Message-Id: <20031210225306.55ceb34e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Version 2.8.0:
> (...)
> -12V:     -12.13 V  (min = -13.21 V, max = -10.90 V)
> -5V:       -5.10 V  (min =  -5.26 V, max =  -4.76 V)
> (...)
> Version 2.8.1:
> (...)
> -12V:      -2.15 V  (min = -13.23 V, max = -10.73 V)
> -5V:       -1.25 V  (min =  -5.25 V, max =  -4.74 V)

Strange. (Did I already mentioned how I hate Asus chips?)

Took a look at the w83781d driver changes between 2.8.0 and 2.8.1, I
don't see anything that could explain this.

Two more things I'd like you to try if possible:

1* CVS version of lm_sensors (works with the i2c-2.8.1 patch).
http://secure.netroedge.com/~lm78/download.html#cvs

2* Provide the readings from /proc/sys/dev/sensors/as99127f-i2c-0-2d/in5
and in6 with both 2.8.0 and 2.8.1. The problem could be in the library,
not the driver. If the readings from the /proc files are similar using
2.8.0 and 2.8.1, then the problem isn't in the driver itself.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
