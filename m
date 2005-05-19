From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [PATCH] eeprom chip driver for 2.6
Message-Id: <1064387595.3f71440b4105c@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030923232510.GB6265@kroah.com>
In-Reply-To: <20030923232510.GB6265@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Ok, I finally got the sysfs binary file interface hooked up to the
> eeprom driver in 2.6.  Turned out to be easier than I thought.  Below
> is the patch that I'll be sending to Linus in a bit.  If anyone has
> any comments on it, I'd appreciate it.

> p.s. I added the Viao check too :)

Thanks :) BTW, where is my name? ;)) (just kidding)

Overall, it's OK for me. I'm still concerned by the performance issue.
This driver will be far "slower" than current CVS' one (from sensors'
point of view) but this has already been discussed and I have no
concrete solution to propose, so let's forget about it.

> +/* EEPROM memory types: */
> +#define ONE_K			1
> +#define TWO_K			2
> +#define FOUR_K			3
> +#define EIGHT_K			4
> +#define SIXTEEN_K		5
> 

This could go away, the defines are unused as far as I can tell.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
