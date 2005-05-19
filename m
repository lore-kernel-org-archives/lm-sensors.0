From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: About LM-sensor
Message-Id: <20030712154401.214c1e24.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0307122015530.3622-100000@land4.nsu.ru>
In-Reply-To: <Pine.LNX.4.21.0307122015530.3622-100000@land4.nsu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hello
> I have a problem.
> * kernel - 2.4.21
> * i2c - 2.7.0 from your
> site: http://secure.netroedge.com/~lm78/archive/i2c-2.7.0.tar.gz
> lm sensors (2.7.0) say that i2c is too old
> Thanks
> Eugene

Known problem. This is a headers include order issue. See there:
  http://secure.netroedge.com/~lm78/
New item dated "May 31st, 2003" brings the solution:

"The lm_sensors compile sees i2c headers in the kernel include directory
before it sees them in /usr/local/include; try the updated Makefile in
CVS for a fix. The new file etc/config.c is also required."
  http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/Makefile
  http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/etc/config.c

(And you should not send mail as root.)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
