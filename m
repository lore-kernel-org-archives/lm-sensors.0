From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [PATCH 2.4] i2c cleanups
Message-Id: <20031220123741.38cd9fa3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> correct. see Ticket #331.
> I don't see this as a big problem though.

I am not refering to the race condition that existed with the old
method. This was due to the general design of modules in Linux 2.2 if I
understood it correctly. There's nothing we could do about it.

The real problem is that the move to 2.4 method with .owner=THIS_MODULE,
which was supposed to fix that, was not done correctly and that
accessing the /proc interface doesn't lock the modules at all, so it's
very easy to get the kernel to oops. Of course we can tell the users not
to do it, and I'm sure almost none of our users ever experienced the
problem, still that's not acceptable to submit such a change for
inclusion into the Linux 2.4 kernel.

I'd like to remind everyone that I'm currently trying to get i2c 2.8.2
into the 2.4.24 kernel only because of this structure change. If it
turns our that the structure change isn't going to make it into 2.4
anyway, then I'm wasting my time and Marcelo's too.

> Unfortunately, most of this is over my head so don't expect me
> to contribute much to a review of Khali's patch.

It's far over my head too. But there must be someone who decided we
would change to the new referening style. Ky?sti I suppose? If nobody
here is able to propose an acceptable solution to fix the problem, we'll
have to undo all the changes and come back to the old reference counting
mechanism as it exists in the Linux 2.4 kernel, so that we ensure the
compatibility with existing i2c drivers again.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
