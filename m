From: gws@mtco.com (Gary W. Sandvik)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: lm_sensors and Soyo K7V Motherboard
Message-Id: <200210191842.23680.gws@mtco.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

After a lot of time and effort I was finally able to get the sensors.conf 
set-up for my Dragon+. The values for the Rin/Rf for the -12 and -5 voltages 
are not correct in the sample sensors.conf. 

After contacting SOYO, a representative contacted me directly.I questioned the 
values and she checked on the schematic and found the values for the -12V to 
be 232K/56K and for -5V 120K/56K..

I stated that I would be sharing this with the lm_sensors group.

One other problem exists with lm_sensors and the SOYO MB. The Temp/CPU and 
Temp/MB are transposed. Of course  I can change the labels but the values are 
still transposed. Any reports to other programs will not be correct. I'm 
using ksensors-0.7 and the values indeed are reported transpoed. THe MB temp 
is higher than the CPU temperature. When I know that is not the case.

I'm using lm_sensors-2.6.5 and i2c-2.6.5. Everything installed, no errors 
noted.

-- 
Regards and God speed,
Gary

The Magic is in the Magician not the wand!
