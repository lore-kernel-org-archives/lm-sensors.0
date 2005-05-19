From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: [PATCH] I2C-MPC: Convert to platform_device driver
Message-Id: <20050114184159.GB30093@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.61.0501132130580.27720@blarg.somerset.sps.mot.com>
In-Reply-To: <Pine.LNX.4.61.0501132130580.27720@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kumar Gala <galak@somerset.sps.mot.com>
Cc: linuxppc-embedded@ozlabs.org, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 09:35:32PM -0600, Kumar Gala wrote:
> Converted the driver to work as either a OCP or platform_device driver.  
> The intent in the future (once we convert all PPC sub-archs from OCP to 
> platform_device) is to remove the OCP code.

Applied, thanks.

greg k-h
