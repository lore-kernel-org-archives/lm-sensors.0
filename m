From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: [2.6 patch] i2c/busses/ : make some code static
Message-Id: <20041109004938.GC25651@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041107023333.GB14308@stusta.de>
In-Reply-To: <20041107023333.GB14308@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: phil@netroedge.com, sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Sun, Nov 07, 2004 at 03:33:33AM +0100, Adrian Bunk wrote:
> The patch below makes some needlessly global code under i2c/busses/ 
> static.
> 
> 
> diffstat output:
>  drivers/i2c/busses/i2c-ali1535.c |    4 ++--
>  drivers/i2c/busses/i2c-amd8111.c |   12 ++++++------
>  drivers/i2c/busses/scx200_acb.c  |    4 ++--
>  drivers/i2c/busses/scx200_i2c.c  |    4 ++--
>  4 files changed, 12 insertions(+), 12 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

greg k-h

