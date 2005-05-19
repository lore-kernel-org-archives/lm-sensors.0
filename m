From: azarah@gentoo.org (Martin Schlemmer)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: w83781d i2c driver updated for 2.5.66 (without sysfs support)
Message-Id: <1048721671.7569.46.camel@nosferatu.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048582394.4774.7.camel@workshop.saharact.lan>
	 <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan>
	 <20030326202904.GK24689@kroah.com>
In-Reply-To: <20030326202904.GK24689@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>, sensors@Stimpy.netroedge.com

On Wed, 2003-03-26 at 22:29, Greg KH wrote:

> Some of the nasty casts should be fixed up though.  Stuff like:
> 
> > +      ERROR7:
> > +	if (!is_isa)
> > +		i2c_detach_client(&
> > +				  (((struct w83781d_data
> > +				     *) (i2c_get_clientdata(new_client)))->
> > +				   lm75[1]));
> > +      ERROR6:
> > +	if (!is_isa)
> > +		i2c_detach_client(&
> > +				  (((struct w83781d_data
> > +				     *) (i2c_get_clientdata(new_client)))->
> > +				   lm75[0]));
> > +      ERROR5:
> > +	if (!is_isa)
> > +		kfree(((struct w83781d_data *) (i2c_get_clientdata(new_client)))->
> > +		      lm75);
> 
> Is just obnoxious :)
> 

Quick question .... With sysfs, is it not needed to call
i2c_detach_client ?   I am asking this as it seems from patches
that you remove all these calls ...


Regards,

-- 

Martin Schlemmer



-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030327/e8b15229/attachment.bin
