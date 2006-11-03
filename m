From: christian.mahr.ulm@arcor.de (Christian Mahr)
Date: Fri, 03 Nov 2006 21:39:55 +0000
Subject: [lm-sensors] ASUS P5B DELUXE WiFi with Winbond W83627DHG - here
Message-Id: <200611032239.55182.christian.mahr.ulm@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4536788E.8010504@fibertel.com.ar>
In-Reply-To: <4536788E.8010504@fibertel.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David and others on the list,


some more internet research revealed more details on the differences between 3-pin and 4-pin fans (at least to me):

First: Intels intention with this 4-pin definition (black, yellow, green, blue wires) and the related pinning from "PC-user" perspective are shown here:
 
http://www.intel.com/support/motherboards/desktop/sb/cs-012074.htm 
      and
http://www.intel.com/cd/channel/reseller/asmo-na/eng/products/box_processors/desktop/proc_dsk_p4/technical_reference/188115.htm

So Intel made sure that 4-pin fans ("the newer ones") will work on 3 pin MBs, but 3-pin fans on a 4-pin MB connectors do work only with speed supervision, but without speed control.

Some earlier motherboards seem to have a jumper to be able to select between power control on pin 2 and pwm control on pin 4, but the ASUS P5B Deluxe/Wifi seems not to offer this choice.

Some more technical explanation I found here:

http://www.analog.com/library/analogDialogue/archives/38-02/fan_speed.html
 
including the explanation why 4-pin Fans are the technical better options on the long term.

The very technical details of the 4-pin fan interface definition are given here by Intel:

http://www.formfactors.org/developer/specs/REV1_2_Public.pdf

Intel issued the spec in July 2004 and seems to promote this solution somehow since then. Nevertheless such fans are far less widespread than the 3-pin ones. Most cooler/fan manufacturer still offer mainly 3-pin fans as part of their CPU-cooler solution.
In this specification we are told the the pwm control signal is actually not modulating the 12V power as it does with 3-pin fans. 
The pwm fan control pin (pin4) contains a 0..5 V logic ("TTL-like") pwm signal (only 5mA loadable!) at 25kHz, which is intented to control the internal eletronics of the respective fan directly. 

So this type of pwm control is completely useless for a 3 pin fan which expects modulated 12-V-power, unless....
 
What might be possible is to use some external circuitry to translate the 0..5V logic signal into a pwm-modulation of the +12V supply, i.e. a power switch.


Before I start experimenting in hardware, just my question: 
 - did anybody find already a ready-made-solution for this kind of adapation circuitry?
 - if not: Is there any suitable IC known which does all in one (otherwise I might need at least 4 resistors and 2 transistors...)

Sorry for the lengthy explanation but the whole might be of interest for other MB owners as well who try to control their CPU fan and don?t succeed....

Best regards
	Christian

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061103/74985e78/attachment.html 
