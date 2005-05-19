From: francois.barre@siemens.com (BARRE Francois)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: TR: [RFC][2.6] Additional i2c adapter flags for i2c client isolat
Message-Id: <EFEF4C473088B847B64CD953D2A6A10401B8EB71@sdso14a.par.siemens.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This topic makes me think of something _interresting_...
	
	According to the tests I made on my VIA Nehemiah M10k, the vt1211
can be handled by i2c-viapro as an smbus device (via the vt596 it says) and
via-ircc as an irda device, BUT this device can not be binded to both
drivers at the same time : when one is loaded (and activated), the other
finds no device (ENODEV I presume). (I wonder how I should use both smbus
*and* irda device)...

	Is this totally out of topic ?
	
	Could a hack prevent these two drivers to be mutually exclusive ?
	
(ps : sorry Jean I messed up with the To: and sent this mail to you only. I
guess I'm in need of a true holiday sooner or later...).

> -----Message d'origine-----
> De : Jean Delvare [mailto:khali@linux-fr.org] 
> Envoy? : mercredi 17 mars 2004 10:17
> ? : Greg KH
> Cc : linux-kernel@vger.kernel.org; 
> sensors@Stimpy.netroedge.com; Michael Hunold
> Objet : Re: [RFC][2.6] Additional i2c adapter flags for i2c 
> client isolation
> 
> According to Greg KH <greg@kroah.com>:
> 
> > > I guess that chip drivers would be allowed to define only one
> > > class while adapters could possibly define more than one?
> > 
> > Not necessarily.  Just make the class a bit field, showing what kind
> > of devices each expects to handle.
> 
> Of course, this is how I meant it.  The way things are done 
> for now, the
> class value is already a bitfield and I'm fine with that.  This makes
> full sense for adapters.  What I was wondering is whether it would be
> allowed to set more than one class bit for a chip driver.   
> Not that is
> necessarily matters much, I'm just curious.  Have we ever heard of
> chips that would belong to more than one class as we defined them?
> 
> > > We also would want to introduce an I2C_ADAP_CLASS_ANY define,
> > > which would be what the eeprom driver would use, for example
> > > (since it can be hosted on any kind of bus). Generic bus drivers
> > > such as i2c-parport would also use I2C_ADAP_CLASS_ANY, since the
> > > nature of the hosted chips is unknown.
> > 
> > Sure:
> > 	#define I2C_ADAP_CLASS_ANY	0xffffffff
> > works for me :)
> 
> Exactly what I had in mind ;)
> 
> > > Having clients define a class sounds also interesting from a
> > > user-space's point of view. If we would export this information
> > > through sysfs for example, programs such as "sensors" could
> > > limit their work to chips of the correct class
> > > (I2C_ADAP_CLASS_SMBUS at the moment, but a renaming is planned).
> > 
> > That also is a good idea.
> 
> How would we export the value though? Numerical, with 
> user-space headers
> to be included by user-space applications? Or converted to some
> explicit text strings so that no headers are needed?
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
> 
