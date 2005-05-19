From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: QDI kudoz 7x - temperature sensor problem
Message-Id: <20030322095633.1b915baa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E6C89E0.2030408@siemens.com>
In-Reply-To: <3E6C89E0.2030408@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have the %subj% mobo with the sensor chip ITE IT8705F. I have 
> installed the lm_sensor 2.7.0 - according the documentation (using 
> mandrake9.0). Installing, detectiong of chip and other stuff was fine,
> but when I started 'sensors' it printed out untrue informations from 
> "Temp1/MB" and "Temp2/CPU" (Temp3 is not used).
> I also tried set up different (all) kind of sensor type by using the
> 'modprobe it87 temp_type=0xXX' but with no success. The CPU temp was 
> shown either +77'C of +15'C.
> When I tried the speedfan software (in windows) it showed the correct 
> values. Do you happen to have an idea how to solve this? Is there also
> necessary converting formula in sensors.conf for temperature?

Actually that's what I would suggest. You probably need to tweak the
formulas in sensors.conf. The usual way is to completely remove the
formulas (to get the "raw" readings), and then compare two points with
another software (BIOS or Windows). Generaly, you'll note the
temperature of an idle system and the temperature of a kernel-compiling
(of whatever) system. Don't forget to run "sensors -s" after changing
sensors.conf. This is a quite hard job, and it's harder even to be
accurate, but that the only way you can get the right values without
knowledge on hardware.

> I also couldn't configure the lm_sensors so that pwm was accessible
> to control my fan speed.

I don't know what you do mean with "PWM", but know that our drivers
mostly allow for reading from the sensors. I don't think you can expect
to *set* the fan speed (though you can set the *limit* it shouldn't
cross).

Hope that helps.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
