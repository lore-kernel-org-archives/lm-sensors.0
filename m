From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: [PATCH 1/2] i2c: sensors chip driver updates
Message-Id: <20040929204208.GB16800@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040923041609.GG4256@jupiter.solarsys.private>
In-Reply-To: <20040923041609.GG4256@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Sep 23, 2004 at 12:16:09AM -0400, Mark M. Hoffman wrote:
> This patch modifies some sysfs file names for sensors chip drivers in
> accordance with the standard interface proposed here [1] and refined
> here [2].  The lm_sensors userspace tools have been modified to accept
> both the new and old names.  This patch was tested for some drivers,
> and at least compile tested for the rest.
> 
> [1] http://archives.andrew.net.au/lm-sensors/msg08477.html
> 
> [2] http://archives.andrew.net.au/lm-sensors/msg18391.html
> 
> Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

Applied, thanks.

greg k-h
