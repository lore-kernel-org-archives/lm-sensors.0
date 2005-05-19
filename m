From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: sensors CVS updates for weekend
Message-Id: <Pine.OSF.4.50.0302072336210.31635-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I hope I get the major clean-up finished on Saturday. This involves
going through the PCI detection routines and putting back some printk's
with no hardware to test.

Apparantely I did introduce some compile-time problems. Some reports are
clearly use of old kernel/i2c headers, some not so obvious and not
reproducable to me.


-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
