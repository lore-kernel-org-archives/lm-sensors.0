From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Dec 2007 13:13:40 +0000
Subject: Re: [lm-sensors] sensors-detect: unecessary suggested change to
Message-Id: <20071218141340.16bd7d95@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071217000316.GA27938@intrepid.com>
In-Reply-To: <20071217000316.GA27938@intrepid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gary,

On Sun, 16 Dec 2007 16:03:16 -0800, Gary Funck wrote:
> sensors-detect, prints the following:
> 
>     To load everything that is needed, add this to some /etc/rc* file:
> 
>     #----cut here----
>     # Chip drivers
>     modprobe w83627hf
>     # sleep 2 # optional
>     /usr/bin/sensors -s # recommended
>     #----cut here----
> 
>     If you have some drivers built into your kernel, the list above will
>     contain too many modules. Skip the appropriate ones! You really
>     should try these commands right now to make sure everything is
>     working properly. Monitoring programs won't work until the needed
>     modules are loaded.
> 
>     Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
> 
> But if the user replies 'yes' above, then appropriate
> module name is written into /etc/sysconfig/lm_sensors,
> _and_ /etc/init.d/lm_sensors will run the 'sensors -s'
> command when lm_sensors starts up.
> 
> Suggestion: just print the module(s) that need to be loaded,
> and if the user replies 'yes', take no further action.

Agreed. I wanted to do that some times ago already, but could never
find the time. This is done now, please give a try to the SVN version
of sensors-detect and let me know what you think about it:
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt

> Otherwise, print the suggestion to add the needed lines to an
> /etc/rc* file.  Also, it would be helpful to suggest the
> conventional name (such as /etc/rc.local) for the 'rc' file.

Assuming that you really meant /etc/rc.d/rc.local, I've done that too.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
