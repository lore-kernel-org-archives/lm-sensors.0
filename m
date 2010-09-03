From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 03 Sep 2010 14:31:36 +0000
Subject: Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
Message-Id: <1283524296.9850.69.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <929339.59525.qm@web50002.mail.re2.yahoo.com>
In-Reply-To: <929339.59525.qm@web50002.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2010-09-01 at 12:57 -0400, Mahmood Naderan wrote:
> >  sudo aptitude reinstall lm-sensors
> 
> That didn't work. So I managed to completely remove lm-sensors with
> "sudo apt-get --purge remove lm-sensors".
> 
Did you re-install it afterwards ?

[...]

> 
> As you see, core-i7 is detected. Also it says: "Copy
> prog/init/lm_sensors.init to /etc/init.d/lm_sensors
> for initialization at boot time." I did that. 

It would have been better to stick with the script from the Ubuntu
distribution (/etc/init.d/lm-sensors). The one you copied likely won't
work.

sudo /etc/init.d/lm-sensors restart would then restart the service.

Guenter




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
