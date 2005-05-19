From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [PATCH] eeprom chip driver for 2.6
Message-Id: <20030924225308.06e428b9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030923232510.GB6265@kroah.com>
In-Reply-To: <20030923232510.GB6265@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Overall, it's OK for me. I'm still concerned by the performance
> > issue. This driver will be far "slower" than current CVS' one (from
> > sensors' point of view) but this has already been discussed and I
> > have no concrete solution to propose, so let's forget about it.
> 
> Ah, missed that part of your change to the driver.  Patches are always
> welcome :)

I'm not sure something can be done. If I understood it correctly, you
now have one single binary file. The trick I introduced in the CVS
driver was to refresh the EEPROM contents by rows (32 bytes) instead of
reading it all at once. It allowed faster response on "queries" that
were only affecting one part of the EEPROM. It fitted our driver
structure rather well because the EEPROM is split over 16 16-value
files. Now that there is a single file, I suppose that nothing similar
can be done. Of course, if you do have an idea, let us know.

> > > +/* EEPROM memory types: */
> > > +#define ONE_K			1
> > > +#define TWO_K			2
> > > +#define FOUR_K			3
> > > +#define EIGHT_K			4
> > > +#define SIXTEEN_K		5
> > > 
> > 
> > This could go away, the defines are unused as far as I can tell.
> 
> Looks that way, thanks.  Same thing for the cvs version too...

Done.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
