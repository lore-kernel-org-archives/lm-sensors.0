From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: NCLV-D SMBus - proposal to a solution
Message-Id: <20050418204700.5ffaa0fb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4262C492.10808@sh.cvut.cz>
In-Reply-To: <4262C492.10808@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> This is a good time to bring up the i2c-virtual driver as an
> alternative to the -s4882.c style of multiplexing driver. I believe
> this is a cleaner and more general approach to bus multiplexing.

I agree it is more general, and possibly cleaner as a result. However,
it will fail to be as flexible as the s4882 style approach.

The S4882 has 8 busses, 2 for each CPU. The 2 busses of each CPU are
"compatible" (no common address) so I merged them, which results in
better performance (less switching required) and lower memory footprint.
I don't think you'll be able to do that with the i2c-virtual approach.

In the NCLV-D case, it has 4 different bus lines, but we only really
want to handle 2. How can you do that with i2c-virtual?

Also, I think I remember that i2c-virtual somehow assumes that the
multiplexer itself is an i2c chip, right? This is not the case for the
NCLV-D.

Additionally I don't much like the change that was required to i2c-core.
Exporting non-locking versions of core functions for the use of one
single driver makes very little sense. I'd rather merge a part of
i2c-virtual into i2c-core if that's what it takes.

> The i2c-virtual driver is checked in to sensors but the small changes
> required to i2c-core.c are not checked in. I held off late last year
> because 2.9.0 was coming out soon. Now that 2.9.1 is out it's  time to
> look at it again. I have to rework the i2c-core changes because they
> conflicted with other recent changes to i2c-core.

Yeah, I remember that.

The more I think of it, the more obvious it is that such a change
doesn't belong to the 2.4 kernel, but 2.6. I do not want any more
changes to the i2c subsystem of Linux 2.4 (except for bug fixes and
documentation updates, of course). It's more than time to move the
development effort to 2.6, and only do support on 2.4.

> attached are the proposed changes to i2c-core for comment.

Eerk. By brain doesn't read non-unified patches very well, sorry.

-- 
Jean Delvare
