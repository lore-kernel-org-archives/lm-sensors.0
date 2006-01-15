From: fhj-52@sbcglobal.net (Ric Johnson)
Date: Sun, 15 Jan 2006 23:38:32 +0000
Subject: [lm-sensors] New device: SMSC's  EMC6W201 -support?
Message-Id: <20060115233832.76526.qmail@web81604.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all:

I searched the last 6 months of this list and found no reference to SMSC's
EMC6W201 hardware monitoring and fan control device for multi-processor
systems.
I presume that means that it has not been considered yet as one of the new
devices to be supported.  I would like to add it to the short list and will
provide a little info to get things rolling.

Please make any reply to me directly as I am unable to monitor this list at
this time.  If need be for testing, I'll make arrangements to change that.

It is a relatively new device(July 2005) from SMSC and is being used on, at
least, the Gigabyte(GBT) Dual Opteron 2CEWH mainboard -a single EMC6W201 on
SMBus 2.0.  I am not sure how many others use it now or intend to in the
future. 

The 2CEWH mobo also uses the ITE IT8712F Super I/O device but, according to
GBT, it only functions as the I/O controller.  The hardware monitor & control
functions are handled by the EMC6W201 device.  Perhaps needless to say, that
confused lm_sensors a bit.  I was unaware of the additional chipset when I
performed the lm_sensors setup so I made some mistakes too.  Of course, the
result is pretty wacky output from some readings and not all monitors are
available.

I checked the lm_sensors website and found that the SMSC EMC6W201 is not
listed with even partial support. I also see that SMSC is not listed as one of
the "supporters" for lm_sensors.  I certainly hope that only means they have
not been asked.

The EMC6W201 product page is located here:
http://www.smsc.com/main/catalog/emc6w201.html#Additional Information

A brief description is:
"
The EMC6W201 is an environmental monitoring device with automatic fan control
capability and enhanced system acoustics for noise suppression. This ACPI
compliant device provides hardware monitoring for up to six voltages
(including its own VCC) and five external thermal sensors, measures the speed
of up to five fans, and controls the speed of multiple DC fans using three
Pulse Width Modulator (PWM) outputs.
"
There is a PDF product brief, EMC6W201 Data Brief,  available here:
http://www.smsc.com/main/datasheets/6w201db.pdf

As per SMSC, there is an evaluation board available;
EVB-EMC6W201 is the EMC6W201 Evaluation Board.
I presume that it would be similar to but, because of the newness of the
EMC6W201 product, probably less robust than this one:
http://www.smsc.com/main/catalog/emc6d102evb.html
IOW, it might not include functional software.

I have no idea if the company will provide the eval board for software
development at no cost during some evalution period or if one has to buy the
eval board. I did not find a way to purchase the eval board.  I presume that
means one has to complete a technical support form and request information:
https://www2.smsc.com/mkt/intforms.nsf/faemail


As far as testing goes, I, at least, probably would be willing to do that
since I would very much like to have the output data available in Linux. 

Is anybody interested in working on this?

Ric Johnson

