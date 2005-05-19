From: reg@dwf.com (Reg Clemens)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: 2.8.7 doesnt see sensors on my machine.
Message-Id: <200406262003.i5QK3C7j004197@orion.dwf.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406190250.i5J2oDgJ005370@orion.dwf.com>
In-Reply-To: <200406190250.i5J2oDgJ005370@orion.dwf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi Reg,
> 
> > Sorry if there is a mailing list where this should be discussed, but
> > I didnt see any reference on one on the WEB page.
> 
> This *is* the mailing list. I edited the web page to make it more clean
> just yesterday. I may edit it further if that's not enough.
> 
> > On my machine, with a 2.4.x kernel I saw minimal information from
> > LM-SENSORS(voltages, temperatures).
> > 
> > on the same machine with a 2.6.7 (and some previous,- probably all)
> > kernel, prog/detect/sensors-detect says 'no sensors detected' as does
> > running sensors.
> > 
> > However, if I load the two modules that I used to (in my 
> > /etc/sysconfig/lm_sensors), namely i2c-viapro and w83781d, then
> > 'sensors' gives output equivalent to running under 2.4.x
> > 
> > In any case thought you would like the report, if I can provide any
> > additional useful information, let me know.
> 
> Interesting case for sure. Could you please provide the full output of
> sensors-detect (after unloading any i2c driver) with the 2.6 kernel, and
> with the 2.4 as well if possible?
> 
> Thanks.
> 

Sorry for the delay in getting back to you, but its been a bad week.
This AM I tried the experiment on RH8, RH9 and Fedora2, and found that
my previous experiment was bogus.  If I use a kernel that has enough
modules compiled then it does indeed, in Fedora2 see my sensors.

I REALLY thought that when I built a new kernel that I had put all the
I2C stuff in, but Ill have to go back and look.

Case (almost) closed.

I did find that in the startup script for init.d there is some logic 
looking for sensors in /proc, viz

### If sensors isn't supported by the kernel, try loading the module...
###
### [ -e /proc/sys/dev/sensors ] || /sbin/modprobe i2c-proc &>/dev/null
###
### # Don't bother if /proc/sensors still doesn't exist, kernel doesn't have
### # support for sensors.
### [ -e /proc/sys/dev/sensors ] || exit 0
###
### # If sensors was not already running, unload the module...

and I have had to comment this section out. 
There is nothing I can do that seems to make /proc/sys/dev/sensors appear
in the 2.6.6 kernel.  In particular, the 'modprobe i2c-proc' fails since
the module is not found in the distributed kernel vmlinuz-2.6.6-1.435
again, mabe this is something that needs to be turned on (I dont have
time to look right now) but 'sensor' seems to work fine without it.



-- 
                                        Reg.Clemens
                                        reg@dwf.com

