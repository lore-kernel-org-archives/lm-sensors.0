From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: 'Use the ddcmon and/or decode-edid.pl scripts' message
Message-Id: <mU2VWDn4.1114512993.9135740.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <a8007ab4050425164642962763@mail.gmail.com>
In-Reply-To: <a8007ab4050425164642962763@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Quoting myself:
> BTW, you pointed out a bug in the driver (the min limit being arbitrarily
> set to 952 RPM, while it was most likely disabled in the first place). I
> will have to fix that.

On second thought, the driver is behaving as it should. The PC8736x chips
have a dedicated overflow flag for fans, so there is no reason to handle
the 255 register value any differently than other register values.

--
Jean Delvare
