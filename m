From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 14 Jan 2009 18:44:10 +0000
Subject: Re: [lm-sensors] sensord with rrd
Message-Id: <20090114194410.3542e52b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <gkimcg$46k$1@ger.gmane.org>
In-Reply-To: <gkimcg$46k$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Wed, 14 Jan 2009 09:57:00 -0800, Mark Nienberg wrote:
> Jean Delvare wrote:
> > No, it should work. That being said, where do you put these values? We
> > do not have such an setup script for sensord. So please tell us:
> > * What version of lm-sensors you're using.
> > * Which distribution you are using.
> > 
> > And attach (or point us to) a copy of the initialization script which
> > is reading the variables you listed above.
> 
> [root@gecko ~]# rpm -q lm_sensors sensord
> lm_sensors-2.10.6-55.el5
> sensord-2.10.6-55.el5

This is somewhat old...

> installed from atrpms on CentOS 5.2 x86_64.
> 
> But I should add that the sensord init script in the rpm package seemed wrong to me 
> so I replaced it with one I copied from a fedora 7 install.  This one just checks 
> that lm_sensors is already running, which should insure that the correct modules are 
> loaded. The other one was very old (from redhat 7.2) and actually tried to load 
> modules. Here is the one I am using:
> (...)
> And here is the file /etc/sysconfig/sensord, which is included into above:
> 
> # configuration for hardware sensors monitoring daemon
> # in intervals use suffix "m" for minutes, "s" for seconds, "h" for hours
> # 0 means turning facility off
> 
> # interval between scanning alarms
> INTERVAL=0
> 
> # interval between logging to syslog
> LOG_INTERVAL0m
> 
> # interval between RRD logging
> #RRD_INTERVAL0m
> 
> # RRD db location
> #RRD_LOGFILE=/var/log/sensors.rrd

What hardware monitoring chip do you have? sensord in lm-sensors 2.10.x
lacks support for many recent chips. Could be that logging works
somewhat in generic mode but rrd supports need chip-specific support.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
