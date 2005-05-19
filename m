From: goofee79@hotmail.com (tom paris)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Ticket 1671
Message-Id: <BAY18-F35Ejb0zNqBRH0000e079@hotmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello!

In addition to the case that Khali has looked at i'm sending you more info.

1. I load i2c-dev in modules.conf yes.
2. The sensors -v reveals 2.8.5 and sensors is located in /usr/local/bin. I=
=20
simply wrote wrong.
3. /sys/bus/i2c/devices contains these directories 1-002d,  1-002e,  1-0048=
=20
and  1-0049.

Under the directory 1-002d i can see all correct files telling me voltage, =

fan rpms and temps, and if i look in at them for example temp1_input i=20
clearly gives me my temperatures. Name contains asb100.

But still when i run sensors i get:
w83l785ts-i2c-1-2e
Adapter: SMBus nForce2 adapter at 5500
ERROR: Can't get temperature data!

Thank you for your help on this!

Regards,
Goofee

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE* =20
http://join.msn.com/?page=FEatures/junkmail
