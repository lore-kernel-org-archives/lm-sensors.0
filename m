From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: sysfs names
Message-Id: <20040214100350.215aa589.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040126230447.09700886.khali@linux-fr.org>
In-Reply-To: <20040126230447.09700886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It'd be nice if the driver could provide a parameter to the
> sysfs show() and store() routines... i.e.
> 
> static ssize_t show_temp(struct device *dev, char *buf, int param);
> 
> DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 1)
> DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 2)
> DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 3)

Much like what we had in 2.4. And this was Good.

> .. and so on.  Then we could end the blizzard of tiny helper
> functions and the macro abuse.  Try 'nm --size-sort w83781d.o'
> some time for an illustration.

Oh well, I didn't need nm to tell me what of a mess it is inside.
Looking at the code was enough. When you come to use macros to define
functions, there *must* be something wrong in your code design.

> But, I can't see a way to do this without forcing a massive
> rewrite of all sysfs-enabled drivers - oh well.

Sad but probably true. Still I'd like to hear Greg about what it would
take to do so, and if there is a chance that this happens in 2.7.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
