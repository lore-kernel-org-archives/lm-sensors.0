From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: [PATCH 2.6] I2C: Fix bogus bitmask in lm63 debug message
Message-Id: <20050113232929.GE2458@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050112203123.38105157.khali@linux-fr.org>
In-Reply-To: <20050112203123.38105157.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 12, 2005 at 08:31:23PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> There is a bitmask error in one debug message of my lm63 chip driver.
> Nothing critical but still worth fixing, hence comes a patch.
> 
> Credits go to Mohan Mistry for finding the error.
> 
> Please apply,

Applied, thanks.

greg k-h
