From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: New driver for MAX663x temperature sensor.
Message-Id: <20040414212404.2ddd7a46.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081775028.11592.294.camel@uganda>
In-Reply-To: <1081775028.11592.294.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Attached patch for lm_sensors (...)

OK, applied with some changes, fixes and improvements. I would
appreciate it if you could check it out from CVS and test.

BTW, quoting myself:

> > +	for (i=0; i<32; ++i)
>
> You can skip i=0, it cannot fail.

Of course not. It cannot fail *if* the registers are read only, but we
don't know if they are (hey, this is why we are testing). That said,
reverting the for loop order would leave more time for the values to
change if they have to (but I didn't do that it the patch however).

Thanks for your contribution to our project.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
