From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: [PATCH] I2C Part 1 - Remove some redundancy from the i2c-core.c
Message-Id: <20050323224430.634e0a75.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42418B36.5030407@mvista.com>
In-Reply-To: <42418B36.5030407@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Corey Minyard <cminyard@mvista.com>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>

Hi Corey,

> Call i2c_transfer() from i2c_master_send() and i2c_master_recv()
> to avoid the redundant code that was in all three functions.

I like this. You're right, there is code duplication here, which we can
get rid of, so let's do so. I'd only have one comments about your patch:

You can get rid of the dev_dbg calls in i2c_master_send() and
i2c_master_recv() altogether IMHO. I recently updated i2c_transfer() to
make it more verbose in debug mode [1], so the debug messages in
i2c_master_send() and i2c_master_recv() are mostly redundant now as far
as I can see.

[1] http://archives.andrew.net.au/lm-sensors/msg29859.html

Thanks,
-- 
Jean Delvare
