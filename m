From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 23 Jul 2013 10:58:14 +0000
Subject: Re: [lm-sensors] Few queries about lm-sensors and core temp.c
Message-Id: <20130723125814.71db0112@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <D137AD88-0DA4-4CF3-889D-862386B3C35A@brown.edu>
In-Reply-To: <D137AD88-0DA4-4CF3-889D-862386B3C35A@brown.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kapil, Guenter,

On Mon, 22 Jul 2013 02:27:56 -0700, Guenter Roeck wrote:
> On Sun, Jul 21, 2013 at 11:23:00PM -0400, Kapil Dev wrote:
> > I am using 2.6.39-020639-generic  kernel and I am running Ubuntu 9.04. I couldn't find /etc/sensors.d/coretemp.config file. I am using 3450S intel i5 processor, which has Tjmax of 103C (sorry for the typo in my original email), based on http://users.sosdg.org/~qiyong/lxr/source/Documentation/hwmon/coretemp?a=um . 
> > 
> > I found that for some processors, IA32_TEMPERATURE_TARGET MSR has the Tjmax value; I assume that the coretemp.c tries to read this register and if it doesn't succeed then, it uses the heuristic value. 
> 
> Might as well be that the kernel version is too old. Can you update to a more
> recent kernel ?

He doesn't have to update the whole kernel, just building an up-to-date
coretemp driver would do. I have made the kernel v3.10 version of the
coretemp driver available at:

  http://khali.linux-fr.org/devel/lm-sensors/drivers/coretemp/

Instructions at:

  http://khali.linux-fr.org/devel/lm-sensors/drivers/INSTALL

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
