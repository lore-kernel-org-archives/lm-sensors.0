From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 11 Aug 2005 21:14:28 +0000
Subject: [lm-sensors] Re: I2C block reads with i2c-viapro: testers wanted
Message-Id: <m3fytgnv73.fsf@defiant.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050809231328.0726537b.khali@linux-fr.org>
	<42FA6406.4030901@cetrtapot.si>
	<20050810230633.0cb8737b.khali@linux-fr.org>
	<42FA89FE.9050101@cetrtapot.si>
	<20050811185651.0ca4cd96.khali@linux-fr.org>
In-Reply-To: <20050811185651.0ca4cd96.khali@linux-fr.org> (Jean Delvare's
 message of "Thu, 11 Aug 2005 18:56:51 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Hinko Kocevar <hinko.kocevar@cetrtapot.si>, LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Jean Delvare <khali@linux-fr.org> writes:

> This is 1.033s down to 0.174s. This is just great, I2C block reads work
> and allow faster dumps, as expected.

Forgive my ignorance, but does it depend on the south bridge at all?
Isn't the block read capability just a function of EEPROM chip on
(I assume) RAM module?
-- 
Krzysztof Halasa
