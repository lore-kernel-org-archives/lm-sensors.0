From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH] possible bug in i2c-algo-bit's inb function
Message-Id: <20050227195226.23aa5a51.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1D5GN2-0000Bi-KG@localhost.localdomain>
	<20050227103538.218fa1b0.khali@linux-fr.org>
	<1109528034.4564.16.camel@localhost.localdomain>
In-Reply-To: <1109528034.4564.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Oberritter <obi@saftware.de>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>

Hi Andreas,

> Here's my I2C code:
> (...)

Looks sane.

> The bus master is a so called Pluto2 by SCM (part of a DVB-T card sold
> by Satelco). If this is a hardware bug, is it possible to add a flag
> to struct i2c_algo_bit_data to workaround this bug?

I would try to find out whether the culprit is setscl or getsda
(assuming I am correct and either of these actually is the problem).
Once you know which it is, you could modifiy that function to restore
the SDA line, that should do the trick.

Hope that helps,
-- 
Jean Delvare
