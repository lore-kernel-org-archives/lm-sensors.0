From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: [PATCH 2.6] I2C: Enable w83781d and w83627hf temperature channels
Message-Id: <20050131182922.GD21546@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050127211136.7345e443.khali@linux-fr.org>
In-Reply-To: <20050127211136.7345e443.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 27, 2005 at 09:11:36PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> The chips supported by the w83781d and w83627hf drivers might come up
> with their temperature channels disabled. Currently, the w83781d driver
> does so for temp3 but omits temp2, while the w83627hf driver omits both.
> The following patch fixes that, and prints warning messages when the
> driver has to enable the channels (normally the BIOS should do it for
> us). We also skip this initialization step for the AS99127F chips, for
> which we have no documentation.
> 
> This should hopefully solve the problem reported here:
> http://archives.andrew.net.au/lm-sensors/msg29150.html

Applied, thanks.

greg k-h
