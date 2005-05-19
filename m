From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: W83L785 for 2.6 is written
Message-Id: <Pine.LNX.4.58.0409032110560.19686@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

Finally I finished my driver for 2.6.x kernels

It supports:
fan2_min      in1_min    in3_min    temp1_max       temp2_type
fan1_div      in0_input  in2_input  temp1_type
fan1_input    in0_max    in2_max    temp2_crit
fan1_min      in0_min    in2_min    temp1_crit      temp2_hyst_min
fan2_div      in1_input  in3_input  temp1_hyst_min  temp2_input
fan2_input    in1_max    in3_max    temp1_input     temp2_max

Except the PWM.

Colin,

if you use 2.6 kernel would you be so kind and test it ?

You can download it from here http://ssh.cz/~ruik/w83l785_devel.tar.gz
Plz see instructions in README

For rest people: The driver is not yet ready for inclusion, it needs
first some testing and then kernel coding style. Anyone else with w83l785
? :)

Regards

Rudolf
