From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: Sensor issues
Message-Id: <20041121224444.6bc4366e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY1-F23023F526DAAA27542A181C8C20@phx.gbl>
In-Reply-To: <BAY1-F23023F526DAAA27542A181C8C20@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> the issue I am having is there is lots of stuff pointing to kernel
> 2.4's procfs output, not 2.6's sysfs output. Since I have never worked
> with hardware health programs on linux, I have not real idea if the
> area's I am looking at are correct. The directory I found information
> ( I found two actually) is:
> 
> /sys/bus/i2c/drivers/via686a/0-6000
> and
> /sys/devices/platform/i2c-0/0-6000/

Yes, interface moved from /proc in 2.4 to /sys to 2.6. Anyway, programs
should never read the values from there as they are raw values which
sometimes requires some computation before they make sense. This is what
libsensors is for, and libsensors knows about both the /proc and the
/sys interfaces.

The data you may be be looking for are in /sys/bus/i2c/devices/* for 2.6
kernels. But again you shouldn't access them directly other than for
debugging purposes.

-- 
Jean Delvare
http://khali.linux-fr.org/
