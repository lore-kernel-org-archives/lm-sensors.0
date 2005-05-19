From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: Memory leak in I2C (ticket #1898)
Message-Id: <jG6nFvCq.1108465575.6408970.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi James,

I am moving this to the mailing-list since it is likely to require some
investigation before we can find out what's going on, and our current
ticket system is not meant for this. (Philip, Axel, where is the new
Bugzilla system going?)

Most things in the i2c core in linux 2.4 are static, so I doubt that
there can be a leak in i2c-core itself. i2c-proc OTOH is likely to
allocate memory for various things, so this is a candidate. And, as you
suggested yourself, individual drivers are candidates as well.

Please tell us:

* Which i2c drivers you are using.

* What your test script is. Which modules are you cycling exactly, in
which order, at which rate? I'd be happy to do the same on my own
machines (with different bus and chip drivers) and see if I can
reproduce the problem.

Once we know in which kernel module the leak is, it shouldn't be too
hard to find out where the leak is exactly. There aren't that many
memory allocations in there.

BTW, thanks a lot for reporting.
--
Jean Delvare
