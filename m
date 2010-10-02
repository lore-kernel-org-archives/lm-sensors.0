From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 02 Oct 2010 00:03:48 +0000
Subject: Re: [lm-sensors] [1/2] lis3: Add device owner
Message-Id: <20101002000348.GB25276@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ee6b20c71d49b8438ced798a9e561dbbd2991cf6.1282647258.git.ext-yuri.kululin@nokia.com>
 <20100924202404.GA20813@ericsson.com>
 <4CA1ACC3.4000809@nokia.com>
In-Reply-To: <4CA1ACC3.4000809@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yuri Kululin <ext-yuri.kululin@nokia.com>
Cc: Yuri Ershov <ext-yuri.ershov@nokia.com>, "eric.piel@tremplin-utc.net" <eric.piel@tremplin-utc.net>, "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "daniel@caiaq.de" <daniel@caiaq.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Sep 28, 2010 at 04:52:19AM -0400, Yuri Kululin wrote:
[ ... ]
> 
> > On a higher level, reassigning the owner like this seems to be quite uncommon,
> > at least in hwmon. I would like to see an Acked-by from Eric to ensure
> > that the fix is correct.
> 
> I tried to use the standard way of module usage control because all functions 
> provided by lis3lv02d_i2c.c, lis3lv02d_spi.c or hp_accel.c can be called through 
>   lis3lv02d_misc_fops file ops or joystick poll device.
> 
> I can propose another solution. We can use try_module_get(owner) during device 
> registration (in lis3lv02d_add_fs()), release module by using module_put(owner) 
>   after device unregister (in lis3lv02d_remove_fs()) and do not touch 
> lis3lv02d_misc_fops. But anyway dev->owner should be set.
> 
Key is really to get feedback from others, since I am neither familiar
with module ownership handling nor with this driver.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
