From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: bus scan removal
Message-Id: <20031221100543.28eaf2ff.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ky?sti,

In the process of merging our i2c CVS repository changes into the Linux
2.4 kernel, I saw that, back in January 2003, you removed bus scanning
from two drivers (i2c-algo-bit and i2c-algo-pcf). What was your reason
for doing so? Is it because it was unused, or because i2cdetect can be
used instead, or both, or any other reason I didn't think of?

I took a look at the i2c drivers present in both Linux 2.4 and 2.6, and
it turns out that there are other drivers still having a bus scanning
parameter (i2c-algo-ite.c and i2c-algo-sibyte.c in 2.4, i2c-algo-ite.c
and i2c-ibm_iic.c in 2.6). As I will be submitting a patch to remove bus
scanning from "our" drivers (i2c-algo-bit and i2c-algo-pcf), I'm
wondering if I should do the same for these extra drivers as well.

BTW, does i2cdetect work on non-i386 architectures?

Any insight on your original motivations appreciated.

The patch will also remove SLO_IO usage, since it is supposed not to
compile anymore anyway, and cleanup headers.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
