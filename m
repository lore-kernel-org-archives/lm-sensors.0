From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: lm_sensors2/kernel/chips lm75.h lm75.c
Message-Id: <20031202231313.0672fc2d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031202053341.GB19505@earth.solarsys.private>
In-Reply-To: <20031202053341.GB19505@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> This works nicely for me - negative values ok, 1/2 degree increments
> ok - but I should mention I tested it on asb100 and w83627thf (code
> not yet committed).  I haven't actually tested on lm75 itself; I don't
> have one.

Gave it a try on my old system with a real LM75 on it. Looks OK,
although I did not test negative values (how would you do that??) nor
did I do extended tests. Just seems to work :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
