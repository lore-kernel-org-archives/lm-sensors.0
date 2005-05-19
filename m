From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH 2.6] w83627hf needs i2c-isa
Message-Id: <20050302165542.GC2311@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050227114604.634d35f0.khali@linux-fr.org>
In-Reply-To: <20050227114604.634d35f0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Feb 27, 2005 at 11:46:04AM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> The w83627hf driver is useless unless i2c-isa is present. All other
> drivers in this case do select I2C_ISA through Kconfig, so this one
> should as well do.
> 
> Please apply,
> thanks.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied, thanks.

greg k-h
