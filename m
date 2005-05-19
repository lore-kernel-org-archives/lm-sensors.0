From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [PATCH] Restore compatibility with 2.4 kernels
Message-Id: <20050308220713.027d6048.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050308142854.GA31643@bode.aurel32.net>
In-Reply-To: <20050308142854.GA31643@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi James,

> Well, I missed it too, but Dave Knierim (my partner in crime), noticed
> this paragraph in Aurelian's email:
> 
> --->list. It has the drawback to not allow an i2c transfer while
> --->adding/removing a client or to not allow adding a new client during an
> --->i2c transfer. I don't consider that as a problem, as adding/removing a
>
> That is what Dave noticed, which sounded like it would completely
> remove the opportunity for someone to read the proc entries while the
> driver was going away, and it seems to work.
> But then I might have missed something .

Interesting, I had missed it myself. The original problem could indeed
have a positive side effect. Some more notes however:

1* If the two actions actually lock each other out, there is something
wrong at an upper level. You should not possibly unload a driver that
has running code. That the code is an i2c bus transfer or something else
doesn't make any difference.

2* i2c 2.9.0 solved a number of problems but did not fix all race
conditions. In particular, bus drivers maintain their usage count
themselves, which should not be done. Unfortunately this will never be
fixed, because it would break compatibility with the 2.4 kernel.

3* There is also a known problem that sysctl/procfs access will increase
the usage count of chip drivers but not bus drivers. Again this cannot
be fixed without a significant architecture change, which we would
prefer not to do. The "solution" is to always unload chip drivers before
bus drivers.

On your recent oopses, were you only playing with chip drivers or also
with bus driver? Frankly I am not surprised if you have oopses when
cycling bus drivers with concurent procfs/sysctl accesses. I *am*
surprised if you have oopses while only cycling chip drivers.

-- 
Jean Delvare
