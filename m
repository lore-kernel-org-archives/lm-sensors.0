From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: lm_sensors2/kernel/chips lm83.c
Message-Id: <20030704120615.66bdc155.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Update of /home/cvs/lm_sensors2/kernel/chips
> In directory mordac.netroedge.com:/tmp/cvs-serv6865
> 
> Modified Files:
> 	lm83.c 
> Log Message:
> (Khali) Add missing include.

BTW what's the <linux/init.h> include for? The module compiled and
loaded just fine without it.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
