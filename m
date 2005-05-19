From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Temp Sensor on Asus A7V8X - Ticket 1358
Message-Id: <20031029053411.GC7394@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.55.0310291645560.11719@localhost>
In-Reply-To: <Pine.LNX.4.55.0310291645560.11719@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello again...

* Mark M. Hoffman <mhoffman@lightlink.com> [2003-10-28 23:36:38 -0500]:
> 
> * David Antliff <dave.antliff@paradise.net.nz> [2003-10-29 16:53:28 +1300]:
> 
> > I'm using:
> > as99127f-i2c-0-2d
> > dapter: SMBus Via Pro adapter at e800
> > Algorithm: Non-I2C SMBus adapter
> > lm_sensors-2.8.1
> > i2c-2.8.1
> 
> Does your board (A7V8X) have the ASB100 "Bach" chip?  I can't tell from
> Asus' website.  If it does, then I know what the problem is and I'm working
> on it...

So I finally committed an independent driver for asb100 to CVS.  The most
important feature of this driver for Athlon people is the addition of "temp4"
which should read the Athlon thermal diode directly (so I'm told, I don't
have one myself).

Until now, I was breaking the first half of the "release early, release
often" rule...  There are *many* TODOs in this driver - temp sensor types,
beep and alarm masks, ugh.  Much of this is just tedious reverse engineering.
A lot of people have helped in this process by posting their findings to this
list.

Libsensors support is there, but the output of sensors itself is still
ugly, sorry.

David: If you want to try this, you'll need to add a section "asb100-*" to
your /etc/sensors.conf.  Copying the existing "as99127f-*" section would be
a good start.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
