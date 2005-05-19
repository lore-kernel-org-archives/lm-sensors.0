From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: i2c-algo-bit timing
Message-Id: <Pine.OSF.4.50.0212022351080.25430-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 1 Dec 2002, Ky?sti M?lkki wrote:

> First, included gzipped patch against latest CVS, it's my current local
> work I told I would not commit before release and round for comments.
>

Some notes to comment on the changes in the patch..

I have been reading the "Fast Mode" specs to test my setup, at some
points the 1 us I use violates this.

For debug use, we need adapter name from i2c_adapter everywhere.
Current debugging is useless, while the original was simply
incomprehensible. Sorry about the misspelling.

Improved symmetry; outb/inb now both handle the acknowledge timeslot.
Sendbytes/readbytes only loop over the buffer and test for failures.
Pass i2c_msg->flags deeper down to support more i2c mangling.

The i2c_adapter->retry now applies to complete message. Previously
it would fail on any [NA] after the address [A].
I am not 100% sure how auto-incrementing EEPs will tolerate it,
if we fail in the middle of a page and then resend from the beginning.

A message may be sent correctly after ignored [NA], retry or timeout.
The caller could check this in i2c_msg->err, if necessary.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
