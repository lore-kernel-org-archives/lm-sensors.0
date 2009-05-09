From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 09 May 2009 11:43:19 +0000
Subject: Re: [lm-sensors] fancontrol
Message-Id: <20090509134319.49803f3c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1122217880.3578.8.camel@localhost.localdomain>
In-Reply-To: <1122217880.3578.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sergio,

Sorry for the late answer, this one felt under the radar.

On Fri, 27 Mar 2009 19:30:49 +0300, sergio wrote:
> >> force_load is function for initramfs-tools hook script...
> > That's kind of a misnomer, as it isn't forcing anything.
> May be, you can suggest the better name?
>  > It just load the driver early.
> Yes.

"load_early" would seem like a reasonable name then.

> > Also, to be truly useful for users, the possibility to use absolute
> > paths should be used by the pwmconfig script, by following and
> > resolving the device link of hwmon class devices before writing the
> > configuration file. Care to give it a try?
>
> I know. This fix is very simple and quick.
> Path mixing and pwmconfig is not so easy to fix.
> But not only paths should be reworked. Pid file is hardcoded.

Didn't seem to cause trouble to anyone so far.

> Egrep is deprecated.

Didn't know that. Replacing all instances of "egrep" with "grep -E"
should fix it, shouldn't it?

> Configuration file is not very simple.

It's both too simple from a syntax perspective, and too hard to read
and inflexible as a result, I agree :(

> Maybe it is the right 
> time to rework whole fancontrol and pwmconfig. Or it will be better to 
> save time for write new daemon. I can't find any suitable one of some 
> which can be extended.

This is your time, feel free to spend it any way you like ;)

I've applied your patch, thanks for your contribution.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
