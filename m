From: raj@ast.man.ac.uk (Richard James)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Ticket number 1467
Message-Id: <Pine.OSF.4.53.0312131136460.20494@axp0.ast.man.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031210225306.55ceb34e.khali@linux-fr.org>
In-Reply-To: <20031210225306.55ceb34e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Jean,

	I have just checked out your last suggestion in the message below
- it works!  Very many thanks for all your help.  I have learned a great
deal about how the sensors package works over this problem, thanks to your
guidance.

	Re your remark about Asus chips in your first message - when I
bought the board I basically had no criterion to choose between Asus and
Abit, which were the two which seemed most attractive.  If I had realised
how troublesome using the as99127f was going to be I would have gone the
other way!  You only find these things out when you actually buy a piece
of kit - at that time the board was too new for there to be anything
relevant on the sensors support page.  Next time I buy I may go to a Xeon
cpu (for the sake of the large memory support on Xeon motherboards) or if
the IA64/AMD 64 bit processors look attractive in both specification and
price I may go that way - I expect a whole new can of worms then!  We will
of course be on 2.6.x kernels by then.

	Anyway, very many thanks for all your help.  I suppose I would
have been able to sort this out if I had known more about systems, but
regrettably I don't, my interests being in large numerical applications.

		All the very best,

				Richard James.

On Thu, 11 Dec 2003, Jean Delvare wrote:

> > < clip >
> > > Version 2.8.0:
> > > w83782d-i2c-0-2d
> > <clip>
> > > Version 2.8.1:
> > > as99127f-i2c-0-2d
> >
> > Just wanted to point out that the 2.8.0 printout was for w83782d,
> > while 2.8.1 was for as99127f. So different compute rules in
> > sensors.conf were applied.
>
> Stupid me. Thanks for the notice.
>
> Richard, do you confirm that recent versions of sensors-detect tell
> you you have a revision 2 AS99127F?
>
> I've checked an improved version of sensors.conf in our CVS repository.
> Get it here:
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/etc/sensors.conf.eg
>
> Copy it to /etc/sensors.conf, and edit the "as99127f-*" section. You'll
> find commented out lines for AS99127F rev.2 in5 and in6. Uncomment them
> and you're (hopefully) done.
>
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
>
