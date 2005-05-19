From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Ticket 1319 - lm_sensors-2.8.0-cvs linux-2.4.20-smp-i386
Message-Id: <20030710101047.0b576ccb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030710085158.42e68c95.zdavatz@ywesee.com>
In-Reply-To: <20030710085158.42e68c95.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Still get the same error.
> 
> Did I miss anything?

Let's see. Please locate *all* "i2c.h" files that are present on your
system. Either do:
  dbupdate
  locate i2c.h
or:
  find / -name "i2c.h"

And tell me what it returns. Your lm_sensors compilation error shows
that a bad i2c.h file must be picked instead of the new one. If we knew
where it is lurking, we could maybe understand what's going wrong.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
