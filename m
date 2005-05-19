From: adress@idsystems-ag.de (Albrecht =?ISO-8859-1?Q?Dre=DF?=)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: Solution found for ticket #757
Message-Id: <20011219.14022400@idspc32.idsystems-ag.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

thanks for your quick support! With that information and additional info 
from Andreas Willenbrink <Andreas.Willenbrink@web.de>, I now have a 
working config as follows:


- in /etc/modules.conf:

alias char-major-89 i2c-isa
pre-install i2c-isa modprobe it87
options it87 temp_type=0x38


- in /etc/sensors.conf (comments stripped)

chip "it87-*"

  label in0 "VCore"
  label in1 "+2.5V"
  label in2 "+3.3V"
  label in3 "+5V"
  label in4 "+12V"
  label in5 "-12V"
  label in6 "-5V"
  label in7 "Stdby"
  label in8 "Vbat"
  label fan1 "CPU"
  label fan2 "case"

  set in0_min 1.75 * 0.95
  set in0_max 1.75 * 1.05
  set in1_min 2.4
  set in1_max 2.6
  set in2_min 3.3 * 0.95
  set in2_max 3.3 * 1.05
  set in3_min 5.0 * 0.95
  set in3_max 5.0 * 1.05
  set in4_min 12 * 0.95
  set in4_max 12 * 1.05
  set in5_min -12 * 0.95
  set in5_max -12 * 1.05
  set in6_min -5 * 0.93
  set in6_max -5 * 1.07
  set in7_min 5 * 0.95
  set in7_max 5 * 1.05

  ignore vid

  compute in2 (1)*@ , @/(1)
  compute in3 ((6.8/10)+1)*@ , @/((6.8/10)+1)
  compute in4 ((30/10) +1)*@ , @/((30/10) +1)
  compute in5 -(36/10)*@, -@/(36/10)
  compute in6 -(56/10)*@, -@/(56/10)
  compute in7 ((6.8/10)+1)*@ , @/((6.8/10)+1)

  ignore temp1

  label temp2 "Temp2/MB"
  set temp2_over 45
  set temp2_hyst 35

  label temp3 "Temp3/CPU"
  set temp3_over 75
  set temp3_hyst 60

  set fan1_div 4
  set fan1_min 3000
  set fan2_div 4
  set fan2_min 0
  ignore fan3


Thanks again,

    Albrecht   :-))



>>>>>>>>>>>>>>>>>> Urspr?ngliche Nachricht <<<<<<<<<<<<<<<<<<

Am 19.12.01, 02:58:01, schrieb Nobody <nobody@Stimpy.netroedge.com> zum 
Thema ---== Lm_sensors Support DB Entry ==---:


> Your Lm_sensors support entry has been updated.

> Please go to http://www.netroedge.com/~lm78/support.html to check
> the status of your entry.

> Ticket # 757
