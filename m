From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: Ticket 1382 : Update
Message-Id: <20030823214825.57a2ad91.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
In-Reply-To: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I've found the solution to my problem (apparently at least).
> I downloaded a vanilla kernel, instead of the distro kernel, and
> voil?. It worked. At least, it compiled, but I'm confident :)
> 
> The kernel was Mandrake 9.1 updated 2.4.21-0.25mdk. Compilation was ok
> with i2c patch only, but broken with lm-sensors patch.

I suspect that the Mandrake kernel *already* contains an i2c and/or
lm_sensors patches that conflict with the more recent ones you were
trying to use. The drivers/sensors/sensors.c file is gone from our
distribution by now (as is sensors_init_all).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
