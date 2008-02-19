From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Feb 2008 09:57:49 +0000
Subject: Re: [lm-sensors] [PATCH v2] adt7473: New driver for Analog Devices
Message-Id: <20080219105749.3f5b914e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080218213322.GD5784@tree.beaverton.ibm.com>
In-Reply-To: <20080218213322.GD5784@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 18 Feb 2008 22:06:02 -0500, Mark M. Hoffman wrote:
> Hi Darrick:
> 
> * Darrick J. Wong <djwong@us.ibm.com> [2008-02-18 13:33:23 -0800]:
> > adt7473: New driver for Analog Devices ADT7473 sensor chip
> > 
> > This driver reports voltage, temperature and fan sensor readings
> > on an ADT7473 chip.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> > ---
> > 
> >  Documentation/hwmon/adt7473 |   79 +++
> >  drivers/hwmon/Kconfig       |   10 
> >  drivers/hwmon/Makefile      |    1 
> >  drivers/hwmon/adt7473.c     | 1157 +++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 1247 insertions(+), 0 deletions(-)
> > 
> 
> Applied to hwmon-2.6.git/testing, thanks.

wiki/Devices updated accordingly.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
