From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: [PATCH 2.6] kill duplicate includes in i2c bus drivers
Message-Id: <20040511204429.GB23991@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040509202400.4b5b4a90.khali@linux-fr.org>
In-Reply-To: <20040509202400.4b5b4a90.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, May 09, 2004 at 08:24:00PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> Following a suggestion of Arthur Othieno, here is a trivial patch that
> kills duplicate inclusions of config.h in four i2c bus drivers.
> 
> At first I was thinking of also removing inclusions of config.h wherever
> it doesn't seem to be necessary but Eugene doesn't seem to think it's a
> good idea. So I may give it a try later (in 2.7), but for now this
> simple patch will be enough.
> 
> Please apply,

Applied, thanks.

greg k-h
