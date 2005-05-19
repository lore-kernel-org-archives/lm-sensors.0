From: kus@free.net (Mikhail Kuzminsky)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: sensors -s & adm1027
Message-Id: <web-89124@free.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <web-77741@free.net>
In-Reply-To: <web-77741@free.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In message from Jean Delvare <khali@linux-fr.org> (Fri, 13 Aug 2004 
20:04:11 +0200):
>> >> sensors-detect works normally. But sensors -s says
>> >> "adm1027-i2c-1-2d can't read or write". It looks something like
>> >> Ticket#1682 (partially).
>
>OK, I think you simply have a bogus line in /etc/sensors.conf. You're
>most likely trying to "set" a read-only feature like "vid" or any
>measured value. That was the case for ticket #1682 (which I updated).
>
>If you can't find out the faulty line, just post the adm1027 section
>here and we'll try to help.
>
>Hint: according to the strace output, I'd say that the first "set" 
>line
>of the adm1027 section is the faulty one.

Sorry, you overestimated me :-) Is the last line in this part of 
conf-file (follows) wrong ?

Yours
Mikhail

chip "adm1027-*"
     ignore fan4
     ignore pwm1
     ignore pwm2
     ignore pwm3
     ignore temp2
     ignore vid
     label in0 "VDD 2.5V"
     label in1 "DDR VTT"
     label in2 "3VSB"
     label in3 "+5 V"
     label in4 "+12V"
     label fan1 "chs1 fan"
     label fan2 "chs2 fan"
     label fan3 "chs3 fan"
     label pwm1 "pwm1 fan"
     label pwm2 "pwm2 fan"
     label pwm3 "pwm3 fan"
     label temp3 "CPU1 Temp"
     label temp1 "CPU2 Temp"
     set vid 2.4



