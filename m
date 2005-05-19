From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Additional info for ticket #1148
Message-Id: <20030612082005.550c14e9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1054890869.11041.3.camel@nazgul>
In-Reply-To: <1054890869.11041.3.camel@nazgul>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> i2c-proc.o version 2.6.1 (20010825)
> w83781d.o version 2.6.5 (20020915)
> (...)
> This is kernel 2.4.20, could it be the oldish i2c version?  Thanks for
> any info -Dan

You really should stick to one given version of i2c AND lm_sensors or
you're guaranteed to fall into death traps rather quickly. I don't know
how you managed to reach the point you're at, but you're supposed to
install the i2c version that matches the lm_sensors version you intend
to use, *before* installing lm_sensors. Also, don't you forget to issue
a "depmod -a" between the installations of i2c and lm_sensors.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
