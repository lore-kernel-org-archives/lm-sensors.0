From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Iwill MPX2 - LM83/LM90 confusion
Message-Id: <20031007215707.333fe582.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1065536622.3f82cc6ee9ab5@imp.gcu.info>
In-Reply-To: <1065536622.3f82cc6ee9ab5@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> the LM90 only allows 1 smbus adress and thus there can not be 2

Yeah, you're perfectly right. Not having the data sheet before my eyes,
I had almost forgotten that detail. That may explain why they are using
the switching trick instead of using two monitoring chips. That said,
they obviously should have used a LM83 instead.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
