From: Mathias Gerber <mathias_g@tuxedo.ath.cx>
Date: Sun, 09 Feb 2014 16:41:29 +0000
Subject: [lm-sensors] Configuration ASUS H87-PRO for Wiki
Message-Id: <52F7AFB9.8040109@tuxedo.ath.cx>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello

Would you like to add this configuration to the lm-sensors wiki?
- -- 
greetings
 mathias


# Configuration file for ASUS H87-PRO
# 2014-01-21/mg

chip "nct6791-*"

label in0 "VCCin" # CPU Input Voltage
  compute in0  @*2    , @/2

label in1 "+5V" # 5V
  compute in1 @ * (40/8), @ / (40/8)
  set in1_min 5 * 0.95
  set in1_max 5 * 1.05

label in2 "AVCC?" # AVCC?
  set in2_min 3.3 * 0.95
  set in2_max 3.3 * 1.05

label in3 "+3.3V?" # 3.3V?
  set in3_min 3.3 * 0.95
  set in3_max 3.3 * 1.05

label in4 "+12V" # 12V
  compute  in4  @ * (96/8), @ / (96/8)
  set in4_min 12 * 0.95
  set in4_max 12 * 1.05

ignore in5 # always 0.17V here
ignore in6 # always 0.82V here

label in7 "3VSB?" # 3VSB?
  set in7_min 3.3 * 0.95
  set in7_max 3.3 * 1.05

label in8 "VBAT?" # VBAT?
  set in8_min 3
  set in8_max 3 * 1.2

ignore in9
ignore in10
ignore in11
ignore in12
ignore in13
ignore in14

label fan1 "CHA_FAN1"
  ignore fan1	# not in use in _my_ configuration
  set fan1_min 300

label fan2 "CPU fan"
  set fan2_min 300

label fan3 "CHA_FAN2"
  ignore fan3	# not in use in _my_ configuration
  set fan3_min 300

label fan4 "CHA_FAN3"
  set fan4_min 300

ignore fan5	# does not exist on this MB

#label CPUTIN "CPU temperature"

ignore temp1		# SYSTIN
ignore temp3		# AUXTIN, gets smaller under load
ignore temp4		# AUXTIN1
ignore temp5		# AUXTIN2
ignore temp6		# AUXTIN3
ignore intrusion0
ignore intrusion1
ignore beep_enable
ignore temp7		# PECI Agent 0 => value is the same as coretemp, phys ID0
ignore temp8		# PCH_CHIP_CPU_MAX_TEMP
ignore temp9		# PCH_CHIP_TEMP
ignore temp10		# PCH_CPU_TEMP
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlL3r7kACgkQnfTEjDUZ2fOs2QCfbX/xF/Zsc9hMhKsd4nxySDwL
vrkAoK8BuaXUuUVN+kFihc19SoO1UTDA
=QHRo
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
