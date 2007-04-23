From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Apr 2007 05:38:23 +0000
Subject: Re: [lm-sensors] asb_100 sensor location in /sys heirarchy changes
Message-Id: <20070423073823.0161bf85@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4615F494.6070403@hhs.nl>
In-Reply-To: <4615F494.6070403@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jeff,

On Thu, 19 Apr 2007 14:50:51 -0400, Jeffrey J. Kosowsky wrote:
> Jean Delvare wrote at about 20:35:55 +0200 on Thursday, April 19, 2007:
>  > > NOTE: you may also need/want to update the copyright portion but I am
>  > > not sure what the right way to do it is...
>  > 
>  > Well that's really up to you, you're the one working on updating this
>  > script.
> 
> I meant just that I don't know what the 'legal' or 'ethical' way
> is. Do I just add the new years? Do I leave it alone? Do I add my name
> (or others) if I end up making real changes? I just want to do the
> right thing.

You can't touch other people's copyright, so just adding a year isn't
possible. You can either leave it untouched (as is now) or add your
own name with the new year. If you want to do that, just send a patch.

>  > > -RRDPATH=/usr/local/rrdtool/bin
>  > > +RRDPATH=/usr/bin
>  > 
>  > While I agree that the original value didn't make much sense, shouldn't
>  > we simply rely on the $PATH to find the rrdtool binary instead of
>  > hard-coding a directory? Also, this change should be reflected in the
>  > Makefile and README files, and in the sens_create_rrd script, otherwise
>  > it is inconsistent.
> 
> I agree. The hardcoding of paths rather than either using $PATH or
> setting the variables in the Makefile is a huge PITA. It means that I
> end up needing to add 'patch' files to patch the source when I build
> my own rpms vs. just changing the inputs to 'make' or using some other
> automated way of finding the binaries.

For now, I've updated the version in the 3.0.0 branch (for 2.6.14+
kernels) to use /usr/bin for rrd binaries by default, as you had
suggested.

I've also updated all the other files in the directory to reflect the
changes we made:
http://www.lm-sensors.org/changeset/4372
So it should be better now.

I even gave a try to this set of patches, to make sure I didn't break
anything. The least I can say is that it wasn't easy. Typical web
server installations expect you to put all your CGI programs in a
specific directory, and our scripts aren't compatible with this model,
so I had to edit them. I also noticed that the HTML code isn't exactly
state-of-the-art. Lots of cleanups would be needed to make it valid
HTML. And on top of that, I would have had to edit all the scripts to
change the inputs labels, disable some inputs and edit the scaling
factors, while I have a perfect board-specific sensors.conf file
already.

So while the resulting graphs look good (except the color... pink
graphs by default?!) I don't really expect that many users to go far
enough and actually use these scripts.

You are right that the user should be able to set up everything in the
Makefile. I wonder why the CGI scripts have their variables substituted
at build time, and the two shell scripts don't. The two shell scripts
should be provided as .in files, and "built" (variable substitution)
the same way. Want to give it a try (on the 3.0.0 branch)?

>  > /sys/class/hwmon is indeed not mentioned anywhere in the manual pages.
>  > But /sys/bus/i2c/devices is not mentioned either, so how did you get
>  > there? It looks to me like the primary cause of your problem is that
>  > the code itself was outdated. Now that you fixed that, it should be
>  > fine.
>  > 
>  > These sysfs interfaces should normally always be accessed through
>  > libsensors and not directly, so I don't think we really want to
>  > document them in manual pages, other than, maybe, the FILES section of
>  > libsensors.3 (which doesn't exist yet.)
> 
> OK. I don't know a lot about libsensors.
> Is there any interface that would give you command line access to
> libsensors. I know that you could always try to parse the output of
> 'sensors' but it might be nice to have more granular command line
> access that would provide much of the same functionality as the
> libsensors C-routines. If so, then scripts like sens_update.rrd could
> just call those functions and you never would have to worry about the
> /sys or /proc filesystem mechanics.

We could have a separate binary, but the best approach would be
additional command line parameters to "sensors", so that we can:
* retrieve the list of non-ignored inputs (name and type)
* query the converted value of a specific input
We don't have that at the moment, but it should be possible to add this
on top of the changes that are being made to the future version of
libsensors these days. Once we have that, writing scripts for sensors
stuff should be much more friendly.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
