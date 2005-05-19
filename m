From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c-1.8.4 and lm_sensors-2.8.5 -- a comment
Message-Id: <1082468677.40852945a382e@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0404201404510.1296@pcl321.mppmu.mpg.de>
In-Reply-To: <Pine.LNX.4.58.0404201404510.1296@pcl321.mppmu.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> But I wouldn't change current behaviour, as packagers know how to
> work around this and users will certainly forget to issue a depmod if
> it isn't done automatically.

Well, Peter was proposing to remove the depmod call only if DESTDIR is
set. It makes sense if the depmod is of no use for packagers, or even
bugs them. The only special case I could think of is the
cross-installation I was mentionning in my previous post, but this is a
rare case and people in that case are likely to be used to run depmod
by themselves with the correct options.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
