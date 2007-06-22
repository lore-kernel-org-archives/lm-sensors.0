From: "Walter F.J. Mueller" <W.F.J.Mueller@gsi.de>
Date: Fri, 22 Jun 2007 13:19:22 +0000
Subject: [lm-sensors] read/write access to SMBus on a PCIe slot
Message-Id: <467BCC5A.1000905@gsi.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

we are currently developing a custom PCIe card, based on Virtex-4 FX FPGA's.
Since PCIe slots have a SMBus connection, it would be very convenient to use
the SMBus as auxiliary connectivity, e.g. for firmware updates. This would
require the ability to read from and well write to such a SMBus target
implemented on a PCIe card.

That goes clearly beyond reading sensors, thus the question: is such
a functionality implementable based on what the i2c and lm-sensor
framework provides ? Any hint is very welcome.

			With best regards,	Walter

--=20
Dr. Walter F.J. M=FCller       Mail:  W.F.J.Mueller@gsi.de
GSI,  Abteilung KP3          Phone: +49-6159-71-2766
Planckstr. 1                 FAX:   +49-6159-71-3762
D-64291 Darmstadt            URL: http://www-linux.gsi.de/~mueller/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
