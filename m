From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [PATCH 2.6] I2C: Sync i2c-id.h with legacy i2c project
Message-Id: <20050217223853.GI21188@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050206143423.41eeaef1.khali@linux-fr.org>
In-Reply-To: <20050206143423.41eeaef1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Feb 06, 2005 at 02:34:23PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> There is a change to include/linux/i2c-id.h in your bk-i2c tree which I
> suspect breaks the new i2c-au1550 bus driver:
> 
> > diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
> > --- a/include/linux/i2c-id.h	2005-02-03 18:40:18 -08:00
> > +++ b/include/linux/i2c-id.h	2005-02-03 18:40:18 -08:00
> > @@ -198,9 +198,8 @@
> >  #define I2C_ALGO_IOP3XX	0x140000	/* XSCALE IOP3XX On-chip I2C alg */
> >  #define I2C_ALGO_PCA	0x150000	/* PCA 9564 style adapters	*/
> >  
> > -#define I2C_ALGO_SIBYTE 0x150000	/* Broadcom SiByte SOCs		*/
> > -#define I2C_ALGO_SGI	0x160000        /* SGI algorithm                */
> > -#define I2C_ALGO_AU1550	0x170000        /* Au1550 PSC algorithm		*/
> > +#define I2C_ALGO_SIBYTE 0x160000	/* Broadcom SiByte SOCs		*/
> > +#define I2C_ALGO_SGI	0x170000        /* SGI algorithm                */
> >  
> >  #define I2C_ALGO_EXP	0x800000	/* experimental			*/
> >  
> 
> Please back it out and instead apply this one, which fixes the conflict
> between I2C_ALGO_SIBYTE and I2C_ALGO_PCA as well and more generally
> brings values in line with the i2c-id.h file from the i2c legacy project
> [1]. I've added comments about reserved IDs on both sides so as to avoid
> future collisions.

Ick, what a mess. I've fixed this up in my trees now, and added the
"reserved" numbers you had in your patch (why reserve them, why not just
use them :)

thanks,

greg k-h
