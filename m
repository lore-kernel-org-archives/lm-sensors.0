From: james.oden@gmail.com (James Olin Oden)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [PATCH] Restore compatibility with 2.4 kernels
Message-Id: <ac921f9905030813305995afb3@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050308142854.GA31643@bode.aurel32.net>
In-Reply-To: <20050308142854.GA31643@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 8 Mar 2005 22:07:13 +0100, Jean Delvare <khali@linux-fr.org> wrote:
> Hi James,
> 
> > Well, I missed it too, but Dave Knierim (my partner in crime), noticed
> > this paragraph in Aurelian's email:
> >
> > --->list. It has the drawback to not allow an i2c transfer while
> > --->adding/removing a client or to not allow adding a new client during an
> > --->i2c transfer. I don't consider that as a problem, as adding/removing a
> >
> > That is what Dave noticed, which sounded like it would completely
> > remove the opportunity for someone to read the proc entries while the
> > driver was going away, and it seems to work.
> > But then I might have missed something .
> 
> Interesting, I had missed it myself. The original problem could indeed
> have a positive side effect. Some more notes however:
> 
> 1* If the two actions actually lock each other out, there is something
> wrong at an upper level. You should not possibly unload a driver that
> has running code. That the code is an i2c bus transfer or something else
> doesn't make any difference.
> 
So is the correct behavior that it should always return that the
device is busy if you try to unload while its still being used? 
Sounds reasonable, I was just wondering.

> 2* i2c 2.9.0 solved a number of problems but did not fix all race
> conditions. In particular, bus drivers maintain their usage count
> themselves, which should not be done. Unfortunately this will never be
> fixed, because it would break compatibility with the 2.4 kernel.
Warm fuzzies I'm not feeling.  Course, most of the time your not
loading and unloading drivers.  Its mainly when we unload drivers on
shutdown and we get a panic that causes us more concern.  We can,
though, not unload the drivers on shutdown...or we could try to make
sure the watchdog does not get disabled before we unload the drivers.

> 
> 3* There is also a known problem that sysctl/procfs access will increase
> the usage count of chip drivers but not bus drivers. Again this cannot
> be fixed without a significant architecture change, which we would
> prefer not to do. The "solution" is to always unload chip drivers before
> bus drivers.
> 
We do do that.  It just seems like the sane thing to do.

> On your recent oopses, were you only playing with chip drivers or also
> with bus driver? Frankly I am not surprised if you have oopses when
> cycling bus drivers with concurent procfs/sysctl accesses. I *am*
> surprised if you have oopses while only cycling chip drivers.
It was only chip drivers.  The three drivers, and usually only one at
a time were: lm93, lm87 and eeprom.   Now, when we first noticed that
the panics would still occur, it could have been with either. 
Basically, we would see the panics when we would either be rebooting
the box, and the drivers would be unloaded (which we can stop doing),
or when we are switching out versions of i2c/lm_sensors, and thus
unloading all the drivers.    But in these cases which were not
expected, we did not capture what exactly had been loaded or unloaded.
 For my testing today, though, the only things I have been loading and
unloading were those three chip drivers.

Thanks...james
> 
> --
> Jean Delvare
>
