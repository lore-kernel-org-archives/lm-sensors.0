From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: lm_sensors and kernel 2.6.1
Message-Id: <1073651892.3ffea0b4c695d@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1073648608.1269.3.camel@bubursuc.celuloza.ro>
In-Reply-To: <1073648608.1269.3.camel@bubursuc.celuloza.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> has anything changed in sysfs since 2.6.0?
> because on 2.6.0 sensors worked, now it says:
> (...)
> ERROR: Can't get TEMP data!
> ERROR: Can't get TEMP2 data!
> ERROR: Can't get TEMP3 data!

You need lm_sensors from CVS:
http://secure.netroedge.com/~lm78/download.html#cvs

Lm_sensors 2.8.2 had a quirk to workaround a file naming error in Linux
2.6.0 drivers. The error has been fixed in 2.6.1-rc1, and lm_sensors
CVS has been unquirked accordingly.

We might consider releasing 2.8.3 to avoid this issue being reported
repeatedly, or at least add a news item on our main page to mention the
solution.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
