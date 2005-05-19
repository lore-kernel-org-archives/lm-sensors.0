From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: i2c in kernel 2.4
Message-Id: <20040222204300.5c65d1c6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

For those of you who would have missed the last episodes of the "how to
get i2c 2.8 into Linux 2.4", here's a quick summary of the situation.

I have been sending three waves of patches to Marcelo. The first wave
was completely accepted. The second had 40% rejected. The third was
almost completely rejected. It is clear that Marcelo doesn't want any
more change to the i2c core in Linux 2.4, unless these are bug fixes. I
cannot blame him for that. The changes we wanted to do are far from
being trivial. What's more, as I worked on these patches, I could see
that our new locking mechanism is incomplete, and our module usage
counters are broken. Even if Marcelo was less difficult to convince, I
would *not* want to propose something obviously broken for inclusion
into Linux 2.4.

As Linux 2.4.25 was released, I had to rebuild a new patchset so that
people can use both lm_sensors and other i2c stuff with that kernel,
like I have been doing since release 2.4.21. It took me something like 3
or 4 hours. I don't plan to do it again. It was OK to make these patches
as a temporary solution. It doesn't make sense as a definitive one.

Since we won't have our i2c subsystem in Linux 2.4, ever, this means
that we have to make ours compatible again. This may sound like a
regression, and it's kind of, admitedly, but face the truth: this change
belonged to Linux 2.5 and should never have been kept in the 2.4 branch.

I don't know exactly how this can be done, since I don't much know the
internals of i2c-core and i2c-proc. However I see two possibilities:

1* Revert just everything to the old module usage count mechanism. This
means changing every and all of our drivers.

2* If this is technically possible, make the new and old mechanisms work
together. What I have in mind sounds like "if it has .inc_use/.dec_use,
call it, else it must be using the new mechanism, use .owner". The
problem is that I just don't know which part of the system handles that.
Is it i2c-proc? Is it i2c-core? Or something deeper into the kernel?

As far as the structures are concerned, this would mean having both
.inc_use/.dec_use and .owner in them, with .owner last as to not break
compatibility with the kernel drivers that are still using non-C99
initializers. Drivers would have to use either of them, but not both.

Since I don't know much how this has to be done, the help of everyone,
especially Ky?sti, is welcome.

BTW, Ky?sti, some times ago you told us you were working on fixing
things on i2c. We did not hear from you since. Whatever code changes you
have, please discuss them with us if you plan to commit them to the
repository. I'd like to avoid what happened last time when you commited
so many changes at once that everyone was left puzzled.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
