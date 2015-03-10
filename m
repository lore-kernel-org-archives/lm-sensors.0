From: Nybbles2Bytes <nybbles2bytes@gmail.com>
Date: Tue, 10 Mar 2015 07:12:13 +0000
Subject: [lm-sensors] ASUS X99-E WS / AMD HD 5870
Message-Id: <1425971533.19075.15.camel@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Thanks in advance for any help!

The following is the basics of my hardware. It's a very new machine.

My hardware is:
* Motherboard: ASUS X99-E WS
* CPU: Intel Core i7-5960X
* Graphics card: AMD HD 5870
* Water cooling for the processor

There's a widget that just called temperature that goes on a KDE4
desktop panel and it shows the following sensors:


acpi/Thermal_Zone/0/Temperature               100 F
lmsensors/coretemp-isa-0000/Physical_id_0     100 F
lmsensors/radeon-pci-0600/temp1               140 F
lmsensors/coretemp-isa-0000/Core_0             70 F
lmsensors/coretemp-isa-0000/Core_1             70 F
lmsensors/coretemp-isa-0000/Core_2             70 F
lmsensors/coretemp-isa-0000/Core_3             70 F
lmsensors/coretemp-isa-0000/Core_4             70 F
lmsensors/coretemp-isa-0000/Core_5             70 F
lmsensors/coretemp-isa-0000/Core_6             70 F
lmsensors/coretemp-isa-0000/Core_7             70 F

The cores 0 to 7 are obviously the cores of my processor and the
"radeon-pci-0600" is my graphics card. Now however it gets uncertain.

Looking around on the on the lm sensor site I saw a list of motherboards
and mine wasn't in the list. 

* Does this mean I can't trust the sensors I don't know because lm
sensors probably doesn't understand them anyway?

* If lm sensors doesn't know my MB how do I get that information into lm
sensors?

* How do I know physically "where a sensor is"/"what it's for" that
isn't obvious like the core sensors are?

I'm very new to this so if these seem like dumb questions, they probably
are.

Reg



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
