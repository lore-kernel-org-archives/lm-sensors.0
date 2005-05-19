From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: [TRIVIAL 2.6] drivers/i2c/busses/i2c-piix4.c: kill duplicate
Message-Id: <20040420225351.685e51e5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040417230824.45f51061.khali@linux-fr.org>
In-Reply-To: <20040417230824.45f51061.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Maybe I'm missing something but since when <linux/config.h> is not
> needed?
> 
> Are you sure this change will not break build on some archs/configs?

I am assuming that #include <linux/config.h> is needed if and only if
the code makes use of any CONFIG_* value. Am I wrong?

> So far my experience has been (at least in 2.4) that usually header
> files don't include all required headers themselves, relying on *.c to
> include everything properly (maybe it's just on PPC though).

Such headers are broken and need fixing IMHO.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
