From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH] ds1337: export ds1337_do_command
Message-Id: <JbaRtloW.1115729506.5440950.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20050510121814.GB2492@orphique>
References: <20050510121814.GB2492@orphique>
In-Reply-To: <20050510121814.GB2492@orphique>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ladis@linux-mips.org
Cc: James Chapman <jchapman@katalix.com>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, Greg KH <gregkh@suse.de>


Hi Ladislav,

> Export ds1337_do_command so it could be used also if driver is built as
> module.

Great, now we can apply the previous patch (changing the
ds1337_do_command parameters) and this one on top of it.

Thanks for your continued work on the ds1337 driver, this is much
appreciated.

--
Jean Delvare
