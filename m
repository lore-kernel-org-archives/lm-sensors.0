From: Himanshu Chauhan <hschauhan@nulltrace.org>
Date: Thu, 06 Oct 2011 16:55:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon class driver registration with a
Message-Id: <20111006164300.GB5402@ubuntu.ubuntu-domain>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317834791-2803-1-git-send-email-hschauhan@nulltrace.org>
 <1317839407.3983.46.camel@groeck-laptop>
 <20111006040656.GA2125@ubuntu.ubuntu-domain>
 <20111006051955.GA22835@ericsson.com>
 <20111006094302.71ea4dfd@endymion.delvare>
 <1317914126.3983.55.camel@groeck-laptop>
In-Reply-To: <1317914126.3983.55.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Oct 06, 2011 at 08:15:26AM -0700, Guenter Roeck wrote:

> Having said that, I realize there are instances where the _minor_ device
> number is passed to the class registration function (eg for misc
> devices). In that case, though, misc_register() checks if the asked for
> minor device already exists, and retains the option to generate a
> dynamic minor device. This is different here, where the proposal is to
> pass both major and minor device number to the registration function.
> 
> Maybe there are instances where both major and minor device number are
> passed; as I mentioned before, I did not spend that much time on it. But
> you are right - that isn't the point anyway.
> 

If misc and other classes can create nodes based on device numbers that
are passed to them, why is it a problem for hwmon? Why does hwmon creates
devices with MKDEV(0,0)? I am still not getting the point.

-Himanshu

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
