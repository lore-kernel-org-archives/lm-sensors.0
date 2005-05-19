From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: [PATCH] ds1337 3/4
Message-Id: <u5mZNEX1.1112954918.3200720.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20050407231848.GD27226@orphique>
References: <20050407231848.GD27226@orphique>
In-Reply-To: <20050407231848.GD27226@orphique>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ladis@linux-mips.org
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, James Chapman <jchapman@katalix.com>, Greg KH <greg@kroah.com>


Hi Ladislav,

> dev_{dbg,err} functions should print client's device name. data->id can
> be dropped from message, because device is determined by bus it hangs on
> (it has fixed address).

Looks OK to me.

Thanks,
--
Jean Delvare
