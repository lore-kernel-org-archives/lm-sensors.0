From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: ticket #1291
Message-Id: <20030731144108.0197c0d1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030731110954.43f2f54e.khali@linux-fr.org>
In-Reply-To: <20030731110954.43f2f54e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Since I don't really understand what happens there, and you probably
don't need isadump, let's simply skip it.

Edit the Makefile, look for that line:

SRCDIRS += lib prog/sensors prog/dump prog/detect ${PROG_EXTRA:%=prog/%}
etc

and remove the prog/dump directory:

SRCDIRS += lib prog/sensors prog/detect ${PROG_EXTRA:%=prog/%} etc

If it works for you, at least, you'll be able to use lm_sensors.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
