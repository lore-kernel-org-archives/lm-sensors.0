From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: lm_sensors2/kernel/chips Module.mk
Message-Id: <1080805121.406bc7015fdee@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <406B652C.5070304@verizon.net>
In-Reply-To: <406B652C.5070304@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

According to Mark Studebaker:

> you didn't check in the new file pc87360-fan.c.

Correct, I just noticed that this morning. I add forgotten to issue "cvs
add" commands for these before the mass cvs commit.

Sorry for the trouble, it's fixed by now.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
