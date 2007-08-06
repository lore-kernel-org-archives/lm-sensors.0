From: Dawn Light <dawnlight@lavabit.com>
Date: Mon, 06 Aug 2007 07:13:00 +0000
Subject: [lm-sensors] sensors.conf for Abit VA-20 motherboard
Message-Id: <200708060713.00943.dawnlight@lavabit.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_8nstGEz4X/LaBp5"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--Boundary-00=_8nstGEz4X/LaBp5
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: base64
Content-Disposition: inline

S2VlcCB1cCB0aGUgZ29vZCB3b3JrIQotLSAKRGF3biBMaWdodArXqdeX16gg15DXldeoCTA1MC03
OTY2NjY0Cg==

--Boundary-00=_8nstGEz4X/LaBp5
Content-Type: text/plain;
  charset="utf-8";
  name="sensors.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sensors.conf"

#### Abit VA-20 contributed by DawnLight ####

chip "it87-*" "it8712-*"

    label in0 "CPU VCore"
    label in1 "+2.5V"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    ignore in5
    ignore in6
    ignore in7
    label in8 "VBat"

    ignore  vid

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((30/10) +1)*@  , @/((30/10) +1)
    
    set in0_min 1.55 * 0.95
    set in0_max 1.55 * 1.05
    set in1_min 2.4
    set in1_max 2.6
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12.5 * 0.95
    set in4_max 12.5 * 1.05

    label temp1       "M/B Temp"
    set   temp1_over  44
    set   temp1_low   15
    label temp2       "CPU Temp"
    set   temp2_over  45
    set   temp2_low   15
   ignore temp3

    set fan1_min 3000
    ignore fan2
    ignore fan3

--Boundary-00=_8nstGEz4X/LaBp5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_8nstGEz4X/LaBp5--

