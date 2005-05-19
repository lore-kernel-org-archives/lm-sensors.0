From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: [PATCH 2.6] Remove extra inits from lm78 driver
Message-Id: <20040714183519.GB10099@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040713004131.GC16654@jupiter.solarsys.private>
In-Reply-To: <20040713004131.GC16654@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jul 12, 2004 at 08:41:31PM -0400, Mark M. Hoffman wrote:
> Hi Greg:
> 
> The following patch applies to 2.6.8-rc1.
> 
> * * * * *
> 
> This patch is from the lm_sensors project CVS, from this revision:
> 
> 	1.63 (mds) remove initialization of limits by driver
> 
> It is better to set these limits by a combination of /etc/sensors.conf
> and 'sensors -s'; "mechanism not policy."  Please apply.
> 
> Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

Applied, thanks.

greg k-h
