From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: lm_sensors2/kernel/busses i2c-i810.c i2c-savage4.c
Message-Id: <20030922205503.4e5bbd99.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030922044140.GA17134@earth.solarsys.private>
In-Reply-To: <20030922044140.GA17134@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Modified Files:
> > 	i2c-i810.c i2c-savage4.c i2c-voodoo3.c 
> > Log Message:
> > (mmh) Use readl/writel for portable access to PCI memory
> 
> Testers?  I don't have any of this H/W...

I don't either, but could have access to a Voodoo3-based board within a
few days, if nobody else can test before.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
