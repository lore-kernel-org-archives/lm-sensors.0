From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 21 Oct 2007 21:12:43 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20071021231243.5b9c31cb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans,

On Sun, 21 Oct 2007 21:13:35 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > How do you deal with the case where both libsensors.so.3 and
> > libsensors.so.4 are available at link time?
> 
> Well -lsensors will search for libsensors.so, which is a symlink to one of the 
> two, I would expect this symlink to point to the same version as 
> /usr/include/sensors/sensors.h is.

Ah, OK. I didn't realize this before, thanks for the clarification.

I somehow expected / hoped that it was possible to explicitly point ld
to a specific .so version, but apparently this isn't the case.

> When talking distros, the symlinks usually reside in the -devel package. One 
> can then make either the 2 -devel pakcages conflict, or put the symlink in a 
> subdir of /usr/lib[64] and have a pkg-config file (which are usually versioned) 
> and use pkg-config to add the correct -L/..... path to the LD_FLAGS.
> 
> This (symlinks in subdirs of /usr/lib, pkg-config) is how many libraries which 
> are designed for parallel installs do it. In the case of lm_sensors the plan 
> for Feodra is to switch to libsensors4 and just patch all users to move to the 
> new API, I much rather spend some time writing patches for libsensors using 
> apps, then spend time to make the 2 parallel installable. Also notice that as 
> the 2 are inherently not paralell installable as the both want to install 
> /usr/include/sensors/sensors.h

I'm interested in this because in openSuse, there's currently no
separate devel package for sensors. I plan to make one before moving to
3.0.0, so I need to learn how this is supposed to work.

I also don't plan to make both devel packages installable in parallel,
it's not worth the effort.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
