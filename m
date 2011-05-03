From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 03 May 2011 11:58:26 +0000
Subject: Re: [lm-sensors] Monitor temperature for Nvidia graphics card?
Message-Id: <20110503135826.51f8dd46@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 21 Apr 2011 17:28:58 +0200, Fred . wrote:
> Hello
> I have GeForce 8600 GT.
> I have lm_sensors 3.2.0, kernel 2.6.38, nvidia driver 270.41.06.
> 
> Isn't monitoring of GPU temperature on Nvidia graphics card supported?

Assuming you're speaking of the binary driver provided by Nvidia, then
yes it is "supported", but not by lm-sensors. You have to use the
nvidia-settings tool provided by Nvidia with their driver.

> I ran 'sudo sensors-detect', but it doesn't seem like it found module
> for GeForce?

All that sensors-detect can do is probe the I2C buses of the graphics
adapter for known monitoring chips, but 1* nvidia disabled probing on
the I2C buses, I don't know if this is by malice or stupidity and 2*
not all sensors are in I2C chips anyway (at least not on Radeon cards -
I guess the same applies to Nvidia.) So in practice it doesn't work.
Hopefully the advent of nouveau will help a lot in this area, even
though there are still a few rough edges at the moment.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
