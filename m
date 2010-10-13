From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Oct 2010 13:57:41 +0000
Subject: Re: [lm-sensors] Detection of W83L771AWG/ASG in lm90
Message-Id: <20101013155741.36f8d1e0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201010131540.19225.alexander.stein@informatik.tu-chemnitz.de>
In-Reply-To: <201010131540.19225.alexander.stein@informatik.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Alexander,

On Wed, 13 Oct 2010 15:40:18 +0200, Alexander Stein wrote:
> 'sensors-detect' shows me there is W83L771W/G on my board:
> > Probing for `Winbond W83L771W/G'...                         Success!
> >     (confidence 6, driver `to-be-written')
> According to this wiki page http://www.lm-sensors.org/wiki/Devices support 
> should be handles by the lm90 driver. But after loading the lm90 driver, 
> 'sensors' doesn't show any new device. Also loading the driver by the alias 
> "i2c:w83l771" doesn't help. Oh, i nearly forgot, I'm running 2.6.34-gentoo-
> r11.
> Any comments/suggestions?

Which I2C adapter is your W83L771W/G sitting on? The sensors-detect
script will probe any adapter, however the lm90 driver can only
auto-detect devices on I2C adapters which have properly set their class
to I2C_CLASS_HWMON.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
