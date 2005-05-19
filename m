From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: national sensorpath bus
Message-Id: <Pine.LNX.4.58.0408141825170.3039@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <41181309.8020806@verizon.net>
In-Reply-To: <41181309.8020806@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



I found some more info:

http://www.national.com/an/AN/AN-1316.pdf

For impatient there is no need to panic :)


The PC8374x HM module can be configured to control fan
speed automatically, depending on the temperature reading
and tachometer data (fan speed input). In addition, it can
notify the host when an event requires special handling.
Access to the HM module is possible via a dedicated SMBus
interface (HMSMBus with HMSCL and HMSDA pins), or
through the LPC bus. Status registers for various events can
be accessed via SMBus. These status registers can be
polled via SMBus for any event notification. This intelligent
system partitioning (sensors with minimal digital content con-
nected to I/O controller via the SensorPath bus) allows im-
proved flexibility in system design for health event manage-
ability (automatic, Host-supervised).

Communication between the HM and an external LMxx Sen-
sor is automatic (no user intervention/configuration required)


It will be simply ISA/Smbus accessed device
from the Lm_sensor point of view. (In fact it is for sure logical device
inside superIO :)

See the PDF there is even C program ready.

The only thing I dint found is some LPC register desc.
Regards

Rudolf
