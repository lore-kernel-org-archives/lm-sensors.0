From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: header files installed by i2c
Message-Id: <20041206225703.6b3f48e7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I can see that i2c install many headers in /usr/local/include/linux. All
these are *kernel* headers. As I understand it, they are useless for
user-space applications and should not be copied there. Any objection to
me removing their export from i2c/kernel/Module.mk?

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
