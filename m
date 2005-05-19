From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: I2C_ALGO_MAX
Message-Id: <20030827031106.GA1325@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806164123.5f88f7b8.khali@linux-fr.org>
In-Reply-To: <20030806164123.5f88f7b8.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Aug 23, 2003 at 04:51:04PM -0400, Mark D. Studebaker  wrote:
> 
> 
> Jean Delvare wrote:
> >>>I2C_ALGO_MAX, defined in i2c.h, doesn't seem to be used anywhere.
> >>>Same for I2C_DUMMY_MAX. Should we simply remove them?
> >>
> >>agreed. apparently these aren't registered in a static table like
> >>drivers are.
> >
> >
> >Done.
> > 
> >
> >>BTW if we want to make things better for the foolish people that want
> >>to compile-in every driver we should increase the other xxx_MAX
> >>defines.
> >
> >
> >Compiling all sensor chip drivers into the kernel is BAD. Do we want to
> >help people doing a BAD thing?
> >
> 
> I think that's what Greg was advocating...

I was?  Hm, don't remember that, I was trying to fix a real problem that
some users had, which was solved by the link order change.

But how about removing the static arrays all together.  That's what 2.6
has :)

thanks,

greg k-h
