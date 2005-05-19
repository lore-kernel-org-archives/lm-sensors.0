From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: New i2c-algo-biths
Message-Id: <Pine.OSF.4.50.0301081558310.19594-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I'd like to make the improved (?) driver easily available.

Any objections, if I

 - add this to mkpatch
 - have some CONFIG_ to use -biths in place of -bit
 - import -biths.h in i2c-algo-bit.h
 - promote it on video4linux list

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
