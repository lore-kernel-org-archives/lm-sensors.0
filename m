From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: Bogus readings on GA 7N400 and ECS N2U400-A
Message-Id: <Pine.LNX.4.58.0408201408180.1784@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040819115718.28d02717@shodan.citadel>
In-Reply-To: <20040819115718.28d02717@shodan.citadel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Hello again,

This is the ECS N2U400-A case (as in bios PCCHIPSN2U400-A)
N2U400-A Ver 1.0b 10/06/2003. FOR SALE

VAL is raw register value

label in0 "VCore 1" *0x10 ? (default case)
label in1 "VCore 2" *0x10 ? (default case)
label in2 "+3.3V" *0x10 ? (default case)
label in3 "+5V" => (0xA80*VAL)/0x64
label in4 "+12V" => VAL*0x40
label in5 "-12V" => 0x4249 - ((VAL*0x2024)/0x64)
label in6 "-5V" => 0x2249 - ((VAL*0x13A4)/0x64)
label in7 "Stdby" => (0xA80*VAL)/0x64
label in8 "VBat" => VAL*0x10

(Result/10)+1000 before decimal dot
result/1000 after (i'm in hurry so not sure)

If temp has seventh bit set then (XOR TEMP,0xFF)+1 is made
and it prints (-) before temp value and degC.

Please provide output of

 isadump 0x295 0x296

to the list. I hope Jean Delvare will help you with the real formulas.
I'm leaving to Belgium and I dont know if I will be online.

Lines in0 - in8 are monitored in the bios(confiremed in code)

CPU Core Voltage           :
Voltage 1                  :
Voltage 2                  :
Voltage 3                  :
Voltage 4                  :
Voltage 5                  :
Voltage 6                  :
Voltage 7                  :
Voltage Battery            :
Temperature 1              :
CPU    Temperature         :
CPUFAN1    Speed           :
CASFAN1    Speed           :
PWRFAN1    Speed           :

Dot forget to CC to the list.

I hope this helps

regards

Rudolf
