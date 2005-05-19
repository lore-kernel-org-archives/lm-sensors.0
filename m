From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: Ticket #920
Message-Id: <200406030808.i5388EcV046365@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200206221117.33609.veso_vdd@mail.orbitel.bg>
In-Reply-To: <200206221117.33609.veso_vdd@mail.orbitel.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>Please, close this ticket. Probably the board was damaged as it finally gave
>up.

OK, done. I've also added a comment. I suspect that continuous byte read
was not working on your adapter/monitor combination, while regular byte
read was. Usually, EEPROMs support continuous read mode (aka
auto-increment), maybe yours wasn't. I don't remember hearing of
similar cases though, and we cannot verify my theory anymore.

Thanks for taking the time to report to us after all this time, that's
very nice from your :)

Jean Delvare
