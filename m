From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: LM83 support
Message-Id: <20030702191223.5d15db6a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030702090820.2c39fd00.khali@linux-fr.org>
In-Reply-To: <20030702090820.2c39fd00.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I would recommend extending the adm1021 driver.  It's a relatively 
> simple driver and not nearly as complex as the w83781d.  And the 
> supported chips have fewer differences.

After taking a look at the code, I had come to the opposite conclusion.
The adm1021 driver handles only 2 temperature sensors while the LM83
specificity is that it has 4 temperature sensors. If we are to limit the
LM83 to 2 temperature readings, then it becomes a LM84 that is already
supported. And changing the adm1021 driver code to support 4 temperature
sensors probably makes no sense. So I was planing to write a new driver
for the LM83.

Wether or not existing support should then be moved from adm1021 to lm83
could be discussed later (although my arguments right above make it
quite obvious that older chipsets should be kept supported by adm1021).

> You should probably look at modularizing the extended features
> somewhat. 
>   You can look at my lm85.c driver for an example.

I'll take a look at the code and see if it can change my mind. As said
in a previous post, I never write a driver myself so my opinion may not
be the wisest.

One thing that should be taken into account however is the fact that the
adm1021 driver already supports 8 devices, which is our current max.
Adding a ninth chipset to this driver would introduce (again)
incompatibilities.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
