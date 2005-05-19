From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: [Fwd: Broken link on web page] VIA datasheets
Message-Id: <3E2D9AC0.8946DC7@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E248908.80200@netroedge.com>
In-Reply-To: <3E248908.80200@netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It's still in our pkg (ltc1710.c) but we removed it from mkpatch because
it isn't likely to be on a PC motherboard and it's undetectable.

Jean Delvare wrote:
> 
> > thanks for tackling this.
> > You can of course check in updates as you go if you like.
> > Given that suppliers update their web pages frequently
> > it may make sense just to link to their home page rather
> > than try to reference a datasheet page in particular.
> > Especially since many have a form on the home page you can
> > type a part number into to get info.
> 
> Well I try to have something as convenient as possible for the users
> (including us, after all). And I also try to reward companies that have
> a great support on their site. When it isn't possible, I simply link to
> the homepage, and we're done.
> 
> BTW, the list says we support one "Linear Technologies" chipset
> (LTC1710) but there's no trace about it in the source code, except in
> the README file. And the CHANGES file mentions: "Remove ltc1710;" (when
> 2.6.0 was released). So I guess that the chipset has been supported for
> a while but we have dropped support now? In this case, I'll remove from
> the list (both on the webpage and in the README file).
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
