From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [PATCH 2.6] I2C: Update fscher pwm functionality
Message-Id: <20050107001800.GB26986@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050105224847.4868fe93.khali@linux-fr.org>
In-Reply-To: <20050105224847.4868fe93.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 05, 2005 at 10:48:47PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> This is a small update to the fscher hardware monitoring chip driver.
> More specifically it fixes two aspects of pwm:
> 1* Use the new sysfs names (e.g. pwm1 instead of fan1_pwm).
> 2* Better handling of out-of-range pwm values.
> 
> Please apply,

Applied, thanks.

greg k-h
