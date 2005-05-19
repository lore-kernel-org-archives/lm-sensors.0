From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Trying to drive some LEDs through I2C
Message-Id: <20041229052346.GA22023@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200412280317.iBS3HGKW026839@Stimpy.netroedge.com>
In-Reply-To: <200412280317.iBS3HGKW026839@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Max:

* Maximilian Ott <max@semandex.net> [2004-12-27 22:08:19 -0500]:
> I'm prototyping an appliance type box based on the EPIA-TC board
> (http://www.viaembedded.com/product/epia_tc_spec.jsp?motherboardId 1).
> This board supposedly has a I2C bus accessible on a connector.
> 
> I also built a small board with a few LEDs driven by a TI TPIC2810
> (8-BIT LED DRIVER WITH I2C INTERFACE) which I would like to hook up to the
> motherboard and control from a user-space process. The whole thing will run
> a 2.6 linux kernel.
> 
> Could somebody please give me a few pointers to get started.

It sounds like you already know about I2C and probably SMBus as well.

On Linux, you'll need a bus driver for your board.  Some VIA chipsets
are already supported... you could grab the freshly released 2.9.0 of
the lm_sensors2 package and build the userspace parts (kernel 2.6 already
has the most up-to-date kernel parts).  Then try 'sensors-detect'.

Assuming you have a working bus driver, the easiest way to access it
for prototyping would be the i2c /dev interface.  This requires the
module i2c-dev (if you ran 'sensors-detect' OK, you already have it).

Take a look at i2c-dev.h in the kernel headers if you want to program in
in C.  For prototyping, it would be much easier to re-use the Perl 
bindings which can be found in sensors-detect.  Or if you prefer Python,
lucky you: I just now published a module for that.  The announcement
hasn't appeared in the mail archive yet, but you will eventually see
it near the bottom of this page (which is good to browse anyway):

	http://archives.andrew.net.au/lm-sensors/

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
