From: greg@kroah.com (Greg KH)
Date: Fri, 10 Jun 2005 06:40:38 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 3/3] i2c: modify sensors
Message-Id: <20050610043600.GA15061@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602033727.GD4906@jupiter.solarsys.private>
In-Reply-To: <20050602033727.GD4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jun 10, 2005 at 12:25:39AM -0400, Mark M. Hoffman wrote:
> Hi Jean:
> 
> * Mark M. Hoffman <mhoffman@lightlink.com> [2005-06-04 23:41:37 -0400]:
> > It would be easy enough to do hwmon1, hwmon2, etc. just like the usb_host
> > class does.  Everyone OK with that?
> 
> * Jean Delvare <khali@linux-fr.org> [2005-06-04 18:24:28 +0200]:
> > > Last, it would be nice if the IDs were reused on driver cycling, just
> > > like the i2c bus IDs are. You should be able to pick the code in i2c-dev
> > > and reuse it in the hwmon class.
> 
> * Mark M. Hoffman <mhoffman@lightlink.com> [2005-06-04 23:41:37 -0400]:
> > It would be nice... I'll look into it.
> 
> Actually, the bus IDs are assigned in i2c-core.  The i2c-dev ID is just a
> copy of that.  The mechanism for the ID recycling is from lib/idr.c.
> 
> AFAICT, the ID recycling is a mere side-effect of that (idr.c) modules's
> real purpose.  The way it's used in i2c-core.c feels like bloat to me.  
> I'm not certain I want to duplicate that in hwmon.c.  Opinions?

Hm, idr.c is used to generate unique ids, that's what it is there for.  

> Well, i2c_get_adapter() could actually use i2c_adapter_idr properly:
> (untested, not signed off, may eet ur branes, /me needs sleep)

Yeah, this looks probably right.  Anyone want to test it out?  :)

thanks,

greg k-h
