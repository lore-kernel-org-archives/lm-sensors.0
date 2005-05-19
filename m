From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: Ticket 1833
Message-Id: <20041208222916.1ac8d3c1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0412020915370.25485@boxer.fnal.gov>
In-Reply-To: <Pine.LNX.4.58.0412020915370.25485@boxer.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > The only thing I'd suggest would be to try forcing a w83791d instead
> > of a w83781d. Maybe there are more similarities between these two.
> 
> No difference in the output.  sensors still reports it as
> w83781d-i2c0-2f no matter which of the seven chips in the driver
> I try to force it as.

That's odd. I checked to make sure and I am able to force the w83781d
driver to any chip I want. Please make sure you didn't forgot to unload
the driver before loading it again (Linux 2.4 won't complain and fails
silently if you do, it seems). Also, please check in your logs that you
have versions of i2c-core and i2c-proc that match those of w83781d.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
