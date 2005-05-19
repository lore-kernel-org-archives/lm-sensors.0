From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: Finding user/kernel pointer bugs [no html]
Message-Id: <20040610193207.GA1904@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> <20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk> <20040610165821.GB32577@kroah.com> <20040610191004.GA1661@kroah.com> <20040610191359.GJ12308@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040610191359.GJ12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: sensors@stimpy.netroedge.com, "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>, Linux Kernel <linux-kernel@vger.kernel.org>

On Thu, Jun 10, 2004 at 08:14:00PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Thu, Jun 10, 2004 at 12:10:04PM -0700, Greg KH wrote:
> > @@ -170,8 +170,11 @@
> >  static int DIV_TO_REG(int val)
> >  {
> >  	int answer = 0;
> > -	while ((val >>= 1))
> > +	val >>= 1;
> > +	while (val) {
> >  		answer++;
> > +		val >>= 1;
> > +	}
> >  	return answer;
> 
> That's less readable than the original...

Hm, so we should ignore the sparse warning about the original then?

> > -		data_ptrs = (u8 **) kmalloc(rdwr_arg.nmsgs * sizeof(u8 *),
> > -					    GFP_KERNEL);
> > +		data_ptrs = kmalloc(rdwr_arg.nmsgs * sizeof(u8 __user *), GFP_KERNEL);
> 
> While we are at it, what's the type of ->nmsgs?

include/linux/i2c-dev.h states it is __u32.  Any problems with that?

thanks,

greg k-h
