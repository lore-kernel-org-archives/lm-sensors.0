From: miroslav.kubiczek@siemens.com (Miroslav Kubiczek)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: QDI kudoz 7x - temperature sensor problem
Message-Id: <3E6C89E0.2030408@siemens.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I have the %subj% mobo with the sensor chip ITE IT8705F. I have 
installed the lm_sensor 2.7.0 - according the documentation (using 
mandrake9.0). Installing, detectiong of chip and other stuff was fine, 
but when I started 'sensors' it printed out untrue informations from 
"Temp1/MB" and "Temp2/CPU" (Temp3 is not used).
   I also tried set up different (all) kind of sensor type by using the 
'modprobe it87 temp_type=0xXX' but with no success. The CPU temp was 
shown either +77'C of +15'C.
   When I tried the speedfan software (in windows) it showed the correct 
values. Do you happen to have an idea how to solve this? Is there also 
necessary converting formula in sensors.conf for temperature?
   I also couldn't configure the lm_sensors so that pwm was accessible 
to control my fan speed.
   Could you please send me a hint if you have an idea?

Thanks in advance and best regards,
Miro Kubiczek
