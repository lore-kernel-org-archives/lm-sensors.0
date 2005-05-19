From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: lm85 and emc6d102
Message-Id: <fZl9WQiU.1107184348.6006600.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050131023717.M68048@bielyvlk.sk>
In-Reply-To: <20050131023717.M68048@bielyvlk.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi palo,

> i now use (test) patch from Rafael Espindola for EMC6D100 and it work OK
>
> board: intel D865GLC
> linux: 2.6.10 + (only) "lm85.c" from 2.6.11-rc2
> lmsensors: 2.9.0

Great, thanks for the report :) I updated the ticket.

> ps, will supported "fan speed monitor" in PC87372 with lmsensors ? (is
> not important)

You are not the first one to ask for a driver. The PC87372 has fan
control and monitoring capabilities, although not all boards with this
chip might actually take benefit of these features.

Unfortunately, none of us developers have a board with such a chip to
write the driver. It would take the donation of supporting hardware for
us to be able to do so. We had a proposal some times ago but nothing
concrete happened since as far as I know:
http://archives.andrew.net.au/lm-sensors/msg26908.html

Thanks,
--
Jean Delvare
