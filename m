From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: [PATCH 2.4] Trivial changes to I2C stuff
Message-Id: <20031122164907.GA3121@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031122161510.7d5b4d20.khali@linux-fr.org>
In-Reply-To: <20031122161510.7d5b4d20.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Marcelo Tosatti <marcelo@cyclades.com>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>

On Sat, Nov 22, 2003 at 04:15:10PM +0100, Jean Delvare wrote:
> Hi Marcelo, hi list,
> 
> Below is a simple patch that does some trivial changes to a few i2c
> drivers in 2.4.23-rc3. The changes are only white space and comment
> changes, and line reordering. There are also two simple changes to
> i2c-id.h to keep it in line with the one in Linux 2.6.0-test9.

Woah, -rc3 is _way_ too late for patches such as this.  Please wait for
2.4.23 to come out first.

thanks,

greg k-h
