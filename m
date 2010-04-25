From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 25 Apr 2010 17:02:29 +0000
Subject: Re: [lm-sensors] fancontrol EeePC,
Message-Id: <20100425190229.2d3e2ced@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <p2r64d6c631004250035lca8a4234o4787745b623460bb@mail.gmail.com>
In-Reply-To: <p2r64d6c631004250035lca8a4234o4787745b623460bb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mildred,

On Sun, 25 Apr 2010 16:55:09 +0200, Mildred Ki'Lya wrote:
> On 04/25/2010 01:21 PM, Jean Delvare wrote:
> > Hi Mildred,
> >
> > On Sun, 25 Apr 2010 09:35:58 +0200, Mildred Ki'Lya wrote:
> >   
> >> Hi,
> >>
> >> I am using fancontrol for my new EeePC, and when fancontrol exit (when I
> >> reboot for example) the fans are set to manual mode at full speed.
> >>
> >> Aparently, the source code of fancontrol first tries to set the fan to safe
> >> mode, and if it doesn't work, set it to manual at full speed. Apparently,
> >> the EeePC safe mode is the same as automatic mode. So when we write "0" to
> >> pwm1_enable, if we read it again, we'll see "2".
> >>     
> > This is a bug in the eeepc driver. If it doesn't support mode 0, it
> > should return -EINVAL when one tries to set it.
> >   
> 
> Well, I didn't think this was a bug, from what I read, mode 0
> corresponds to safe mode which is the automatic mode on the EeePC, and
> of course since this is the same as the mode 2 (automatic), when we read
> the file back we get 2.

Please read Documentation/hwmon/sysfs-interface. Mode 0 doesn't mean
"safe mode" (whatever that means to you), it means "fan at full speed".

> But you certainly know better about this, so I'm not pressing the issue
> further.
> 
> If I understand how fancontrol works, when the mode 0 doesn't work, it
> set the pwm to mnual mode (1) and maximum speed.

Correct. Both are almost equivalent (and for some chips, exactly
equivalent.)

> Do you think that is a
> good choice given that for some laptops where the default mode is the
> automatic mode (2) ? That would be a perfectly acceptable fallback when
> fancontrol isn't in charge.

We can't fallback to automatic mode by default because we have no
guarantee that this mode is properly configured.

> Do you think there is possibility in the future that fancontrol reset
> the fan state to automatic when it quits (when specified in the
> configuration) ? I'd be willing to work on a patch if that were the case.

One sensible change would be for fancontrol to restore the mode to what
it was when it was started. This should be the best option in all
cases, and fairly easy to implement, too. If you send a patch doing
this, I'll be happy to apply it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
