From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: w83781d kernel module bug report
Message-Id: <20040205222156.35d2f536.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>         Hi! I upgraded my Linux kernel from 2.6.1 to 2.6.2, but the
> temperature now shows incorrectly:

As mentioned on our Linux 2.6 dedicated page, Linux 2.6.2-rc1 and later
need lm_sensors CVS (or 2.8.4 as soon as we release it) in order to work
properly.

Update to lm_sensors CVS or wait for 2.8.4 to be released. The
temperature magnitude problem should go away.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
