From: Axel Bergerhoff <axelbergerhoff@compuserve.com>
Date: Mon, 13 May 2013 13:36:38 +0000
Subject: [lm-sensors] Config for SuperMicro H8DMi-2 and H8QGL-iF
Message-Id: <201305131536.38962.axelbergerhoff@compuserve.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_mxOkRkfvXV7MoiA"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--Boundary-00=_mxOkRkfvXV7MoiA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Just my two cents.
Axel


--Boundary-00=_mxOkRkfvXV7MoiA
Content-Type: text/plain;
  charset="us-ascii";
  name="sensors.conf.SuperMicro.H8DMi-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sensors.conf.SuperMicro.H8DMi-2"

# SuperMicro/H8DMi-2
# Sensors-detect will suggest loading the w83627hf driver which is useless on this board.

chip "w83793-*"

    label in0 "VCoreA"
    label in1 "VCoreB"
    label in2 "Vtt"
    label in5 "+3.3V"
    label in6 "+12V"
    label in7 "+5V"
    label in8 "5VSB"
    label in9 "VBAT"

    compute in6 12*@ ,  @/12

    label temp1 "CPU1 Temp"
    label temp2 "CPU2 Temp"
    label temp5 "Sys Temp"

    ignore in3
    ignore in4
    ignore fan5
    ignore fan6
    ignore temp3
    ignore temp4

--Boundary-00=_mxOkRkfvXV7MoiA
Content-Type: text/plain;
  charset="us-ascii";
  name="sensors3.conf.SuperMicro.H8QGL-iF"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sensors3.conf.SuperMicro.H8QGL-iF"

# SuperMicro/H8QGL-iF

chip "w83795g-*" "w83795adg-*"

    label in12 "+3.3V"
    label in13 "3VSB"
    label in14 "Vbat"

    set in12_min  3.3 * 0.90
    set in12_max  3.3 * 1.10
    set in13_min  3.3 * 0.90
    set in13_max  3.3 * 1.10
    set in14_min  3.0 * 0.90
    set in14_max  3.3 * 1.10

# Special settings for SuperMicro H8QGL-iF

    label in0 "Vcore CPU1"
    label in1 "Vcore CPU2"
    label in2 "Vcore CPU3"
    label in3 "Vcore CPU4"

    label in4 "Vdimm CPU1"
    label in5 "Vdimm CPU2"
    label in6 "Vdimm CPU3"
    label in7 "Vdimm CPU4"

    label in8 "+5V"
    label in9 "+12V"
    label in10 "SR56x0 1.1V"

    compute in8 @*((30/10)+1), @/((30/10)+1)  # resistor values unconfirmed.
    compute in9 @*((56/10)+1), @/((56/10)+1)  # resistor values unconfirmed.

    ignore in11     # unknown

    ignore temp1    # not connected diode
    ignore temp2    # not connected diode

    label temp3 "SR5690 Temp"
    label temp4 "SR5670 Temp"
    label temp5 "Sys Temp"  # thermistor in vicinity of CPU0, CPU1, exact location TBD

    label temp7 "CPU1 Temp"
    label temp8 "CPU2 Temp"
    label temp9 "CPU3 Temp"
    label temp10 "CPU4 Temp"

    label fan10 "SR5690 Fan"
    label fan11 "SR5670 Fan"

    ignore fan4   # not used
    ignore fan5   # not used
    ignore fan6   # not used






--Boundary-00=_mxOkRkfvXV7MoiA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_mxOkRkfvXV7MoiA--
