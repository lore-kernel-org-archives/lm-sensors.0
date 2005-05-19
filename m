From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: [PATCH 2.6.12-rc1] I2C: Fix breakage in m41t00 i2c rtc driver
Message-Id: <20050317065729.GN15075@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <422E4313.6000004@mvista.com>
In-Reply-To: <422E4313.6000004@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 08, 2005 at 05:28:03PM -0700, Mark A. Greer wrote:
> Remove setting of deleted i2c_client structure member.
> 
> The latest include/linux/i2c.h:i2c_client structure no longer has an 
> 'id' member.  This patch removes the setting of that no longer existing 
> member.
> 
> Please apply.
> 
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>

Applied, thanks.

greg k-h
