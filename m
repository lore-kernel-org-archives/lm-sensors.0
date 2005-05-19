From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: Linux 2.6.3, lm_sensors 2.8.5
Message-Id: <20040224210926.436d185b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040218232559.2621d402.khali@linux-fr.org>
In-Reply-To: <20040218232559.2621d402.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Thanks a lot! Rebuilding kernels, lm_sensors and kernel modules for
> all other projects took me quite some time, but now there is the
> latest FC1 kernel with patched in lm_sensors/i2c 2.8.4 as well as
> lm_sensors 2.8.4 userland bits (and external kernel modules, but they
> are probably redundant) available at
> 
> 	 http://atrpms.physik.fu-berlin.de/name/kernel/
> 	 http://atrpms.physik.fu-berlin.de/name/lm_sensors/

BTW, I have fixed the unnecessary dependencies that lm_sensors-2.8.2, .3
and .4 had to i2c-2.8.2, .3 and .4, respectively. Thus, lm_sensors
2.8.5, when we release it, will need i2c 2.8.1 only.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
