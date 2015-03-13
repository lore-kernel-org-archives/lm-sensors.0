From: ianp <braveheart_leo@yahoo.com>
Date: Fri, 13 Mar 2015 13:37:10 +0000
Subject: [lm-sensors] sensors configuration for Asus AM1M-A
Message-Id: <1532643187.5743803.1426253830339.JavaMail.yahoo@mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, I recently obtained an AM1-based Kabini build. I'm sharing the sensors configuration I use with this specific board.

----------

### Sensors configuration for Asus AM1M-A motherboard
### 2015-03-13, ianp <snailbox88-dev -at- yahoo -dot- com>
### Comments are welcome.


chip "it8603-*"

### Temperatures

  label  temp1 "CPU Temp"
  label  temp2 "M/B Temp"
  ignore temp3             ## not used (stuck at -128C)

  set temp1_min 5
  set temp1_max 60
  set temp2_min 5
  set temp2_max 60

### Voltages

  label  in0 "Vcore"
  ignore in1               ## not used (stuck at +2.22V)
  label  in2 "+12V"
  label  in3 "+5V"
  ignore in4               ## not used, same as in1

  ### Scale +5V and +12V.

  compute in2  @ * (12/2),  @ / (12/2)
  compute in3  @ * (25/10), @ / (25/10)

  ### Set in0 according to CPU nominal voltage.

  set in0_min   0.500
  set in0_max   1.400
  set in3_min   5 * 0.95
  set in3_max   5 * 1.05
  set in2_min  12 * 0.95
  set in2_max  12 * 1.05

### Fans

  label fan1 "CPU Fan"
  label fan2 "CHA Fan"

  set fan1_min 200
  set fan2_min 0

  ignore intrusion0         ## header is unpopulated

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
