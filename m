From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: remove 2.2 support?
Message-Id: <Pine.OSF.4.50.0301132021440.4463-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E0E709B.5000900@paradyne.com>
In-Reply-To: <3E0E709B.5000900@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I have i2c now in sync with 2.5.54, waiting for branch.

The same thing as sensors.h suffered happened to i2c-dev.h, userland
exports were removed. So I left that part unpathced.

There are some bits worth of porting back to 2.4:
 - check_region vs. request_region
 - MINOR() vs minor() for /dev
 - /dev with devfs

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
