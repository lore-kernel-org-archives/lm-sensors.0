From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: i2c-parport ancestors
Message-Id: <20040315221409.GA28297@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040313203134.1d043690.khali@linux-fr.org>
In-Reply-To: <20040313203134.1d043690.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 15, 2004 at 10:41:41PM +0100, Jean Delvare wrote:
> > > Any plan to remove i2c-elv, i2c-velleman and i2c-philips-par from
> > > the 2.6 kernel tree? Now that i2c-parport and i2c-parport-light are
> > > supposed to replace them, it would be nice if we could avoid
> > > spending energy maintaining them.
> > 
> > If you think it's ok to delete them now, I will do so.  Just let me
> > know.
> 
> Well, Aurelien Jarno confirmed that he switched from i2c-elv to
> i2c-parport without any problem, and I am myself testing i2c-parport and
> i2c-parport-light on two different systems for weeks now, without a
> problem.  So I think that everyone can safely move to these new drivers
> now, and the best way to invite them to do so is probably to simply
> remove the older drivers from the kernel tree.

Ok, I've now deleted them.  If people scream, we can always go back and
add them later :)

thanks,

greg k-h
