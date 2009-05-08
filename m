From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 08 May 2009 10:13:43 +0000
Subject: Re: [lm-sensors] weird oscillation in temp reading
Message-Id: <20090508121343.303b8513@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <237854710905041853x1f68ec9ei535c1e8467e442ba@mail.gmail.com>
In-Reply-To: <237854710905041853x1f68ec9ei535c1e8467e442ba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Simon,

On Mon, 4 May 2009 21:53:22 -0400, Simon Chen wrote:
> I am using lm-sensor on a dual-quad-core system with two Xeon 5460. I
> am running a periodic workload on one of the cores: 400ms computation
> and 600ms idle.
> 
> >From the thermal side, the temp reading is shown in the figure
> attached. Notice that there is a very obvious oscillation in the
> temperature reading on that core. The oscillating period is around
> 20-30 seconds, which is definitely not sub-second.
> 
> I've no idea what's going on here. Can anyone share some thoughts?

I can't remember anything like that before. But you didn't provide
enough data for me to comment on it. How do you measure the
temperature? Can you reproduce the behavior on a different core? Does
the temperature reading oscillation depend on the period of the
workload? Does it depend on the duty cycle of the workload? Do you have
any form of frequency scaling in effect on these CPUs?

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
