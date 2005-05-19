From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: Bogus readings on GA 7N400 and ECS N2U400-A
Message-Id: <20040821084803.76688d25.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040819115718.28d02717@shodan.citadel>
In-Reply-To: <20040819115718.28d02717@shodan.citadel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> VAL is raw register value
> 
> label in0 "VCore 1" *0x10 ? (default case)
> label in1 "VCore 2" *0x10 ? (default case)
> label in2 "+3.3V" *0x10 ? (default case)
> label in3 "+5V" => (0xA80*VAL)/0x64
> label in4 "+12V" => VAL*0x40
> label in5 "-12V" => 0x4249 - ((VAL*0x2024)/0x64)
> label in6 "-5V" => 0x2249 - ((VAL*0x13A4)/0x64)
> label in7 "Stdby" => (0xA80*VAL)/0x64
> label in8 "VBat" => VAL*0x10

This would result in the following configuration lines:

label in0 "VCore1"
label in1 "VCore2"
label in2 "+3.3V"
label in3 "+5V"
label in4 "+12V"
label in5 "-12V"
label in6 "-5V"
label in7 "Stdby"
label in8 "VBat"

compute in3 ((6.8/10)+1)*@, @/((6.8/10)+1)
compute in4 ((30/10)+1)*@, @/((30/10)+1)
compute in5 8.228 - (@*2057/400), (8.228 - @)/(2057/400)
compute in6 8.777 - (@*1257/400), (8.777 - @)/(1257/400)
compute in7 ((6.8/10)+1)*@, @/((6.8/10)+1)

Negative voltage limits look rather suspicious to me. Ruik, can you
check again? I'd expect it the other way around, i.e. VAL*K - Vref, not
Vref - VAL*K.

Other formulas are standard so obviously correct.

> (Result/10)+1000 before decimal dot
> result/1000 after (i'm in hurry so not sure)

Doesn't make much sense to me.

> If temp has seventh bit set then (XOR TEMP,0xFF)+1 is made
> and it prints (-) before temp value and degC.

A.k.a. 2's complement, i.e. standard.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
