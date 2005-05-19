From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: presumed bug in magnitude code
Message-Id: <20021109191605.0b9352c5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi everyone.

I think I have located a potential bug in the magnitude code. If you
take a look at lm_sensors2/lib/proc.c, in sensors_read_proc and
sensors_write_proc, you'll see:

  for (mag = the_feature->scaling; mag > 0; mag --)
    value *= 10.0;
  for (; mag < 0; mag --)
    value /= 10.0;

It looks obvious to me that any negative magnitude would result in a
crash. It's "mag ++" on the third line, right? We never caught it
because we never had negative magnitudes, but should it happen someday,
I better commit a fix right now.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
