From: azarah@gentoo.org (Martin Schlemmer)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: w83781d i2c driver updated for 2.5.66 (without sysfs support)
Message-Id: <1048708449.7569.34.camel@nosferatu.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048582394.4774.7.camel@workshop.saharact.lan>
	 <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan>
	 <3E82024A.4000809@portrix.net>
In-Reply-To: <3E82024A.4000809@portrix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Greg KH <greg@kroah.com>, KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>, sensors@stimpy.netroedge.com

On Wed, 2003-03-26 at 21:40, Jan Dittmer wrote:
> Martin Schlemmer wrote:
> > 
> > I did look at the changes needed for sysfs, but this beast have
> > about 6 ctl_tables, and is hairy in general.  I am not sure what
> > is the best way to do it for the different chips, so here is what
> > I have until I or somebody else can do the sysfs stuff.
> > 
> I've just done this with the via686a driver. Saves about 100 lines of code.
> 
> Comments?
> 

Nice example, thanks =)  The w83781d does things in similar fashion,
except that it support 6 different 'models', that have more or less
the same readouts except for here and there a few more or less.


Regards,

-- 

Martin Schlemmer


-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030326/dcf89801/attachment.bin
