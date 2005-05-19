From: psycho@albatross.co.nz (Keith Duthie)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: Hangs with w83781d
Message-Id: <Pine.LNX.4.53.0402220058590.214@loki.albatross.co.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.53.0304082321580.3437@loki.albatross.co.nz>
In-Reply-To: <Pine.LNX.4.53.0304082321580.3437@loki.albatross.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 21 Feb 2004, Jean Delvare wrote:

> I have attached what I think is the correct patch against Linux 2.6.3
> (i.e.: without your own change applied). Seems to work for me (but I had
> no problem before). Can you confirm that it works as good as your own
> change?

It appears to work fine.

> If it's OK, I'll backport the change to the two drivers in our CVS
> repository that have similar code (w83781d.c and w83627hf.c).
>
> It's actually a great thing that we can finally come to a clean solution
> to your problem, 10 months later.

Cool.

Now I just need to figure out what change between 2.4.20 and 2.4.21 (which
is also in 2.6) caused apm suspend to do nasty things to whatever process
is writing to the sound driver...

It's almost enough to make me try switching to ACPI ;-)
-- 
Just because it isn't nice doesn't make it any less a miracle.
     http://users.albatross.co.nz/~psycho/     O-   -><-
