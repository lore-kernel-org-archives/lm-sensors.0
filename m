From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sun, 27 Nov 2005 02:29:26 +0000
Subject: [lm-sensors] Re: [PATCH 13/25] i2c: Drop i2c_driver.{owner, name},
Message-Id: <1133054504.7768.84.camel@gaston>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051126204034.4c195439.khali@linux-fr.org>
In-Reply-To: <20051126204034.4c195439.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 2005-11-26 at 20:40 +0100, Jean Delvare wrote:
> From: Laurent Riffard <laurent.riffard@free.fr>
> Content-Disposition: inline; filename=i2c-drop-driver-owner-and-name-04-macintosh.patch
> 
> We should use the i2c_driver.driver's .name and .owner fields
> instead of the i2c_driver's ones.
> 
> This patch updates the drivers for macintosh.
> 
> Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


