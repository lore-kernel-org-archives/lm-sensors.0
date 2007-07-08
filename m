From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Jul 2007 16:53:12 +0000
Subject: Re: [lm-sensors] [PATCH] First cut of a adt7470 driver
Message-Id: <20070708185312.1f66d0a5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070706211144.GI3435@tree.beaverton.ibm.com>
In-Reply-To: <20070706211144.GI3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darrick,

On Fri, 6 Jul 2007 14:11:45 -0700, Darrick J. Wong wrote:
> Below is a first draft of a driver for the ADT7470 chip.  I've tested
> the driver against the adt7470 in the IBM IntelliStation Z30 and as far
> as I can tell it's good for controlling the speed of the CPU heatsink
> fans and monitor CPU temperature.  Please let me know what you think of
> the driver.  The patch should apply cleanly against 2.6.22-rc7.

I've added an entry in our wiki Devices page to track this one.

Note that back in January this year, someone (Vadim Zeitlin, Cc'd)
asked for support for this chip. So maybe Vadim would be interested in
testing your driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
