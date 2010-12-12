From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Dec 2010 18:03:11 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <20101212190311.34718ef5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again Juerg,

On Fri, 10 Dec 2010 15:27:02 +0100, Jean Delvare wrote:
> On Fri, 10 Dec 2010 10:43:57 +0100, Juerg Haefliger wrote:
> > --- dme1737.c	2010-08-02 00:11:14.000000000 +0200
> > +++ /home/khali/dme1737.c	2010-12-10 14:39:04.000000000 +0100
> (...)
> > -/* Voltages (in) numbered 0-6 (ix) */
> > -#define	DME1737_REG_IN(ix)		((ix) < 5 ? 0x20 + (ix) \
> > -						  : 0x94 + (ix))
> > -#define	DME1737_REG_IN_MIN(ix)		((ix) < 5 ? 0x44 + (ix) * 2 \
> > -						  : 0x91 + (ix) * 2)
> > -#define	DME1737_REG_IN_MAX(ix)		((ix) < 5 ? 0x45 + (ix) * 2 \
> > -						  : 0x92 + (ix) * 2)
> > +/* Voltages (in) numbered 0-7 (ix) */
> > +#define	DME1737_REG_IN(ix)		((ix) < 5 ? 0x20 + (ix) : \
> > +					 (ix) < 7 ? 0x94 + (ix) : \
> > +						    0x1f)
> > +#define	DME1737_REG_IN_MIN(ix)		((ix) < 5 ? 0x44 + (ix) * 2 : \
> > +					 (ix) < 7 ? 0x91 + (ix) * 2 : \
> > +						    0x9f)
> > +#define	DME1737_REG_IN_MAX(ix)		((ix) < 5 ? 0x45 + (ix) * 2 : \
> > +					 (ix) < 7 ? 0x92 + (ix) * 2 : \
> > +						    0xa0)

I just noticed that 0x91 + 7 * 2 = 0x9f and 0x92 + 7 * 2 = 0xa0. So
the changes to DME1737_REG_IN_MIN and DME1737_REG_IN_MAX are no-ops.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
