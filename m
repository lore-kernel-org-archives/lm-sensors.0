From: gdavis@mvista.com (George G. Davis)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: adm1031 driver
Message-Id: <3C867170.B6CF1E32@mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <6DEE94132593D41182D200508BDCA590A2C19F@mail.tricord.com>
In-Reply-To: <6DEE94132593D41182D200508BDCA590A2C19F@mail.tricord.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

phil@netroedge.com wrote:
> 
> I believe George is working on it, or will shortly.  Perhaps you two
> could coordinate your efforts?

Sorry, my initial reply-all bounced from the list (sensors@netroedge.com).
Hopefully this one won't do the same.  : )

We've been exchanging e-mail. I'm still waiting for my eval board though.
I've pinged Mary to check on delivery status in the meantime.


Thanks!

--
Regards,
George

> 
> Phil
> 
> On Wed, Mar 06, 2002 at 12:03:38PM -0600, Rendahl, Aaron wrote:
> > Hello,
> >
> > I'm working on a driver for the adm1031 chip, as on the web page it says
> > that this driver is not planned and there have been no requests.
> >
> > However, I just found the "new_drivers" documentation, so am belatedly
> > writing to check if anyone else is working on it.
> >
> > I don't anticipate the driver using the full capability of the chip (there
> > are options to control the fan speed that I don't think I'll need), but it
> > does read the temperature and fan measurements.
> >
> > If that's useful enough to be included, please reserve an ID for this chip
> > in i2c-id.h.  Also, it's OK to put my name on the "New Drivers" page.
> >
> > Thanks for all of your terrific work.
> >
> > Aaron Rendahl
> > Tricord Systems
> > arendahl@tricord.com
> 
> --
> Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
>    phil@netroedge.com -- http://www.netroedge.com/~phil
>  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
