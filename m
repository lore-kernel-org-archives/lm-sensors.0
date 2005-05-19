From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: lm90 driver
Message-Id: <20030907163003.492956bb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030906000353.40951246.khali@linux-fr.org>
In-Reply-To: <20030906000353.40951246.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Yes, testers are still wanted. In order to test the driver, you'll
> > have to install the CVS version of both I2C and LM Sensors. If you
> > don't use other I2C-related devices (frame grabbers and TV tuners
> > are, among others), simply follow the instructions here:
> > http://secure.netroedge.com/~lm78/download.html#cvs
> > It's as easy as "make && make install" for i2c and "make && make
> > install&& ldconfig" for LM Sensors. Then, run "sensors-detect" and
> > it should detect your LM90.
> > 
> > If you do use other I2C-related devices, follow the more detailed
> > installation guide here:
> > http://www.ensicaen.ismra.fr/~delvare/devel/i2c/
> > 
> > (If you don't know, try method 1 first, since it's easiest; if you
> > encounter problems, move to method 2.)
> > 
> > Let us know how the driver works for you!
> 
> Thank you for the detailed instructions.  I am a Mandrake user, and it
> looks like lm_sensors2.8 is in Cooker, so it is most likely that the
> new Mandrake kernel is already patched to the new I2C.  If I can get
> Cooker running (it should become 9.2 in a few weeks as Cooker is
> tagged rc1 right now) on my KT400 machine, I am thinking I'll just try
> installing lm_sensors from cvs and see how it goes.

It's great that 2.8.0 is already in Cooker :) However, I'm not sure
it'll be sufficent for an out-of-the-box installation of lm_sensors CVS.
We have a new function (i2c_delay) in i2c CVS, which is used by some
(most) bus drivers in lm_sensors CVS, so I guess you'll have some
problems here. I'd recommend that you install i2c CVS prior to
lm_sensors CVS. If Cooker's kernel is already patched, i2c CVS should
install like a charm and will not cause any problem to other, and
lm_sensors CVS will then work OK too.

> I'll let you know how it goes.

Yes, please do :)
Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
