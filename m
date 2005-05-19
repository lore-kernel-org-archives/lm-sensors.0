From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: [2.6 patch] i2c it87.c: remove an unused function
Message-Id: <20041105214739.GF1750@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041028222039.GO3207@stusta.de> <20041029001745.GI29142@stusta.de>
In-Reply-To: <20041029001745.GI29142@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: Chris Gauthron <chrisg@0-in.com>, phil@netroedge.com, sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 02:17:45AM +0200, Adrian Bunk wrote:
> [ this time without the problems due to a digital signature... ]
> 
> The patch below removes an unused function from drivers/i2c/chips/it87.c
> 
> 
> diffstat output:
>  drivers/i2c/chips/it87.c |    7 -------
>  1 files changed, 7 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

greg k-h
