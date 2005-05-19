From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [PATCH] eeprom chip driver for 2.6
Message-Id: <20030924220002.GB12016@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030923232510.GB6265@kroah.com>
In-Reply-To: <20030923232510.GB6265@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 24, 2003 at 10:53:08PM +0200, Jean Delvare wrote:
> 
> > > Overall, it's OK for me. I'm still concerned by the performance
> > > issue. This driver will be far "slower" than current CVS' one (from
> > > sensors' point of view) but this has already been discussed and I
> > > have no concrete solution to propose, so let's forget about it.
> > 
> > Ah, missed that part of your change to the driver.  Patches are always
> > welcome :)
> 
> I'm not sure something can be done. If I understood it correctly, you
> now have one single binary file. The trick I introduced in the CVS
> driver was to refresh the EEPROM contents by rows (32 bytes) instead of
> reading it all at once. It allowed faster response on "queries" that
> were only affecting one part of the EEPROM. It fitted our driver
> structure rather well because the EEPROM is split over 16 16-value
> files. Now that there is a single file, I suppose that nothing similar
> can be done. Of course, if you do have an idea, let us know.

Ah, yeah, that probably will not work now.

Oh well, we don't really need to worry about speed here :)

thanks,

greg k-h
