From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 09 Jun 2013 19:04:26 +0000
Subject: Re: [lm-sensors] lsensors3.conf for ASRock K7VT2
Message-Id: <20130609210426.17d8c063@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201306071429.42740.marcus@localhost>
In-Reply-To: <201306071429.42740.marcus@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marcus,

On Fri, 7 Jun 2013 14:29:38 +0200, Marcus Roeckrath wrote:
> here is my sensors3.conf for ASRock K7VT2 Board, please add this to the 
> Motherboard Specific Configuration:
> 
> # Sample configuration for ASRock K7VT2
> 
> chip "w83697hf-*"
> set beep_enable 0

Why? We normally don't touch beep_enable in the configuration files we
put in the wiki.

> label in0 "VCore"
> label in2 "+3.3V"
> label in3 "+5V"
> label in4 "+12V"
> label in5 "-12V"
> label in6 "-5V"
> label in7 "V5SB"
> label in8 "VBat"
> compute in3 ((6.8/10)+1)*@ , @/((6.8/10)+1)
> compute in4 ((28/10)+1)*@ , @/((28/10)+1)
> #compute in5 (5.14 * @) - 14.91 , (@ + 14.91) / 5.14
> #compute in5 (3.14 * @) - 7.71 , (@ + 7.71) / 3.14
> compute in5 -((28/10)+1)*@ , -@/((28/10)+1)

If you are sure the last in5 formula is right, you should remove the
other two.

> compute in6 -((6.8/10)+1)*@ , -@/((6.8/10)+1)
> compute in7 ((6.8/10)+1)*@ , @/((6.8/10)+1)

How did you find / validate the compute formulas ?

> set in0_min 1.5 * 0.95
> set in0_max 1.65 * 1.05
> set in2_min 3.3 * 0.9
> set in2_max 3.3 * 1.1
> set in3_min 5 * 0.95
> set in3_max 5 * 1.05
> set in4_min 12 * 0.9
> set in4_max 12 * 1.1

The ATX specification says the positive voltage inputs should be within
a +/- 5% margin, not 10% as you used for +3.3V and +12V

> set in5_min -12 * 0.9
> set in5_max -12 * 1.1
> set in6_min -5 * 0.9
> set in6_max -5 * 1.1
> set in7_min 5 * 0.9
> set in7_max 5 * 1.1
> set in8_min 3.0 * 0.8
> set in8_max 3.0 * 1.2
> label temp1 "System Temp"
> label temp2 "CPU Temp"
> set temp1_max 50
> set temp1_max_hyst 45
> set temp2_max 52
> set temp2_max_hyst 47
> label fan1 "CPU Fan"
> ignore fan2

Does the board have a System Fan header? If it does then we don't want
this ignore statement in the configuration file that will go on the
wiki, we want a label statement instead.

> set fan1_div 4
> set fan1_min 2000

Preliminary configuration file at:
http://www.lm-sensors.org/wiki/Configurations/ASRock/K7VT2

Thanks for your contribution,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
