From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: [PATCH] ds1337 1/4
Message-Id: <CN3QLeGu.1112950156.8219610.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20050407231758.GB27226@orphique>
References: <20050407231758.GB27226@orphique>
In-Reply-To: <20050407231758.GB27226@orphique>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ladis@linux-mips.org
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, James Chapman <jchapman@katalix.com>, Greg KH <greg@kroah.com>


Hi Ladislav,

> Use i2c_transfer to send message, so we get proper bus locking.

Looks all OK to me, let alone the lack of Signed-off-by line, as Greg
underlined elsewhere. Please resent the patches with the Signed-off-by
line after I finish reviewing them.

Thanks,
--
Jean Delvare
