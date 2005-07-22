From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Fri, 22 Jul 2005 02:47:32 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.13-rc3 0/3] hwmon: hwmon sysfs class
Message-Id: <253818670507211745688a4a05@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050716013537.GA4265@jupiter.solarsys.private>
In-Reply-To: <20050716013537.GA4265@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Mark,

I'm a bit confused on the current state of hwmon, was the latest patch
accepted anywhere? Aside from ipmisensors (which is blocked on other
work anyway) I'm looking into adding a sysfs/hwmon interface to the
new hdaps driver (see http://hdaps.sourceforge.net/), any opinions?

It would probably mean adding two new classes of sensor types,
acceleration and 'variation' types. The hdaps driver is not the only
driver out there that could use these though, I believe some
powerbooks and other notebooks have a similair system (see
http://www.kernelthread.com/software/ams/).

Thanks,
Yani

On 7/16/05, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Greg,
> 
> Quoting Mark M. Hoffman:
> > Here is the patchset that adds the hwmon sysfs class.  It is refreshed
> > against 2.6.13-rc3, which required no changes since my last RFC.
> 
> I did review these three patches and do support them. Feel free to add:
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> before your own. Maybe we can even have a "Dedicated-to: Celia" line for
> these ones? :)
> 
> Thanks,
> --
> Jean Delvare
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
