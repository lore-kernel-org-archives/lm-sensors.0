From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 14 May 2012 05:42:48 +0000
Subject: Re: [lm-sensors] Supermicro X7SPA-HF: in4 ALARM
Message-Id: <20120514074248.54cbdccc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <01fa01cd1430$fed0b990$fc722cb0$@lucidpixels.com>
In-Reply-To: <01fa01cd1430$fed0b990$fc722cb0$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 13 May 2012 18:57:36 -0500, Ben Kamen wrote:
> Ok, after looking around some more -- I should be talking though ipmisensors and not directly communicating with the w83627ehf directly.
> 
> it finds the ipmi interface:
> 
> > Found `IPMI BMC KCS' at 0xca2...                            Success!
> >     (confidence 8, driver `ipmisensors')
> >
> 
> but then tells me:
> > Warning: the required module ipmisensors is not currently installed
> > on your system. If it is built into the kernel then it's OK.
> > Otherwise, check http://www.lm-sensors.org/wiki/Devices for
> > driver availability.
> 
> and I'm using the RHEL 6 released version of lm-sensors:
> 
> lm_sensors.x86_64	3.1.1-10.el6	@base
> 
> 
> So where do I get ipmisensors?

It doesn't actually exist. Driver was work in progress, development
stopped in 2006.

> The wiki says I should use ipmitool -- but then how does that integrate?

It does not integrate. I would agree it's a sad situation but as long
as nobody finishes driver ipmisensors and gets it accepted upstream,
that's the best we (you) have.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
