From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH 2.6.12-rc1] i2c: i2c-mv64xxx - set adapter owner and class
Message-Id: <20050331200638.GD664@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <424B18D2.1070302@mvista.com>
In-Reply-To: <424B18D2.1070302@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 30, 2005 at 02:23:30PM -0700, Mark A. Greer wrote:
> i2c: Set adapter owner and class fields.
> 
> This patch adds the correct values for the 'owner' and 'class' fields of
> the adapter structure in the mv64xxx i2c bus driver.  The missing class
> field caused some i2c chip drivers to refuse to attempt a probe on the 
> mv64xxx i2c bus. 
> 
> Signed-off-by: Chris Elston <chris.elston@radstone.co.uk>
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>

Applied, thanks.

greg k-h
