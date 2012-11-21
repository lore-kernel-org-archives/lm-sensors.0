From: =?ISO-8859-1?Q?Lars_P=F6tter?= <lars@ing-poetter.de>
Date: Wed, 21 Nov 2012 20:09:59 +0000
Subject: Re: [lm-sensors] Configuration File for ASRock B75 Pro3
Message-Id: <50AD3517.5010900@ing-poetter.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <509C1EBF.3000309@ing-poetter.de>
In-Reply-To: <509C1EBF.3000309@ing-poetter.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

Am 12.11.2012 10:28, schrieb Jean Delvare:
> Hi Lars,
>=20
> On Sat, 10 Nov 2012 14:57:50 +0100, Lars P=F6tter wrote:
>>> Run sensors -u, and you'll see the underlying attribute names. SYSTIN is
>>> probably temp1, CPUTIN is temp2, and AUXTIN is temp3. They are not spec=
ial,
>>> but the driver provides a symbolic name, which is displayed by the sens=
ors
>>> command. You have to use the raw name, not the symbolic name, in sensor=
s.conf.
>>>
>>> Hope this helps,
>>
>> Yes that helped. Thank you very much. It now works !
>>
>> So here is the working configuration file for the ASRock B75 Pro 3 Main
>> Board:
>=20
> I was about to add this to the wiki but there are a few things which worr=
y me:
>=20
>> chip "nct6776-isa-0290"
>>     label in1 "+1.9V"
>>     ignore in4
>>     label in5 "+1.66V"
>=20
> +1.9V and +1.66V make little sense to me. These voltage values aren't
> part of the ATX specification. They most certainly correspond to +12V
> and +5V (the ASROck BIOS displays these) and need proper scaling
> factors. Please read:
>   http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling
> then you should be able to figure out who is who and which scaling
> factors should be applied.

The Bios has:
VCore        +1,048V
+12V        +12,513V
+5V          +4,992V
+3,3V        +3,424V

and sensors -u has:
coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:
  temp1_input: 37.000
  temp1_max: 85.000
  temp1_crit: 105.000
  temp1_crit_alarm: 0.000
Core 0:
  temp2_input: 26.000
  temp2_max: 85.000
  temp2_crit: 105.000
  temp2_crit_alarm: 0.000
Core 1:
  temp3_input: 26.000
  temp3_max: 85.000
  temp3_crit: 105.000
  temp3_crit_alarm: 0.000
Core 2:
  temp4_input: 37.000
  temp4_max: 85.000
  temp4_crit: 105.000
  temp4_crit_alarm: 0.000
Core 3:
  temp5_input: 25.000
  temp5_max: 85.000
  temp5_crit: 105.000
  temp5_crit_alarm: 0.000

nct6776-isa-0290
Adapter: ISA adapter
Vcore:
  in0_input: 0.952
  in0_min: 0.000
  in0_max: 1.744
  in0_alarm: 0.000
+1.9V:
  in1_input: 1.896
  in1_min: 1.712
  in1_max: 2.040
  in1_alarm: 0.000
AVCC:
  in2_input: 3.424
  in2_min: 2.976
  in2_max: 3.632
  in2_alarm: 0.000
+3.3V:
  in3_input: 3.424
  in3_min: 2.976
  in3_max: 3.632
  in3_alarm: 0.000
+1.66V:
  in5_input: 1.656
  in5_min: 1.496
  in5_max: 1.824
  in5_alarm: 0.000
3VSB:
  in7_input: 3.440
  in7_min: 2.976
  in7_max: 3.632
  in7_alarm: 0.000
Vbat:
  in8_input: 3.248
  in8_min: 2.704
  in8_max: 3.296
  in8_alarm: 0.000
CPU Fan:
  fan2_input: 1595.000
  fan2_min: 810.000
  fan2_alarm: 0.000
SYSTIN:
  temp1_input: 28.000
  temp1_max: 50.000
  temp1_max_hyst: 30.000
  temp1_alarm: 0.000
  temp1_type: 4.000
CPUTIN:
  temp2_input: 28.000
  temp2_max: 80.000
  temp2_max_hyst: 75.000
  temp2_alarm: 0.000
  temp2_type: 4.000
AUXTIN:
  temp3_input: 58.500
  temp3_max: 125.000
  temp3_max_hyst: 125.000
  temp3_alarm: 0.000
  temp3_type: 4.000
PECI Agent 0:
  temp5_input: 36.000
cpu0_vid:
  cpu0_vid: 2.050
intrusion0:
  intrusion0_alarm: 1.000
intrusion1:
  intrusion1_alarm: 1.000

I hope that makes sense to you.

>>     ignore fan1
>>     label fan2 "CPU Fan"
>>     ignore fan3
>>     ignore fan4
>>     ignore fan5
>=20
> You have only one fan in your machine but the board had 5 headers. The
> BIOS can display 5 fan speed values, so we don't want these ignore
> statements in the configuration file that will go to the wiki. Best
> would be to provide the right label for each fan, with some luck they
> are in the same order as in the BIOS, but you if you have a spare fan
> to confirm that, it would be great.

I don't have a spare fan to confirm, but these are the Names in the Bios
used for the Fan Connectors:
- CPU-FAN1 (The ios shows my fan there so this must be fan2 althoug it
is listed first in the Bios)
- CPU-FAN2
- Chassis FAN 1
- Chassis FAN 2
- Power FAN

>>     set in1_min  1.9 * 0.90
>>     set in1_max  1.9 * 1.10
>>     set in5_min  1.66 * 0.90
>>     set in5_max  1.66 * 1.10
>=20
> These will need to be adjusted once proper scaling factors are in place.
>=20
>>     set fan2_min  900 * 0.90
>=20
> That's rather uncommon. We use this for voltage limits because there is
> a nominal target and a standard maximum deviance (which is +/- 5% for
> core ATX voltages BTW, not 10%.) For fans there is no nominal speed,
> just a minimum speed so you can express it directly.
>=20
>>     set temp1_max  50
>>     set temp1_max_hyst 30
>>
>> So this could be added to the Wiki (I do not have write rights) perhaps
>=20
> I will do once we have come up with a really good configuration file.

I understand that it is important for an open source Project to care for
high quality, but from the user perspective I would prefer to have a
"beta" or "alpha" marked config file to not having a config file. This
also gives the user that finds the "beta" version to improve it,..

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
