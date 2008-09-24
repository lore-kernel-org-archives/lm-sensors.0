From: "Andrew Lyon" <andrew.lyon@gmail.com>
Date: Wed, 24 Sep 2008 14:34:27 +0000
Subject: [lm-sensors] w83793 on X7DWA-N
Message-Id: <f4527be0809240734s43f495f6m7c105854e5d32eb0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have lm_sensors 3.0.2 on a supermicro X7DWA-N with kernel 2.6.25.15,
I am trying to work out how the lm_sensors voltage readings map to the
sensors shown in the bios and described in the motherboard manual, the
manual states:

Onboard Voltage Monitors for the CPU Cores, Chipset Voltage, Memory
Voltage, +1.8V, +3.3V, +5V, +12V, -12V, +3.3V Standby, +5V Standby and
Vbat

sensors output:

VCoreA:      +1.20 V  (min =  +0.92 V, max =  +1.49 V)   = CPU Cores
VCoreB:      +1.20 V  (min =  +0.92 V, max =  +1.49 V)   = CPU Cores
Vtt:         +1.08 V  (min =  +0.99 V, max =  +1.33 V)   = ?
in3:         +0.51 V  (min =  +0.38 V, max =  +0.69 V)   = ?
in4:         +1.46 V  (min =  +1.34 V, max =  +1.65 V)   = ?
+3.3V:       +3.28 V  (min =  +2.96 V, max =  +3.63 V)   +3.3V?
+12V:       +11.81 V  (min = +10.75 V, max = +13.25 V)   +12
+5V:         +5.02 V  (min =  +4.64 V, max =  +5.65 V)   +5
5VSB:        +5.05 V  (min =  +4.64 V, max =  +5.65 V)   +5V Standby
VBAT:        +3.18 V  (min =  +2.99 V, max =  +3.66 V)   Vbat

Can anybody explain the differences?

Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
