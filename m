From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 03 Mar 2015 09:26:22 +0000
Subject: Re: [lm-sensors] Patch and Upstart file for healthd.sh
Message-Id: <20150303102622.46d35d00@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150226233151.GA17731@alpha.somenet.pw>
In-Reply-To: <20150226233151.GA17731@alpha.somenet.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 28 Feb 2015 15:45:41 +0100, Jean Delvare wrote:
> On Sat, 28 Feb 2015 11:00:33 +0100, Jean Delvare wrote:
> > On Fri, 27 Feb 2015 02:31:52 +0300, vbooh wrote:
> > > A patch is for a decreasing of the resource consumption by healthd.sh; it replaces the external commands with the built-in Bash commands. It did not make a huge difference, but it was still useful in my case.
> > 
> > This is a sane goal, in fact we did similar changes to fancontrol some
> > times ago for the same reason. Patch committed, thanks for your
> > contribution. The read trick is very nice, I didn't know about it, I'll
> > probably do the same in fancontrol as well as the current
> > implementation was reported to cause problems.
> 
> Err, did you check the CPU consumption after applying your changes? I
> did similar changes to fancontrol and it results in an increased CPU
> consumption (37% of one CPU, compared to 0.3% before the changes) when
> fancontrol is started as a daemon by systemd. Strangely I do not
> observe this when running the script manually. I suppose "read" is
> angry if stdin is closed :(

I reverted to using regular sleep calls. However bash has optional
builtin functions which can be loaded dynamically, and sleep is one of
them. So we can try to load it if it is available, which should solve
your problem. On openSUSE it is available in package bash-loadables, I
don't know if other distributions package it or not.

The patch is here:
http://www.lm-sensors.org/changeset/6275

If you care about minor performance optimizations, you may also be
interested in this cleanup:
http://www.lm-sensors.org/changeset/6276

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
