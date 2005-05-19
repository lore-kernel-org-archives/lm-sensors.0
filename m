From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Query
Message-Id: <20031006225521.0f1414c7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1065472677.10222.1.camel@localhost.localdomain>
In-Reply-To: <1065472677.10222.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> What I would like to know is how you guys can tell at which address
> which hardware is located. Like you guys say that the pll is at
> address 0x69 etc.How can I tell if the device that I am looking for is
> at a particular address.

Use our sensors-detect script. If it fails detecting what you are
looking for, use i2cdetect to list your i2c busses, then use i2cdump on
each of the addresses to see the "contents" of each chip. If you have an
idea of what you're after (e.g. register X contains manufacturer ID Y)
you should be able to locate it.

If the identification is of general interest, let us know, so that we
may update sensors-detect. You can also send us a patch directly :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
