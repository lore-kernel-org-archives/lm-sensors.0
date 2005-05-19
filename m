From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: MAX6650 driver
Message-Id: <20030829185148.6d0e2319.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030827130911.2931281e.khali@linux-fr.org>
In-Reply-To: <20030827130911.2931281e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> ok, I'll submit mine to CVS.

Yes please :)

> Let's start working through the new_drivers check list...
> 
> It's ok to put my name on the "New Drivers" page.

Done.

> I need an ID reserved in i2c-id.h. I suggest:
> 
> --- kernel/i2c-id.h     23 Aug 2003 20:32:57 -0000      1.77
> +++ kernel/i2c-id.h     29 Aug 2003 13:35:39 -0000
> @@ -157,6 +157,7 @@
>  #define I2C_DRIVERID_SAA1064 1041
>  #define I2C_DRIVERID_LM90 1042
>  #define I2C_DRIVERID_ASB100 1043
> +#define I2C_DRIVERID_MAX6650 1044

This ID is now yours ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
