From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Jan 2009 12:11:55 +0000
Subject: Re: [lm-sensors] Updated fancontrol script
Message-Id: <20090127131155.6b6df0c5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090102221548.GA19021@paradise.net.nz>
In-Reply-To: <20090102221548.GA19021@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 27 Jan 2009 23:40:41 +1300, Volker Kuhlmann wrote:
> Hi Jean,
> 
> > > I have updated my improved/extended fancontrol script with the changes
> > > from 0.63 to 0.67 of the "official" script. It's backwards compatible.
> > 
> > Someday we should get rid of these version numbers. Referring to the
> > version of the lm-sensors package is much easier IMHO.
> 
> No opinion, no difference to me... ;)
> 
> > > http://volker.top.geek.nz/linux/tech/lm_sensors/fancontrol-1.1
> 
> > If you want us to take anything from you, please send patches against
> > our latest version of fancontrol. Preferably incremental ones.
> 
> Sure, patch is easy:
> 
>   cp whatever-your-latest-version-is-cvs-or-stable fancontrol.orig
>   wget http://volker.top.geek.nz/linux/tech/lm_sensors/fancontrol-1.1
>   diff -u fancontrol.orig fancontrol-1.1
> 
> Adjust diff format to personal taste. However the resulting patch would
> be much bigger than either script by itself, so wouldn't really be that
> useful. I did quite a bit of tidying up.

That's not going to happen, sorry. If the changes are so important that
a patch wouldn't be readable then I don't have the time to take care of
this. Especially when I'm not even sure what is so great with your
version. Using bash string functions instead of external programs? The
latest version of fancontrol only uses one external program during
runtime, which is sleep, I doubt you managed to replace that. The other
external calls are only done during setup, and they are nothing a
standard Linux system always has, so I'm not sure why this would be
considered a problem. Changed some ugly programming? Please be
specific. I've done a lot of cleanups to fancontrol myself over the
past 2 years, and I believe I have managed to make it look reasonably
good. On top of that, we had a lot of weird issues where bash and/or
sysfs wouldn't behave the way you'd expected. Now that we have
something that apparently works fine for all users, I'm certainly not
going to replace fancontrol with a brand new version hardly anyone has
ever tested.

If you want your changes to be merged into lm-sensors, you really only
have 2 options:

* Split all your changes into incremental patches that can be easily
reviewed and commented upon, post them, wait for comments, adjust
accordingly (might include dropping changes which others don't like),
resend and we'll apply them.

* Volunteer to become the maintainer of pwmconfig and fancontrol for
the next 2 or 3 years. Get a developer account created, merge your
changes, and take care of all the user reports about pwmconfig and
fancontrol on the mailing list.

Both options require that you spend a significant amount of time.
That's what good software development is all about, isn't it?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
