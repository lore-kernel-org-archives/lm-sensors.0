From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 20 Sep 2009 19:16:20 +0000
Subject: Re: [lm-sensors] coretemp support for Core i5 CPU
Message-Id: <20090920211620.1c18d7fb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AB5DE1F.1020004@gmail.com>
In-Reply-To: <4AB5DE1F.1020004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Hi Robert,

On Sun, 20 Sep 2009 01:47:43 -0600, Robert Hancock wrote:
> Trying to load the coretemp driver for CPU temperature monitoring on a 
> Core i5 750 CPU gives:
> 
> coretemp: Unknown CPU model 1e
> coretemp: Unknown CPU model 1e
> coretemp: Unknown CPU model 1e
> coretemp: Unknown CPU model 1e
> 
> Looks like this model needs to be added to the list in 
> drivers/hwmon/coretemp.c. Though this doesn't really seem like a very 
> good approach as we'll keep having to update this driver whenever a new 
> CPU model gets released. Intel has a CPUID field that indicates if the 
> thermal sensor is supported: "The processor supports a digital thermal 
> sensor if CPUID.06H.EAX[0] = 1." We should likely be using this instead 
> of hard-coded CPU model checks..

Supporting the digital thermal sensor is one thing, but it is totally
insufficient. If you look at the coretemp driver, you'll see we need to
figure out a number of calibration values which are model-dependent. So
we will need to check this part before adding support for new CPU
models anyway.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
