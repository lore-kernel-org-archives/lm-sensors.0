From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: i2c-rpx headers
Message-Id: <20031231180628.4df26bfe.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Any reason why i2c-rpx.c is including both ioports.h and parport.h (in
both i2c CVS and linux 2.6.1-rc1)? To me it needs neither.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
