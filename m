From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2c patch out of 2.6.4-rc1-mm1
Message-Id: <20040301195207.3a2f7d79.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1078150396.404344fc41690@imp.gcu.info>
In-Reply-To: <1078150396.404344fc41690@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I just saw that the i2c stuff from Greg's tree have been backed out
> > from 2.6.4-rc1-mm1. Quoting the release notes:
> > 
> > "bk-i2c.patch was dropped pending it getting its lmsensors act
> > together."
> > 
> > I don't quite understand what I am (well, what we are...) supposed
> > to do (actually, I do not even get the meaning of the sentence
> > itself). I clearly exposed my reasons for an interface change and as
> > far as I know, nobody objected to that particular point.
> 
> The problem is that there is no way a user can get a working
> libsensors to work with the -mm kernel right now, correct?

Not quite. The necessary patches are available on my personal server, as
advertised here:
http://marc.theaimsgroup.com/?l=linux-kernel&m7787111318197

Maybe the address should have been advertised more. I was a bit
surprised that the changes went into Andrew's tree for testing (although
I now understand and agree that it was the right thing to do) and we
suddenly had to support two incompatible trees with one single CVS
repository.

I thought we wanted to have our CVS repository always compatible with
the latest Linus' tree, this is why I had not commited the sysfs
interface change yet. And also because I did not want to "force" the
kernel patch to be accepted.

> I thought you were going to make a new release for the 2.6.3 kernel, and then
> commit your changes to cvs to allow users running the -mm tree to use
> that version.
> 
> Is this the case?

To the light of today's "incident", we should have been (remember I was
in favor of a release from the beginning). Now that Linux 2.6.4-rc1 is
out, releasing now is a bit odd (since we would more likely have to
release again within a week or so). So the 2.8.5 release of lm_sensors
will be for Linux 2.6.4. Linux 2.6.3 will be unsupported (only affects
w83l785ts users).

Anyway...

Is it correct to provide the libsensors update as patches for mm kernel
users (more publicly advertised, granted), or is it necessary to commit
them to our CVS repository?

I admit that I usually don't much like setting things up for temporary
situations, but it looks like this is how you kernel folks expect things
to be done...

Let me know how you expect us to give people access to a mm compatible
version of lm_sensors (basically: CVS or patches?) and we'll do juste
that.

Thanks and sorry for the trouble.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
