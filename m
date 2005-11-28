From: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 28 Nov 2005 13:46:41 +0000
Subject: [lm-sensors] Re: [PATCH 17/25] i2c: Drop i2c_driver.{owner, name},
Message-Id: <20051128124556.GB30298@flint.arm.linux.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051126205106.154b3d4d.khali@linux-fr.org>
In-Reply-To: <20051126205106.154b3d4d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Nov 26, 2005 at 08:51:06PM +0100, Jean Delvare wrote:
> From: Laurent Riffard <laurent.riffard@free.fr>
> Content-Disposition: inline; filename=i2c-drop-driver-owner-and-name-08-acorn.patch
> 
> We should use the i2c_driver.driver's .name and .owner fields
> instead of the i2c_driver's ones.
> 
> This patch updates the drivers for acorn arch.
> 
> Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
