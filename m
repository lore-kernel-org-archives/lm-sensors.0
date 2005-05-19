From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: [PATCH 2/2] i2c: kill some sensors driver macro abuse
Message-Id: <20040929204157.GA16800@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040923041719.GH4256@jupiter.solarsys.private>
In-Reply-To: <20040923041719.GH4256@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Sep 23, 2004 at 12:17:19AM -0400, Mark M. Hoffman wrote:
> This patch kills a specific kind of ugly and ultimately useless macro
> abuse found in many sensors chip drivers.  Compile tested only.

Applied, thanks.

greg k-h
