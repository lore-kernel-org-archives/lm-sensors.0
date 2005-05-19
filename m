From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: sysfs names
Message-Id: <20040215193345.02f3cada.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040126230447.09700886.khali@linux-fr.org>
In-Reply-To: <20040126230447.09700886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > It'd be nice if the driver could provide a parameter to the
> > > sysfs show() and store() routines... i.e.
> > > 
> > > static ssize_t show_temp(struct device *dev, char *buf, int
> > > param);
> > > 
> > > DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 1)
> > > DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 2)
> > > DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 3)
> > 
> > Much like what we had in 2.4. And this was Good.
> 
> But we had multiple values per file, which was not "good" at all :)

These are two completely different things. What Mark and I are pointing
out here is that we used to have a *single* callback function for all
tempN files. The fact that this function returned more than one value is
unrelated.

The difficulty here is not with DEVICE_ATTR, since I guess we could
easily write a new macro with one more attribute. The real thing is
wether the current architecture would let us have sysfs callback
routines with one extra argument, the value of which would depend on the
sysfs file. But I fear that there is no way to associate an extra value
to a sysfs file, nor to retrieve its name in the callback function, so
whatever we do, we'll still end up with two callback functions per sysfs
file.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
