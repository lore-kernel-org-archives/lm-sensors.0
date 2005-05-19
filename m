From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: Quick Question: How do I turn off beep_enable alarm?
Message-Id: <20021202171319.4680b908.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0211300516220.12614-100000@home.apu.edu>
In-Reply-To: <Pine.LNX.4.44.0211300516220.12614-100000@home.apu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Thanks. What did you mean by adapter section?

Lines that begin with "chip" in sensors.conf delimit the adapter
sections. So you have to add the line in the right section if you want
it to work for you.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
