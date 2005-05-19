From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: lm_sensors2/kernel/chips asb100.c
Message-Id: <20040511041637.GD20204@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040508154719.4d486f2f.khali@linux-fr.org>
In-Reply-To: <20040508154719.4d486f2f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-05-08 15:47:19 +0200]:
> > Modified Files:
> > 	asb100.c 
> > Log Message:
> > (Khali) Backport memory allocation reworking from Linux 2.6.
> 
> Mark (Hoffman), (or anyone else with an ASB100 chip) can you please test
> this?

Looks right... although now I understand the comment about it being
odd code ;) Works OK here too.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
