From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Oct 2010 15:43:50 +0000
Subject: Re: [lm-sensors] Detection of W83L771AWG/ASG in lm90
Message-Id: <20101013174350.1eff5464@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201010131540.19225.alexander.stein@informatik.tu-chemnitz.de>
In-Reply-To: <201010131540.19225.alexander.stein@informatik.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again Alexander,

On Wed, 13 Oct 2010 17:02:17 +0200, Alexander Stein wrote:
> > Probing for `Winbond W83L771W/G'...                         Success!
> > 
> >     (confidence 6, driver `to-be-written')
> > 
> > Probing for `Winbond W83L771AWG/ASG'...                     No

Oh, I get it now. What the lm90 driver currently supports is the recent
W83L771AWG/ASG. It doesn't have detection for the old W83L771W/G. In
all honesty I wasn't sure if that one had ever been used in a public
product, and its detection is somewhat weak, which is why I didn't add
support (if I remember correctly, at least.)

First thing to do is ensure this isn't a misdetection. Please send a
dump of the chip:

# (install i2c-tools)
# modprobe i2c-dev
# i2cdump 0 0x4c b

If you really have that old chip then I'll add support to the lm90
driver. Meanwhile you can force the lm90 driver to attach to it by
using the following command:

# echo w83L771 0x4c > /sys/devices/i2c-0/new_device

(I hope the path is right for kernel 2.6.34 already.)

> (...)
> So it seems, it's the i2c-nforce2 driver for a SMBus nForce2 adapter. From a 
> short grep in i2c-nforce2.c it seems that I2C_CLASS_HWMON is passed to the 
> supported flags. Anyway, how can I name the exact device to be used by lm90?

Yes, you're right. My first guess was wrong.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
