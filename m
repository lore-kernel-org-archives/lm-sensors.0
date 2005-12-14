From: fredantispam@free.fr (fred)
Date: Wed, 14 Dec 2005 18:59:01 +0000
Subject: [lm-sensors] set min/max volt for it8712...
Message-Id: <43A06B75.90608@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I want to set min/max voltage for Vcore 1 (in0) and +3.3V (in1).

From /etc/sensors.conf :

chip "it8712-*"

    label in0 "VCore 1"
    set in0_min 1.4 * 0.95
    set in0_max 1.4 * 1.05
    label in1 "+3.3V"
    set in1_min 3.3 * 0.95
    set in1_max 3.3 * 1.05

sensors displays :
it8712-isa-0290
Adapter: ISA adapter
VCore 1:   +1.42 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
+3.3V:     +3.30 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
                                ^^^^^^^^^^^^^^   ^^^^^^^^^^^^^^^
+5V:       +4.95 V  (min =  +4.76 V, max =  +5.24 V)
+12V:     +12.16 V  (min = +11.39 V, max = +12.61 V)
Stdby:     +3.04 V  (min =  +2.85 V, max =  +3.15 V)

What's wrong ?

Thanks in advance.

-- 
Fred.

