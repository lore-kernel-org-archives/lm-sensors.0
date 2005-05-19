From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: Quick Question: How do I turn off beep_enable alarm?
Message-Id: <20021202144037.50a301af.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0211300516220.12614-100000@home.apu.edu>
In-Reply-To: <Pine.LNX.4.44.0211300516220.12614-100000@home.apu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Is there a way? I can't find in the message archive, Web site, 
> documentation, sensors.conf file, and FAQ. I might have overlooked it.

I'd simply try to add "ignore beep_alarm" in sensors.conf (in the
correct adapter section).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
