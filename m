From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: [PATCH 2.4] i2c cleanups, third wave
Message-Id: <20040114033343.GK894@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040111144214.7a6a4e59.khali@linux-fr.org>
In-Reply-To: <20040111144214.7a6a4e59.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mike Fedyk <mfedyk@matchmail.com> [2004-01-11 17:48:40 -0800]:
> On Sun, Jan 11, 2004 at 02:42:14PM +0100, Jean Delvare wrote:
> > I will be sending 8 patches to you, based on linux-2.4.25-pre4. They
> > contain cleanups for the i2c subsystem code, ported from LM Sensors' i2c
> > CVS repository [1]. Since that repository was also the base of the i2c
> > subsystem as is now in linux 2.6, one might also consider these patches
> > as backports from linux 2.6.
> 
> How about some patches to add some more sensors to the 2.4 kernel, like the
> ones already in 2.6?

No chance these will go into mainline 2.4.  But if you still want them, start
with Jean's I2C patches, which he intends to slowly feed to Marcelo:

http://www.ensicaen.ismra.fr/~delvare/devel/i2c/

Then try the mkpatch.pl script from the lm_sensors project:

http://secure.netroedge.com/~lm78/

Regards,

-- 
Mark "you probably already knew that" Hoffman
mhoffman@lightlink.com
