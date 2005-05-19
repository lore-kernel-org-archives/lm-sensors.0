From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: [PATCH] I2C: Support for sparc64
Message-Id: <20050103182150.GA28535@bode.aurel32.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050103002237.GA7554@bode.aurel32.lan>
In-Reply-To: <20050103002237.GA7554@bode.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jan 03, 2005 at 06:33:45PM +0100, Jean Delvare wrote:
> Is there actually any supported device on Sparc?
The person who send me that patch use i2c on sparc to get an em8300 card
working (MPEG-1 and MPEG-2 decoding card). Some chips on the card have
to be accessed via i2c, and thus the i2c modules are needed.

That also explain why he also send me the patch only for i2c and not for
lm-sensors, however I think the patch could also be applied to 
lm-sensors.

> (I happen to have a Sun Blade 100 at work and have always wondered if
> there were any hardware monitoring device inside.)
I don't think so, anyway you can add sensors by yourself, and access
them via i2c-parport :) (if your Sparc has a parallel port, some as mine
have one).


-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
