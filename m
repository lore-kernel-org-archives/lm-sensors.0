From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Feb 2009 13:31:40 +0000
Subject: Re: [lm-sensors] [Patch] libsensors: Ignore directories and
Message-Id: <20090205143140.27d600ef@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090205090331.GA5150@ubuntu>
In-Reply-To: <20090205090331.GA5150@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andre,

On Thu, 5 Feb 2009 11:45:36 +0100, Andre Prendel wrote:
> On Thu, Feb 05, 2009 at 10:53:34AM +0100, Jean Delvare wrote:
> > On Thu, 5 Feb 2009 10:03:31 +0100, Andre Prendel wrote:
> > > I assume there are no hidden files in the directory, right? That's the
> > > reason why I have removed this from condition.
> > 
> > I've never seen hidden files in sysfs except for sections
> > in /sys/module. But the purpose of the original code was merely to skip
> > "." and ".." anyway, not hidden files.
> 
> At another place (sysfs_foreach_classdev()) there is a comment
> explaining the condition.
> 
> [...]
>       if (ent->d_name[0] = '.')      /* skip hidden entries */
>                         continue;
> [...]

Indeed, but as I recall, the hidden entries we were worried about
back then were just "." and "..". I don't expect it to make any
difference anyway, as I doubt we'll ever have other hidden files or
directories in class directories, nor do I expect non-directory (or
link to directory) entries there.

> > (...)
> > If you really care about performance (and I guess that's the sole
> > purpose of your patch) then it's faster to check for ent->d_type !> > DT_REG.
> 
> Indeed. That's even better.
> 
> > You can also move "name = ent->d_name" after this test to make
> > the fast path even faster.
> 
> This should just avoid needless work and maybe potential errors in
> parsing unexpected directory names.

I get the idea, and second it.

> > Out of curiosity, did you actually measure any performance improvement
> > with your patch?
> 
> I didn't do a measurement. That wasn't the goal.

You might want to ask valgrind about it (I certainly will, being
curious.)

> P.S. To become familiar with the whole code and getting a better
> understanding how things work, I walk through the code. And if I found
> something that I would do in a different way, I send a patch to you :)

Sounds like a good plan, don't stop :)

Care to send an updated patch? I'll be happy to apply it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
