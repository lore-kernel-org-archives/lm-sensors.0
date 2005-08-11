From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 11 Aug 2005 08:00:13 +0000
Subject: [lm-sensors] Backport to 2.4 kernel of lm77 to use in wrap board
Message-Id: <20050811080012.74d1be44.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42FA0A66.1050504@infovia.com.ar>
In-Reply-To: <42FA0A66.1050504@infovia.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Beat,

> > You certainly mean 48h.
>
> The manual of the wrap board says the following:
> 
> The LM77 thermal sensor sits on the secondary I2C bus, at address 90h.

And it's wrong. They're confusing the first byte sent in a write
transaction ((48h << 1) + 0 = 90h) with the 7-bit address of the device
(0x48). That's a common mistake.

> > You need a bus driver for the I2C bus the LM77 chip is connected to.
>
> This driver is not already available? How can I identify the bus?
> How to I setup a bus?
>
> I've seen that in openbsd there is support for LM77 and Nationl Geode 
> SC1100.
> Could we have a clue from there? I don't have BSD so I cannot
> identify in which packages this stuff is ...

I don't know, I've never worked with such boards before.

> I'm trying since days to connect to the national web site with no luck
> ...

Try the AMD website. National Semiconductor sold their Geode buisness to
AMD some years ago.

-- 
Jean Delvare
