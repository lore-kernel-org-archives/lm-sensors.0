From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [PATCH] Fix for libsensors.3
Message-Id: <20040320194506.4435af0a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040320175110.GB20666@pc.aurel32.private>
In-Reply-To: <20040320175110.GB20666@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The include line given in libsensors.3 is wrong. It should be
> #include <sensors/sensors.h> instead of #include <sensors.h>
> 
> The attached patch against the current CVS fixes that.

Correct. Applied, thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
