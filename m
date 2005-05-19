From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: gl518sm chip driver for 2.6 kernel
Message-Id: <1075297829.4017be25d7699@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075295349.4017b475e9031@imp.gcu.info>
In-Reply-To: <1075295349.4017b475e9031@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Yes, I did follow the guidelines as well as the sysfs-interface, but
> since its my first kernel module attempt, it might need improvement.

Hopefully the code review will be quick then :) I'll let you know my
impressions.

> I can also help with other ports if there's a need, since am familiar
> with it.

This is very welcome, since only 25% of the chip drivers have been
ported so far. Basically, all drivers that have not been ported yet are
good candidates. Ports in progress are: adm1025, bt869, fscher and
vt1211. So you can pick any other. You should focus on drivers you have
the hardware to test, if possible, since it's much better if the port
is tested by at least one person before being released. If you start
another port, just let us know so that we can update our list.

Thanks a lot for your work.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
