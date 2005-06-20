From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 20 Jun 2005 15:57:49 +0000
Subject: [lm-sensors] Ticket 2005
Message-Id: <1gsznKUk.1119275600.2102460.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200506161659.57761.atis@mikrotik.com>
In-Reply-To: <200506161659.57761.atis@mikrotik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Atis,

Atis Elsts wrote:
> Uhm. I'm confused here, because i2cdump and i2cdetect says:
> "Error: Could not open file `/dev/i2c-1': No such device"

You need to modprobe i2c-dev, sorry for not telling you before.

> It's EMC6D103-CK.
> In lm85.c there is, however, driver only for emc6d102. I choose it as
> closest match to the name :)

We don't support it officially yet, so this comes to no surprise that
you had to force it.

Thanks,
--
Jean Delvare
