From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 14 Jun 2006 15:50:21 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <20060614175021.6bde0117.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf,

> > > > Using SENSOR_LIMIT here doesn't make sense, as we're not dealing with a
> > > > range. Better return -EINVAL if value is neither 0 nor 1.
> > >
> > > Well yes why not, maybe we should write a note to a docs?
> > 
> > I think the best we can do is to make it right in our drivers, because
> > this is where people look when writing new drivers. If you want to
> > extend the sysfs-interface documentation file to describe how invalid
> > values should be handled (on write), feel free to do so.
> 
> Ok
> 
> Well they are handled at least with two different ways.
> 
> 1) -EINVAL
> 2) if out of bounds - nearest bound is written

First for discrete values, second for ranges. This makes sense, and is
still simple enough so everyone should be able to get it.

-- 
Jean Delvare

