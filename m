From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: new chip driver in 2.6, question
Message-Id: <20040210215758.3c163465.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Is it OK to add new sensor chip drivers to 2.6 for old chipsets that
haven't been requested yet? I have an lm80 driver port ready, sent by
Tiago Sousa, who thought he had such a chip but in fact doesn't (it's
easily misdetected). Now that it is done, I doesn't cost much to include
it into the kernel, unless you only intend to accept requested and
tested driver.

A few facts about lm80:

1* I've half tested the driver on a misdetected lm80. Found a few
incorrectness that are now fixes. So the driver can be considered
half-tested. Thanks a lot to Lennard Klein for that.

2* LM80 chips were only used on a few QDI mainboards (in the PC world at
least), according to this MBM page:
http://mbm.livewiredev.com/comp/qdi.html

I think these are Celeron/Pentium II motherboards. It is perfectly
possible that such boards are still used these days.

3* We already support LM75, LM77 (more or less), LM78 and LM79, which
are older than the LM80 if I'm not mistaking, but also much more used.

Let me know what you think our policy should be.

(Mine would be: don't actively port unrequested drivers, but accept them
if it happens that someone provides them.)

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
