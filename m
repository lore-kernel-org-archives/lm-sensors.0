From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: i2c-philips-par
Message-Id: <1074182942.4006bb1e3fdf9@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

For the problem where i2c-philips-par doesn't compile, try adding:
#include <asm/param.h> /* for HZ */
after the other includes in kernel/i2c-philips-par.c.

Strange why most people don't need that and you both would... Please
report successes or failures.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
