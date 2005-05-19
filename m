From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: [PATCH] i2c-prosavage.c section usage
Message-Id: <20040309230258.GD13763@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040307194701.0cf1ec47.rddunlap@osdl.org>
In-Reply-To: <20040307194701.0cf1ec47.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 07, 2004 at 07:47:01PM -0800, Randy.Dunlap wrote:
> 
> Hi,
> 
> prosavage_remove() is called during init, so it shouldn't be
> marked as exit code.  (It matters when CONFIG_HOTPLUG=n.)

Applied, thanks.

greg k-h
