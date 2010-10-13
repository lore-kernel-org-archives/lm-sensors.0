From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Date: Wed, 13 Oct 2010 13:40:18 +0000
Subject: [lm-sensors] Detection of W83L771AWG/ASG in lm90
Message-Id: <201010131540.19225.alexander.stein@informatik.tu-chemnitz.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

'sensors-detect' shows me there is W83L771W/G on my board:
> Probing for `Winbond W83L771W/G'...                         Success!
>     (confidence 6, driver `to-be-written')
According to this wiki page http://www.lm-sensors.org/wiki/Devices support 
should be handles by the lm90 driver. But after loading the lm90 driver, 
'sensors' doesn't show any new device. Also loading the driver by the alias 
"i2c:w83l771" doesn't help. Oh, i nearly forgot, I'm running 2.6.34-gentoo-
r11.
Any comments/suggestions?

Regards,
Alexander

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
