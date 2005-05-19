From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: Matrox G400DH + lm_sensors problem
Message-Id: <3EF4898A.6030208@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030620001151.GA5184@alf.amelek.gda.pl>
In-Reply-To: <20030620001151.GA5184@alf.amelek.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If you have all the chip drivers compiled in,
each one will scan each i2c bus as it is registered.
We do not recommend compiling-in all the chip drivers, keep them as modules.

It may be that the matrox driver timeout values are too long
which is exacerbating the problem, you may wish to discuss
with the matrox maintainer.

Things should work fine with unconnected busses like DDC.
But lots of compiled-in chip drivers and a long bus driver timeout
makes for a long wait :)

Marek Michalkiewicz wrote:
> Hi,
> 
> there is some kind of bad interaction between i2c-matroxfb in
> the kernel (2.4.21) patched with lm_sensors 2.6.5.  I have
> everything compiled into the kernel (no modules), and when the
> Matrox I2C devices are registered at boot time, the machine
> hangs for over 3 minutes.  Also, scanning the Matrox I2C buses
> (not the motherboard SMBus) with i2cdetect is very slow too.
> 
> There is no such hang on boot in the vanilla 2.4.21 kernel
> (with no lm_sensors patch applied).  In both cases, the kernel
> I2C code is used, and Matrox devices are detected correctly,
> it's just that it is sooo much faster without the lm_sensors
> drivers compiled into the kernel.
> 
> Hardware: Biostar M6TBA motherboard (W83781D sensor chip),
> Matrox G400DH 32MB graphics card.  (BTW, the supplied TV-out
> cable has the DDC pins SDA and SCL shorted.  Does the kernel
> I2C code deal correctly such unusable I2C buses?)
> 
> Is this a known problem?  If there is anything I should check
> (I'm not brave enough to try the 2.5.x kernels with the latest
> lm_sensors just yet...), please tell me.  Thanks!
> 
> Marek
> 
