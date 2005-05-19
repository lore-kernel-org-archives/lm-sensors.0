From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: [Fwd: Re: I2C drivers]
Message-Id: <20030914000212.16a5b5d7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F4B8C57.50709@edgedesign.us>
In-Reply-To: <3F4B8C57.50709@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Would anybody mind allocating Ralf a couple ID's?  Thanks!
> 
> Phil
> 
> -------- Original Message --------
> (...)
> The two new driver IDs are:

I see three of them. Or I am drunk? ;)

> #define I2C_DRIVERID_MAX1617    56     /* temp sensor */
> #define I2C_DRIVERID_SAA7191   57      /* video encoder */
> #define I2C_DRIVERID_INDYCAM   50      /* SGI IndyCam */

MAX1617 and SAA7191 are OK, but INDYCAM will be 58.

> Also two new algorithms:
> 
> #define I2C_ALGO_SIBYTE	0x150000	/* Broadcom SiByte SOCs         */
> #define I2C_ALGO_SGI	0x160000	/* SGI algorithm                */

OK, they are yours.

> I need an ID for both 2.4 and 2.6 but I assume you keep those numbers
> in sync anyway?  The numbers above are what I'm currently using.

Yes, the numbers are more or less kept in sync. Sadly enough, not
everyone requests IDs before using them, so 2.4, 2.6 and i2c-I2C are
sometimes slightly out of sync, but most of the time everything ends up
;)

> Thanks,

You're welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
