From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: [PATCH 2.6] I2C: Fix amd756 name
Message-Id: <20041019222845.GH9521@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041016200019.3962f8a4.khali@linux-fr.org>
In-Reply-To: <20041016200019.3962f8a4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Oct 16, 2004 at 08:00:19PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> This sets the proper name for busses supported by the i2c-amd756 driver.
> So far, all busses were named AMD756 regardless of the real hardware.
> Setting the real name is certainly less confusing for the user, and the
> sensors-detect script expects this too.
> 
> Please apply,

Applied, thanks.

greg k-h
