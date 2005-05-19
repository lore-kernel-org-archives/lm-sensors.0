From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: lm_sensors2/kernel/chips lm75.h lm75.c
Message-Id: <20031211205131.69715f0b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031202053341.GB19505@earth.solarsys.private>
In-Reply-To: <20031202053341.GB19505@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Thanks!  I test the negative values (actually all range of values)
> by writing max and/or hyst with `sensors -s` and then reading
> them back with `sensors`.  In between, I use i2cdump to verify the
> register values.

Tested this, looks good (if you leave apart the fact that my computer
started beeping like crazy, or course).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
