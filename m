From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Donation.
Message-Id: <20031101195132.2ac07d4b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <F7CB408531C5264680C9E37DE4FE71A4088FDF@limkexm2.ad.analog.com>
In-Reply-To: <F7CB408531C5264680C9E37DE4FE71A4088FDF@limkexm2.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

> In particular many Asus mainboards have SMBus pins.  I've never seen
> anything advertised by them to connect to it... but I did hook up a
> scope to one of mine to confirm that it works.

Just opened my two cases, nothing interesting in the first one (there's
a mysterious 3-pin port named PWRATX (if I read it correctly) but it
doesn't sound like what I am after) but there is a 4-pin port named SMB
on the second one (ATV133-C). It damn sounds like what you're talking
about. I guess that these pins are +VCC, ground, SCL and SDA? Any idea
about the order? Pin 1 is alone, then there's a hole, then three more
pins.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
