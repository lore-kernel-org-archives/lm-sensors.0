From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: i2c-proc module reference counting
Message-Id: <Pine.LNX.4.53.0311241415100.27319@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I have reviewed some old changes in (now obsoleted) lk-2-4 branch
of i2c sources. I believe, that in the process of <2.4 cleanup,
reference counting for modules is completely lost.

That is, one may call rmmod to remove either a sensor client or its
adapter module, while one of its sysctl's (file/dir under
/proc/sys/dev/sensors/) is open.

Even i2c release 2.7.0 counts for client usage only. As adapter removal
will detach the client as well, I am not convinced this is enough.

I do not know if sysfs handles this correctly?

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>  +358 50 462 8786
