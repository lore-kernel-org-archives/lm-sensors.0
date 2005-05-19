From: david-b@pacbell.net (David Brownell)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [patch 2.6.12-rc3+] i2c driver for TPS6501x
Message-Id: <200505130753.24023.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200505051618.34980.david-b@pacbell.net>
In-Reply-To: <200505051618.34980.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 05 May 2005 4:18 pm, David Brownell wrote:
> Attached is a patch against a GIT snapshot from yesterday, adding
> support for Texas Instruments TPS6501x power management chips(*).

OK, so no feedback ... seems like there are no issues.  In that
case, please merge this into the next set of I2C driver patches.

The official theory is after all to move all drivers into the
main kernel tree ... :)

- Dave
