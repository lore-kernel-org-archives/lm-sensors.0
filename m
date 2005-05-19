From: timm@fnal.gov (Steven Timm)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: Ticket 1833
Message-Id: <Pine.LNX.4.58.0412061418330.10292@boxer.fnal.gov>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0412020915370.25485@boxer.fnal.gov>
In-Reply-To: <Pine.LNX.4.58.0412020915370.25485@boxer.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 
> It would certainly if we were not expecting a driver and datasheet from
> Winbond for the next days or weeks. Trying to write a quick hack now
> would obviously be a duplicate effort.
> 
> The only thing I'd suggest would be to try forcing a w83791d instead of
> a w83781d. Maybe there are more similarities between these two.

No difference in the output.  sensors still reports it as
w83781d-i2c0-2f no matter which of the seven chips in the driver
I try to force it as.

Steve Timm

> 
> -- 
> Jean Delvare
> http://khali.linux-fr.org/
> 
