From: fhj-52@sbcglobal.net (Ric Johnson)
Date: Tue, 13 Jun 2006 20:26:02 +0000
Subject: [lm-sensors] Using ... SMSC EMC6W201
Message-Id: <20060613202602.560.qmail@web81611.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

Sorry about the previous double email/post; SBC/AT&T-yahoo went wacko and sent
instead of saving draft. ...

I am posting again to add that this GBT mobo is also used in (at least) the
Fujitsu-Siemans Celsius V workstation which is, currently, their high-end AMD
workstation(i.e., more that I can afford...).

I mention that because the SMSC EMC6W201 has features that are in other chips
from F-S, namely the Scylla and Hermes chips which are listed in  sensors.conf
as chip "fscscy-*" and chip "fscher-*", respectively.   The Scylla has dual
CPU ability and the Hermes has PWM control.  The 6w201 does both.
The Fujitsu-Siemens Scylla chip is really very close to having the same
available functions as the EMC6w201 chip but it has 6 fan monitoring and is
lacking the PWM control.

It might be that using code from those chips and/or the other SMSC devices
that are already in  libsensors   would make the addition of the SMSC EMC6W201
easier.
Yes?/no? ...

I posted about the 6w201 back in February. ... 
I'll summarize the "features" here since I did not do that before.
The device is a monitoring and control chip with
+ 5 temperatures via diodes plus 1 "internal Ambient" temperature;
+ 3 PWM controls for fans which can control as many as 5 fans by connecting 2
PWM fans on each of two of the PWM connectors; Monitors RPM on 5 fans;
+ 6 voltages (but the 12VDC is not one of them and 2 of them are not needed).

It, of course, does a lot of "stuff" but the above are the basics.
The blip about it is here:
http://www.smsc.com/main/catalog/emc6w201.html

Any assistance is appreciated as I am at a standstill at this point and do not
know what to do next to get the implementation done.

Thanks, :)

Ric
...
Success
" He has achieved success who has lived well, laughed often, and loved much; who has enjoyed the trust of pure women, the respect of intelligent men and the love of little children; who has filled his niche and accomplished his task; who has left the world better than he found it whether by an improved poppy, a perfect poem, or a rescued soul; who has never lacked appreciation of Earth's beauty or failed to express it; who has always looked for the best in others and given them the best he had; whose life was an inspiration; whose memory a benediction. "
- Bessie A. Stanley( Published in Lincoln Sentinel, Nov. 30, 1905 )

