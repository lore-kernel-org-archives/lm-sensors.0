From: grant_lkml@dodo.com.au (Grant Coady)
Date: Sun, 29 May 2005 12:07:52 +0000
Subject: [lm-sensors] Information: Winbond internal 5V scaling resistor
Message-Id: <ih1j919eh5slk7naabuh8ig3e7u72seat3@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

Not sure what to do with this info yet, so I'll get it off a scrap 
of paper and into the archives for future reference.

Winbond internally scale 5V readings in terms of resistor values.
Some chips monitor 5V, others monitor 5VSB too, I've assumed one 
chip (w83781d) does same as later chips in same family as no 
datasheet spec.

Sensor drivers do not scale these values so user-space need choose 
correct compute lines depending on chip and which 5V being measured.

Datasheet summary
-----------------
First set operate from 5V and have 16mV/lsb A/D --> 4096mV fullscale.

   chip        5V      5VSB
 W83781D     34/50      -
 W83782D     34/50      -
 W83783S     34/50      -
 W83L784R    34/50      -
 W83627HF    34/50    17/33
 W83697HF    34/50    17/33
 W83627THF   34/51    34/51
 W83637HF    34/51    34/51

Next one operates from 3.3V and has 8mV/lsb A/D --> 2048mV fullscale

   chip       3.3V    3.3VSB
 W83627EHF   34/34    34/34

This chip supplies Vref = 2.048V and the reccomended external divider 
values have changed, _not_ to same ratios as before.  The reference to 
"8-bit ADC with 16mV LSB" on block in circuit diagram appears a typo, 
as many other places refer to new 2.048V fullscale.  No mention of 5V.


example compute lines
---------------------
divider 
 34/50  compute in3 (42 / 25) * @, @ / (42 / 25)
 17/33  compute in? (50 / 33) * @, @ / (50 / 33)
 34/51 	compute in? (85 / 51) * @, @ / (85 / 51)
 34/34  compute in?         2 * @, @ / 2


If i made boo-boo, no doubt I'll be corrected :p

--Grant.

