From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 07 Aug 2006 08:02:36 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <20060807100236.0368f842.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Michael Hanselmann wrote:
> > +	depends on HWMON && PPC_PMAC && !PPC64 && INPUT && ((ADB_PMU && I2C = y) || (ADB_PMU && !I2C) || I2C) && EXPERIMENTAL
> >   
> Maybe we should just add "select I2C" instead. Then, if the user had I2C 
> as a module and wants AMS he'll get I2C built-in. I think/hope :)

No, please. I2C is something which you should depend on, not something
you select.

-- 
Jean Delvare

