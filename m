From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH 2.6] I2C: Fix race condition in it87 driver
Message-Id: <20050328210335.GC3752@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050324223901.23beb827.khali@linux-fr.org>
In-Reply-To: <20050324223901.23beb827.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 24, 2005 at 10:39:01PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> I noticed a race condition in the it87, affecting the IT8712F chip only.
> The VRM value is currently initialized *after* creating the vrm and vid
> sysfs files. This leaves a theorical room for reading from these files
> and get an invalid value. It's not critical, but let's still fix it.
> 
> Please apply, thanks.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied, thanks.

greg k-h
