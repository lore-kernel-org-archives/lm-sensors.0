From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: I2C driver for embedded Motorola PPC products
Message-Id: <1078998712.405036b8a9361@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <0AB9C6CD-72E3-11D8-B2B5-000393DBC2E8@motorola.com>
In-Reply-To: <0AB9C6CD-72E3-11D8-B2B5-000393DBC2E8@motorola.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Mark Studebaker <mds4@verizon.net>:

> But if you're looking to get the driver where people will use it,
> and ultimately into the mainstream kernel, you should target
> a PPC 2.6 tree.

Is it related to i2c-algo-8xx and i2c-rpx we have in our i2c repository?
If new developments have occured elsewhere, we may even consider
removing these files completely on our side, since it's more lilely to
cause trouble (people starting to work on old material when newer
versions exist) than anything else.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
