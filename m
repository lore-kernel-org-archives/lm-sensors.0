From: mrenzmann@otaku42.de (Michael Renzmann)
Date: Thu, 15 Dec 2005 19:32:14 +0000
Subject: [lm-sensors] Question regarding temperature readings
Message-Id: <1134675134.4454.90.camel@gimli>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all.

Maybe the question sounds a little stupid, but I currently have no good
option to reliably find out, so...

Let's assume that one sensor is to report a temperature of 42 degrees
celcius. The system is running on 2.4.x. doc/developers/proc (in the
latest lm_sensors package) says that temperatures are given as
"millidegrees celcius". That would be "42000" then, right?

The reason for asking is that lm77.c (which is the only driver I can use
here atm) reports "4200.0" - the value isn't matching what I'd expect
(can be fixed easily, though), and the decimal point is a bit
irritating.

Did I miss something?

Bye, Mike


