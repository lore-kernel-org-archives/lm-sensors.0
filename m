From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: Quick Question: How do I turn off beep_enable alarm?
Message-Id: <20021202205602.3f495e5b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0211300516220.12614-100000@home.apu.edu>
In-Reply-To: <Pine.LNX.4.44.0211300516220.12614-100000@home.apu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Ah thanks. I thought there was a global setting. I checked my other
> Linux box and its sensors.conf doesn't have ignore beep_alarm lines
> anywhere. Yet, sensors v2.6.1 command shows: 
> 
> beep_enable:
>           Sound alarm disabled

Sounds logical, adding an "ignore beep_alarm" line would prevent sensors
from displaying it. BTW, I invite you to update senors to at least
2.6.3, 2.6.5 would be better.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
