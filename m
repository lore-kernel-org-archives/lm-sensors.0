From: bunk@stusta.de (Adrian Bunk)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: drivers/w1/: why is dscore.c not ds9490r.c ?
Message-Id: <20041121220251.GE13254@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: johnpol@2ka.mipt.ru
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

Hi Evgeniy,

drivers/w1/Makefile in recent 2.6 kernels contains:
  obj-$(CONFIG_W1_DS9490)         += ds9490r.o 
  ds9490r-objs    := dscore.o

Is there a reason, why dscore.c isn't simply named ds9490r.c ?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
