From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 03 Dec 2012 08:34:32 +0000
Subject: Re: [lm-sensors] Fancontrol for intel HM77
Message-Id: <20121203093432.1b40b877@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121128120329.GA3502@pegasus.localdomain>
In-Reply-To: <20121128120329.GA3502@pegasus.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fred,

Please keep the list in the loop, and don't top-post.

On Fri, 30 Nov 2012 18:58:30 +0100, Fred Grosskopf wrote:
> I enabled the compal-laptop kernel config flag. Sill no success,
> sensors-detect produces the same result. :-(
> 
> Thanks for the hint though.

If you build compal-laptop as a module, did you check (with lsmod) that
it is really loaded? Anyway it won't change the result of
sensors-detect, which doesn't know about this module. But it could
change the output of "sensors" and "pwmconfig".

As I said before, if it doesn't change the output of "sensors", it
means the driver doesn't support your laptop model. Could be because
your kernel is old (you didn't tell us your kernel version) or your
laptop is too recent and/or not compatible with the driver. Actually I
can't see your model name in the supported table in the the driver
source code. The driver most certainly complains about that when
loaded, check in the kernel logs and let us know what it says. You may
have to load the driver with force=1 (at your own risk, obviously.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
