From: louis-martin.cote@verint.com (cote, louis-martin)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: Possible bug in i2c_register_entry ?
Message-Id: <6C25030C55C5D84FBEFD632E96673065310998@mtlmail1.Co.Corp.VerintSystems.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I stumbled upon a possible bug in i2c_register_entry() (file i2c-proc.c).

The function counts the number if sysctl entries by looking at i2c_client.procname .
My sensor module needs to register sysctls that are not visible through proc, so their procname entry is NULL.

My question is: shouldn't i2c_register_entry() rely on i2c_client.ctl_name for counting the number of entries ?

If this is not the place to post this sort of question, please point me to the right place,

Thanks,

Louis-Martin C?t?
BSP Designer
Verint Video Solutions
[T] 450.686.9000 x 376
[F] 450.686.0198
[E] louis-martin.cote@verint.com


