From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.2-rc2
Message-Id: <20040130033853.GG992@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040127233242.GA28891@kroah.com> <20040129004402.GC5830@werewolf.able.es> <1075365845.4018c7d5353d7@imp.gcu.info> <20040129222135.GC5768@werewolf.able.es> <20040129225659.GA11872@werewolf.able.es>
In-Reply-To: <20040129225659.GA11872@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

* J.A. Magallon <jamagallon@able.es> [2004-01-29 23:56:59 +0100]:
> 
> On 2004.01.29, J.A. Magallon wrote:
> > 
> > werewolf:~# sensors
> > w83781d-isa-0290
> > Adapter: ISA adapter
> > VCore 1:   +1.97 V  (min =  +1.90 V, max =  +2.10 V)              
> > VCore 2:   +2.02 V  (min =  +1.90 V, max =  +2.10 V)              
> > +3.3V:     +3.23 V  (min =  +3.14 V, max =  +3.46 V)              
> > +5V:       +4.97 V  (min =  +4.73 V, max =  +5.24 V)              
> > +12V:     +12.04 V  (min = +11.37 V, max = +12.59 V)    
> 
> Oops, not so good:
>           
> > -12V:     -12.18 V  (min = -12.57 V, max = -11.35 V)       ALARM  
> > -5V:       -4.96 V  (min =  -5.25 V, max =  -4.74 V)       ALARM  
> 
> Why ALARM ?

The alarm indicator is "sticky".  Even though the present
readings are within limits, the alarm says that the voltage
moved outside its limit since the last time you ran sensors.

Trying running sensors 5 times, at 2 second intervals.  If
the voltage always stays within the limits but the alarm
is not cleared, then maybe there is a problem with the
driver.  If that's the case, please follow up on the sensors
mailing list.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
