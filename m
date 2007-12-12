From: Udo van den Heuvel <udovdh@xs4all.nl>
Date: Wed, 12 Dec 2007 15:32:51 +0000
Subject: [lm-sensors] k8temp weirdness, it8716 questions
Message-Id: <475FFF23.2070800@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

I am running Fedora 8 on a Gigabyte m56s-s3 board with an AMD X2 BE-2350.
Running sensors gives me:

# sensors
k8temp-pci-00c3
Adapter: PCI adapter
temp1:        -9°C
temp2:       -20°C
temp3:       -18°C
temp4:       -14°C

it8716-isa-0290
Adapter: ISA adapter
VCore:     +0.99 V  (min =  +0.00 V, max =  +4.08 V)
VDDR:      +1.89 V  (min =  +0.00 V, max =  +4.08 V)
+3.3V:     +3.30 V  (min =  +0.00 V, max =  +4.08 V)
+5V:       +4.84 V  (min =  +0.00 V, max =  +6.85 V)
+12V:     +11.97 V  (min =  +0.00 V, max = +16.32 V)
in5:       +3.18 V  (min =  +0.00 V, max =  +4.08 V)
in6:       +0.10 V  (min =  +0.00 V, max =  +4.08 V)
5VSB:      +4.92 V  (min =  +0.00 V, max =  +6.85 V)
VBat:      +3.07 V
fan1:      805 RPM  (min =    0 RPM)
fan2:        0 RPM  (min =    0 RPM)
temp1:       +38°C  (low  =  +127°C, high =  +127°C)   sensor thermistor
temp2:       +35°C  (low  =  +127°C, high =  +127°C)   sensor thermistor
temp3:       +25°C  (low  =  +127°C, high =  +127°C)   sensor = diode
vid:      +1.000 V (yes, throttled down)

As you can see the k8temp info is slightly off-target.
Is this a known issue? How could it be corrected?

What are in5 and in6 on this board?
What are temp2 and temp3?

Thanks for your help.

Kind regards,
Udo

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
