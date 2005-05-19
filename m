From: mr-smoke@spinning-plates.eu.org (Romain Riviere)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: Ticket 1382 : Update
Message-Id: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello there,

I've found the solution to my problem (apparently at least).
I downloaded a vanilla kernel, instead of the distro kernel, and voil?.
It worked. At least, it compiled, but I'm confident :)

The kernel was Mandrake 9.1 updated 2.4.21-0.25mdk. Compilation was ok
with i2c patch only, but broken with lm-sensors patch.

Thanks and all the best :)
Romain
