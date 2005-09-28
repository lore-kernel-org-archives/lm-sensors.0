From: kjeld.flarup@liberalismen.dk (Kjeld Flarup)
Date: Wed, 28 Sep 2005 22:46:00 +0000
Subject: [lm-sensors] Fan control with Winbond W83627EHF
Message-Id: <433B00C3.90205@liberalismen.dk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

I have an ASUS A8V-E SE Motherboard with a Winbond W83627EHF chip. Im 
running kernel 2.13
I got lm_sensors detect the fan speed now, but the pwmconfig script fails.
As far as I can see it is because there are no fan1_pwm devices created 
by the driver.

I only got these devices with these current values:
fan1_div:8
fan1_input:1360
fan1_min:1205
fan2_div:8
fan2_input:1834
fan2_min:1704
fan3_div:4
fan3_input:1360
fan3_min:0

_div & _input is readonly, while I can write to _min. But writing to _min does not seem to have any efect.

Is it possible to control the fan with the above or does the drivers miss something?

If the drivers are missing something, then I'm willing to code whats needed if I can get some hints.

-- 
-------------------- Med Liberalistiske Hilsner ----------------------
  Civilingeni?r, Kjeld Flarup - Mit sind er mere ?bent end min tegnebog
  Forssavej 49, 7600 Struer, Tlf: 40 29 41 49
  Den ikke akademiske hjemmeside for liberalismen - www.liberalismen.dk


