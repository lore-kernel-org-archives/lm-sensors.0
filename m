From: greg@kroah.com (Greg KH)
Date: Fri, 24 Mar 2006 01:13:49 +0000
Subject: [lm-sensors] [PATCH] i2c: Add support for virtual I2C adapters
Message-Id: <20060324011349.GC28500@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0603231854270.29782-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0603231854270.29782-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kumar Gala <galak@kernel.crashing.org>
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 06:55:31PM -0600, Kumar Gala wrote:
> +EXPORT_SYMBOL(i2c_add_virt_adapter);
> +EXPORT_SYMBOL(i2c_del_virt_adapter);

EXPORT_SYMBOL_GPL() perhaps?

thanks,

greg k-h

