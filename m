From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [PATCH] Driver Core patches for 2.6.9-rc1
Message-Id: <20040826112343.M51031@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10934733881970@kroah.com> <1093485846.3054.65.camel@gaston> <20040826041019.GA8445@kroah.com>
In-Reply-To: <20040826041019.GA8445@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, sensors@Stimpy.netroedge.com
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>

Hi Benjamin, hi Greg,

> > > ChangeSet 1.1873, 2004/08/25 13:21:22-07:00, khali@linux-fr.org
> > >
> > > [PATCH] I2C: keywest class
> > >
> > > This is needed for iBook2 owners to be able to use their ADM1030
> > > hardware monitoring chip. Successfully tested by one user.
> >
> > Vetoed until I get a proper explanation on what that is supposed to do,
> > I don't want random stuff mucking around the i2c busses on those machines,
> > only specifically written drivers for the chips in there.
> >
> > Please, do NOT apply.
> 
> Oops, sorry, already in :(
> 
> Anyway, sensors people, any further info on this patch?

Sure. I2C adapters have a class bitfield which is used to define which kind of
clients the bus is known to host (video, hardware monitoring, etc...). Most
client drivers do check the class before probing clients on any given bus.
[There is a plan to move the check to i2c-core so as to enforce the checking
instead of relying on the client's good will, but this hasn't been completed yet.]

The i2c-keywest driver doesn't define any class for any of its I2C busses. All
hardware monitoring chips [1] do check the class, so they wont possibly probe
any chip on the i2c-keywest busses. It happens that on the iBook2, the second
I2C bus hosts an Analog Devices ADM1030 monitoring chip, for which a driver
has been developped recently. Without adding the correct class bit
(I2C_CLASS_HWMON) to the second bus of i2c-keywest, iBook2 users can't get the
adm1031 driver to handle their ADM1030 chip.

One iBook2 user came to me, wondering why he couldn't get the adm1031 driver
to work, and we noticed the problem. I had him test a patch and it worked. I
then sent the patch to Greg, who in turn sent it to Linus, and here we are.

Benjamin, you seem to guard the i2c-keywest driver very closely. Is there
anything special about this driver? My patch was rather simple and
non-intrusive, and probably not worth reverting within the hour. Much ado
about nothing, if you want my opinion, with all due respect.

Could you please explain why my patch doesn't make sense? Similar changes were
made to several i2c bus drivers already [2] [3], and it never caused any problem.

At any rate, I may redirect i2c-keywest users to you from now on, if you
prefer to handle it yourself.

Thanks.

[1] Except lm85, but this should be fixed.
[2] http://marc.theaimsgroup.com/?l=bk-commits-head&m7943782219511&w=2
[3] http://marc.theaimsgroup.com/?l=bk-commits-head&m7943868728036&w=2
-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
