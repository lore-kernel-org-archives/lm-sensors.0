From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: driver design question
Message-Id: <20030728153714.7b09e0b7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

Reading some code today, I noticed that most of our drivers, if not all,
read the current values and the limit values when updated. Why that? I
would have read the current values only. We set the limits ourself
(either at init time or through procfs/sysfs) so they are unlikely to
have changed. Looks like an overhead we could easily get rid of. Is
there something obvious I am missing?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
