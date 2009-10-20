From: Simon Wilson <simon@simonandkate.net>
Date: Tue, 20 Oct 2009 01:12:46 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <20091020111246.479225034bal50ge@mail.simonandkate.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Adam Nielsen <a.nielsen@shikadi.net>:

>> Setting /sys/class/hwmon/hwmon0/device/vrm to 100 instead of 110 "fixes"
>> this issue. Or I should say, it means I get a value - 1.088 V - at VID.
>> Whether it is right or not... ?
>
> I suspect it is wrong - I was looking at this issue this morning and the
> Core2 CPUs are correctly listed in the hwmon-vid driver and I too get a
> vrm value of 110 which is correct for my CPU.  Setting a different vrm
> value causes a different formula to be used when calculating the voltage.
>
> I was wondering whether the VID lines aren't actually connected to the
> it87 chip, but it looks like they are, just not all of them.
>
> It looks like (if that's correct) the only option is to hack hwmon-vid
> to use less VID pins or something to get the correct value out.
>

hwmon-vid.h on my box contains (intro comments excluded for brevity):

#ifndef _LINUX_HWMON_VID_H
#define _LINUX_HWMON_VID_H

int vid_from_reg(int val, u8 vrm);
u8 vid_which_vrm(void);

/* vrm is the VRM/VRD document version multiplied by 10.
    val is in mV to avoid floating point in the kernel.
    Returned value is the 4-, 5- or 6-bit VID code.
    Note that only VRM 9.x is supported for now. */
static inline int vid_to_reg(int val, u8 vrm)
{
         switch (vrm) {
         case 91:                /* VRM 9.1 */
         case 90:                /* VRM 9.0 */
                 return ((val >= 1100) && (val <= 1850) ?
                         ((18499 - val * 10) / 25 + 5) / 10 : -1);
         default:
                 return -1;
         }
}

#endif /* _LINUX_HWMON_VID_H */


The file is dated Sept 20 2006. I suspect this may be the issue...  
there is nothing in there for VRM 10 or 11. It would appear that I  
need a later hwmon-vid driver? Or am I completely on the wrong track  
there LOL...

As you say, the info is definitely there to be read - according to  
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-October/024581.html the  
IT8718F does have VID info, but it is stored differently:

"The IT8718F and IT8720F also features VID inputs (up to 8 pins) but  
the value is stored in the Super-I/O configuration space. Due to  
technical limitations, this value can currently only be read once at  
initialization time, so the driver won't notice and report changes in  
the VID value. The two upper VID bits share their pins with voltage  
inputs (in5 and in6) so you can't have both on a given board."

Simon.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
