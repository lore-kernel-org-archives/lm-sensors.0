From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 Jul 2007 12:09:37 +0000
Subject: Re: [lm-sensors] Help wanted: individual alarm files
Message-Id: <20070707140937.301119b1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070701220005.1dda9d8f@hyperion.delvare>
In-Reply-To: <20070701220005.1dda9d8f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gong Jun,

On Thu, 5 Jul 2007 19:27:40 +0800, JGong@winbond.com wrote:
> >The future libsensors assumes that all hardware monitoring drivers
> >follow the standard sysfs interface defined in
> >Documentation/hwmon/sysfs-interface. They all mostly do already, except
> >for one thing: alarms. Most drivers are still only exposing a single
> >file with all alarms in a bit-vector, in chip-dependent order. In order
> >to let the new libsenors display the alarms properly, we must add
> >individual alarm files to these drivers. For some drivers, fault and/or
> >beep files need to be added too.
> 
> I'd like to take care of w83792d chip's converting work. It will be
> finished in the next week.

Great, thanks!

> And could you please give me some information about the ASUS motherboard
> with w83791d chip using for hardware monitor function? 
> 
> Any help will be welcome.

I don't know, sorry. The only system I know using a W83791D is the Acer
Altos R300 server. Charles Spirakis (Cc'd) wrote the Linux 2.6 w83791d
driver, he should be able to tell you which system he was using.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
