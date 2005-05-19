From: John.Morris@spirentcom.com (Morris, John)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: CVS?
Message-Id: <629E717C12A8694A88FAA6BEF9FFCD44056485DB@brigadoon.spirentcom.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <629E717C12A8694A88FAA6BEF9FFCD440564855E@brigadoon.spirentcom.com>
In-Reply-To: <629E717C12A8694A88FAA6BEF9FFCD440564855E@brigadoon.spirentcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Wednesday, April 07, 2004 2:43 PM
> To: Morris, John
> Cc: sensors@Stimpy.netroedge.com
> Subject: Re: CVS?
> 
> 
> > > > Sensors-detect sees it (at address 0x7C) but cannot identify it.
> > > > The documentation calls it "Embedded PCI-X On Board Registers".
> > > > Does that mean anything to anyone?
> > > 
> > > In case you didn't notice it already, 0x7C isn't a 
> standard address.
> > > It's marked "Reserved for future use" in the SMBus 2.0
> > > specification, and latest version of i2cdetect and sensors-detect
> > > don't even scan it.
> > 
> > I didn't know - thanks.
> > 
> > However, I'm stuck with it - it's not our hardware.
> > 
> > I'll mention it to the supplier next time they come in.
> 
> Oh, well, it was just a remark. It may be the correct address 
> for them.
> It used to be "reserved for future use" and we are in the future (from
> the specs point of view). Maybe now that address is used for, say,
> accessing Embedded PCI-X On Board Registers? ;)
> 
> > Meanwhile, I have to get the driver working, but what I'm
> > hearing is that nobody else will be interested - or at least,
> > not as part of the standard sensors release.  Is
> > there anything in the code that will actively stop a
> > chip driver using it? I can live without i2cdetect and
> > sensors-detect for this one. I'll I2C_DRIVERID_EXP0
> > for it to avoid clashes.
> 
> I don't know if the address will be supported by the i2c-core. I gues
> you'll now soon enough ;)
> 
> > On a lighter note - I asked our IT department if they
> > had recently started blocking the CVS port (2401) on 
> > the firewall and explained why I was asking, and got 
> > the reply "so what web page can't you see?"
> > 
> > Ho-hum - off to do a bit of education..
> 
> Mouahahaha :)
> 
> Oh, sorry, it's no fun actually.
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
> 
