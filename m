From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 06 Jul 2005 21:36:47 +0000
Subject: [lm-sensors] Re: asus P5GD2 Premium
Message-Id: <20050706213058.24f9bb1b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42C6BFB0.7090900@sh.cvut.cz>
In-Reply-To: <42C6BFB0.7090900@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

> I have managed to look at the board.  The link you
> forwarded is for a Pro version of the board, I have a
> Premium.  I'm sure the boards are fairly similar.  The
> only differences I could not were that I have
> aiProactive black anodized heat sinke instead of a red
> heat sink and one chip is populated that isn't in the
> picture.  It is a Silicon Image SATA Link so probably
> just the sata controller.  The only Winbond I found is
> a: W83627EHF - A.  It is located in a corner of the
> board, next to the RAM slots.

That's the hardware monitoring chip you are looking for. A preliminary
driver (written by me) exists since Linux 2.6.13-rc1 (w83627ehf).
Someone (not me) is working on extending it, but it's not ready yet.

Could you please provide the output of the following command:
isadump -y -k 0x87,0x87 0x2e 0x2f 0x0b

> My linux skills aren't extensive but I do have some
> experience and I can follow explicite directions.  You
> may have noticed from my first email, that I
> downloaded the lmsensors 2.9.1 gz, unpacked it and
> tried "make user; etc..." and I also included the
> output.  

Well, at this point the easiest is to wait for SuSE to package a kernel
which has the driver you need, but it will definitely take some (much)
time. The driver could possibly be backported if you are motivated.
You'll need the source tree and the configuration file matching your
running kernel, and the driver file itself will need some tweaking
because of the various changes we made to the i2c subsystem between
2.6.8 and 2.6.12. If you are into that, we'll assist you.

> Also, in regards to removing SuSE versions of
> lm-sensor, I looked for an rpm of lm-sensors on Yast
> but did not find one.  All I found is the sensors
> package, sensors-2.8.7-2.i586.rpm.  Would you suggest
> I uninstall that?  If not, how would I go about
> uninstalling all the lm-sensors suse packages
> otherwise?

I would uninstall any package related to lm_sensors, as you will need
the CVS version anyway. You'll have to install the CVS version manually
(see http://secure.netroedge.com/~lm78/download.html#cvs).

-- 
Jean Delvare
