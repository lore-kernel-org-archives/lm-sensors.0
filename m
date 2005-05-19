From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: I2C patch for Linux 2.4
Message-Id: <20030719082134.33495260.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030712095859.64d3cefa.khali@linux-fr.org>
In-Reply-To: <20030712095859.64d3cefa.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> It's not for nothing.  The speed of the 2.4.22-pre development tree
> just supprised me, so we've missed this window.

I suppose they try to avoid the long cycle they had for .21-pre, the
same way we will make sure lm_sensors 2.8.1 is our before seven more
months pass by.

>  We should aim for 2.4.23-pre1, sound ok?

It's OK for me. I will regenerate a set of patches for 2.4.22 when it's
out, so that our users can keep using both lm_sensors and other i2c
devices while still using the latest stable kernel.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
