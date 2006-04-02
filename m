From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 02 Apr 2006 10:03:53 +0000
Subject: [lm-sensors] nForce 410
Message-Id: <20060402120353.4339a697.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060401215808.67999.qmail@web37401.mail.mud.yahoo.com>
In-Reply-To: <20060401215808.67999.qmail@web37401.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> > Mark, please try the following (as root):
> > modprobe i2c-nforce2
> > echo "10de 0264" > /sys/bus/pci/drivers/nForce2_smbus/new_id
> >
> > It should bring the SMBus to work. If it does, we'll add that ID
> > to the driver permanently.
> 
>  I followed your instruction but i2cdetect still complains about
> there being no busses.

Remember you must load i2c-dev before running i2cdetect.

-- 
Jean Delvare

