From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: fan speed for it87?? chips added
Message-Id: <20030926213431.GA18399@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309232035.29480.michael.hufer@freenet.de>
In-Reply-To: <200309232035.29480.michael.hufer@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Sep 25, 2003 at 07:33:39PM +0200, Michael Hufer wrote:
> > BTW,
> >
> > -#define DIV_TO_REG(val) ((val)=8?3:(val)=4?2:(val)=1?0:1)
> > +extern inline u8 DIV_TO_REG(long val)
> > +{
> > +	if( val = 1 )
> > +		return 0;
> > +	u8 i;
> > +	for( i = 1; i < 7; i++ )
> > +	{
> > +		if( val = 1<<i )
> > +			return i;
> > +	}
> > +	return 7;
> > +}
> >
> > (BTW, does this really compile? I thought you couldn't declare a
> > variable after real code in a given block.)
> 
> Umm..., I'm a C++ guy :-) and in C++ it is perfectly OK to declare a variable 
> anywhere inside a block. It compiles perfectly with gcc 3.3.1 on my SuSE 8.2 
> box, anyway.

It will not compile properly with older versions of gcc which are still
allowed to build the kernel with (like gcc 2.96 or so.)

thanks,

greg k-h
