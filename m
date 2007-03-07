From: krzysztof.h1@wp.pl (Krzysztof Helt)
Date: Wed, 07 Mar 2007 08:49:25 +0000
Subject: [lm-sensors] [PATCH] THMC50 and ADM1022 support for 2.6 kernel
Message-Id: <45ee7c951cbed@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for THMC50 and ADM1022 chips to 2.6 kernels.

Signed-off-by: Krzysztof Helt <krzysztof.h1 at wp.pl>

---

This patch is improved comparing to previous one: 
 * it allows selection of ADM1022 working mode (THMC50 or
additional remote temperature)
 * adds doc file 
 * stops the fan with pwm1 setting to 0
 * removes interrupt mask and status files from sysfs.

Regards,
Krzysztof

----------------------------------------------------
Producenci "Opowie?ci z Narnii" przedstawiaj?: 
Wielka przygoda w ?wiecie, w kt?rym wszystko jest mo?liwe!
MOST DO TERABITHII - w kinach od 9 marca!
http://klik.wp.pl/?adr=http%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fmost.html&sid44
-------------- next part --------------
A non-text attachment was scrubbed...
Name: thmc50b.diff
Type: text/x-patch
Size: 19476 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070307/e89ceb4e/attachment-0001.bin 
