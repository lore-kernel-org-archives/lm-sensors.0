From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: sysconf generation
Message-Id: <20020830082115.6f785079.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1030668028.1578.41.camel@lazlo.netdot.net>
In-Reply-To: <1030668028.1578.41.camel@lazlo.netdot.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I noticed a problem with the way the sensors-detect script is
> generating the /etc/sysconfig/lm_sensors file. Its numbering modules
> like MODULE_1 MODULE_2 MODULE_3 ..., when /prog/init/lm_sensors.init
> is expecting the file to start counting at MODULE_0 and go to
> MODULE_($modules - 1). The result is that the last module isn't loaded
> and the modprobe is run without any arguments before the first module
> is loaded.
> 
> This patch on sensors-detect ought to do the trick:

This had already been reported and is fixed is the CVS version since
August 18th, 2002. Thanks anyway!

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/
