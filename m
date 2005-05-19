From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: i2c built-in warning
Message-Id: <20030710142227.28e31eef.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030710132706.5565bbc8.khali@linux-fr.org>
In-Reply-To: <20030710132706.5565bbc8.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> After the repport we had this morning, I wonder if we shouldn't print
> some warning at the end of either make or make install if the user
> installs i2c with method 1 and has i2c already built-in his/her
> kernel. Letting i2c install quitely although we know lm_sensors will
> fail installing doesn't sound very clever.

Done (at the end of "make"), let me know if I shouldn't have.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
