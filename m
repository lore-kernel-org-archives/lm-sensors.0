From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: issue with asus a7a266 mobo
Message-Id: <1077542057.4039fca98deb6@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <200402230044.21522.viga.linux@free.fr>
In-Reply-To: <200402230044.21522.viga.linux@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Mark Studebaker <mds4@verizon.net>:

> what exactly is the problem?
> It wasn't apparent in the attachments.

I think it's exactly the same problem as ticket 1501 (same motherboard).
Sensors-detect finds an AS99127F rev.2, but the w83781d driver in Linux
2.6 doesn't recognize the chip as one it supports.

I took a look at the detection and identification code in the driver,
compared with the dump Viga provided, and couldn't see where it would
fail.

It may well be the first time that we have feedback on the rev.2.

Viga,

Which version of lm_sensors do you use with your 2.4 kernel? (it does
recognize your chip if I understood you correctly)

With Linux 2.6, please try to load the w83781d driver with the
force=0,0x2d parameter, and tell us if it works. If not, try again with
force_as99127f=0,0x2d and tell us if it works. Please provide the logs
of both experiments if there are logs. If you compiled the driver with
DEBUG, it's even better.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
