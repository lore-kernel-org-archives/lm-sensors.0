From: kraxel@bytesex.org (Gerd Knorr)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c address probing and AT24RF08 corruption
Message-Id: <20040419141307.GD10649@bytesex.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082123259.407fe3fb3d41c@imp.gcu.info>
In-Reply-To: <1082123259.407fe3fb3d41c@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have been testing with the following ranges in sensors-detect:
> 0x30-0x37, 0x3C-0x3F, 0x50-0x57 and 0x5C-0x5F on my two systems (which
> include EEPROMs on-board and over DDC, and other chips) and it worked
> OK. This set of ranges is only a proposal, I have no strong objection
> against a more extended range set (0x30-0x3F and 0x50-0x5F for example)
> or a shorter one (as long as at least all five addresses of the AT24RF08
> are included).
> 
> Objections, comments, anyone?

Just a side note as you are talking about address ranges and the like
here:  Please keep in mind that there is a world outside smbus which
also uses i2c and where your assumtions are not nessesarely correct even
if they are for smbus.

I've added the .class bitfield during 2.5 to help avoid probing problems.
The basic idea is to classify the busses be able to limit probing to
busses where it makes sense to do that.  The tuner.o module for example
will simply ignore any i2c adapter which hasn't the
I2C_ADAP_CLASS_TV_ANALOG bit set in .class because it doesn't make much
sense to look for a tv card tuner somewhere else.  It also doesn't make
much sense to check for sensor chips on a TV card ;)

Don't know how widely this new .class bitfield is used outsite the v4l
world, but it is a good idea to use it.  Reportly some DVB card
frontends are reacting very sensitive to the lm_sensor probes.  Right
now dvb uses a separate i2c system so it isn't a big issue right now,
but very likely the dvb will switch over to the kernel's i2c subsystem
soon.

  Gerd

-- 
http://bigendian.bytesex.org
