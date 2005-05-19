From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [PATCH 2.6] I2C: Fix i2c-sis5595 pci configuration accesses
Message-Id: <20050125062810.GE2361@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050123101504.79f65398.khali@linux-fr.org>
In-Reply-To: <20050123101504.79f65398.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 23, 2005 at 10:15:04AM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> The i2c-sis5595 bus driver has logic errors on pci configuration
> accesses. It returns an error on success and vice versa. The 2.4 kernel
> version of the driver, as found in the lm_sensors CVS repository, is
> correct, so the problem was introducted when the driver was ported to
> the 2.6 kernel tree  (in 2.6.0-test6). As odd as it sounds, the driver
> has been sitting here broken and unusable for 17 months and nobody ever
> reported, until yesterday.
> 
> Credits go to Sebastian Hesselbarth for discovering and analyzing the
> problem.
> 
> Here is a patch that fixes the problem, succesfully tested by Aurelien
> Jarno and Sebastian Hesselbarth. Please apply.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied, thanks.

greg k-h
