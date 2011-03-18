From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Mar 2011 20:35:43 +0000
Subject: Re: [lm-sensors] Logging and plotting
Message-Id: <20110318213543.785e7d6c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D83AE4E.7030402@cfl.rr.com>
In-Reply-To: <4D83AE4E.7030402@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 18 Mar 2011 20:17:04 +0100, Ian Dobson wrote:
> From: "Phillip Susi" <psusi@cfl.rr.com>
> Sent: Friday, March 18, 2011 8:11 PM
> To: <lm-sensors@lm-sensors.org>
> Subject: [lm-sensors] Logging and plotting
> 
> > Is there a way to log the sensors from a server over say, a 24 hour
> > period, and plot the results?
> 
> Have a look at munin. My temperature logs:- 
> http://mail.planet-ian.com/munin/planet-ian.com/alpha2.planet-ian.com/sensors_temp.html

Alternatively, sensord is included in lm-sensors, it's not exactly
user-friendly to setup, but it does a decent job for logging (over 7 days) and
plotting (daily and weekly graphs). See an example graph at:
http://www.lm-sensors.org/wiki/ProjectInformation

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
