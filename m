From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH] ds1337 2/3
Message-Id: <E1tkFUIb.1115199887.7528640.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20050504061354.GC1439@orphique>
References: <20050504061354.GC1439@orphique>
In-Reply-To: <20050504061354.GC1439@orphique>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ladis@linux-mips.org
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, James Chapman <jchapman@katalix.com>, Greg KH <greg@kroah.com>


Hi Ladislav, hi all,

> i2c_transfer returns number of sucessfully transfered messages. Change
> error checking to accordingly. (ds1337_set_datetime never returned
> sucess)

I think you mean ds1337_GET_datetime, not ds1337_SET_datetime, never
returned success?

Anyway I like the patch, it makes the driver treat the value returned by
i2c_transfer() properly and makes the code overall more consistent.

Thanks,
--
Jean Delvare
