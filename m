From: "Artem S. Tashkinov" <t.artem@lycos.com>
Date: Tue, 28 Jun 2011 08:42:40 +0000
Subject: Re: [lm-sensors] [3.0 regression?] coretemp driver output has
Message-Id: <1389442474.614518.1309250560076.JavaMail.mail@webmail11>
List-Id: <lm-sensors.vger.kernel.org>
References: <1679233363.543867.1308943464300.JavaMail.mail@webmail20>
In-Reply-To: <1679233363.543867.1308943464300.JavaMail.mail@webmail20>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Jun 28, 2011, Guenter Roeck <guenter.roeck@ericsson.com> wrote: 

> I start wondering ... do you have any ignore entries for coretemp in /etc/sensors3.conf ?

> Or, in other words, what does the system report if you execute "sensors -u"
> instead of "sensors" ?

$ sensors -u
coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:
  temp1_input: 37.000
  temp1_max: 80.000
  temp1_crit: 99.000
  temp1_crit_alarm: 0.000
Core 0:
  temp2_input: 37.000
  temp2_max: 80.000
  temp2_crit: 99.000
  temp2_crit_alarm: 0.000
Core 3:
  temp5_input: 35.000
  temp5_max: 80.000
  temp5_crit: 99.000
  temp5_crit_alarm: 0.000

nct6776-isa-0290
Adapter: ISA adapter
Vcore:
  in0_input: 0.856
  in0_min: 0.000
  in0_max: 1.744
  in0_alarm: 0.000
in1:
  in1_input: 1.024
  in1_min: 0.000
  in1_max: 0.000
  in1_alarm: 1.000
AVCC:
  in2_input: 3.328
  in2_min: 2.976
  in2_max: 3.632
  in2_alarm: 0.000
+3.3V:
  in3_input: 3.328
  in3_min: 2.976
  in3_max: 3.632
  in3_alarm: 0.000
in4:
  in4_input: 1.008
  in4_min: 0.000
  in4_max: 0.000
  in4_alarm: 1.000
in5:
  in5_input: 2.040
  in5_min: 0.000
  in5_max: 0.000
  in5_alarm: 1.000
3VSB:
  in7_input: 3.424
  in7_min: 2.976
  in7_max: 3.632
  in7_alarm: 0.000
Vbat:
  in8_input: 3.312
  in8_min: 2.704
  in8_max: 3.296
  in8_alarm: 1.000
fan1:
  fan1_input: 0.000
  fan1_min: 0.000
  fan1_alarm: 1.000
fan2:
  fan2_input: 738.000
  fan2_min: 0.000
  fan2_alarm: 1.000
fan3:
  fan3_input: 0.000
  fan3_min: 0.000
  fan3_alarm: 1.000
fan4:
  fan4_input: 0.000
  fan4_min: 0.000
  fan4_alarm: 1.000
fan5:
  fan5_input: 0.000
  fan5_min: 0.000
  fan5_alarm: 1.000
SYSTIN:
  temp1_input: 37.000
  temp1_max: 0.000
  temp1_max_hyst: 0.000
  temp1_alarm: 1.000
  temp1_type: 4.000
CPUTIN:
  temp2_input: -60.000
  temp2_max: 80.000
  temp2_max_hyst: 75.000
  temp2_alarm: 0.000
  temp2_type: 1.000
AUXTIN:
  temp3_input: 39.000
  temp3_max: 80.000
  temp3_max_hyst: 75.000
  temp3_alarm: 0.000
  temp3_type: 4.000
PECI Agent 0:
  temp4_input: 37.000
cpu0_vid:
  cpu0_vid: 2.050

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
