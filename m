From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: Tyan sensors support
Message-Id: <3EF3550C.9F1EDD93@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EE24F4E.2060801@paradyne.com>
In-Reply-To: <3EE24F4E.2060801@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The w83781d module supports the w83627hf chip on the i2c and isa busses
now (2.7.0) and that will not be changed.

The w83627hf module in CVS supports the chip only in isa mode.

In the sensors.conf files you don't care what kernel module supports
the chip, that is hidden from you. You just put "w83627hf-*" in a chip line.
If features are different depending on what bus a chip
is on you can use separate sections, headed by
"w83627hf-i2c-*" and "w83627hf-isa-*".


Kevin Schlichter wrote:
> 
> Mark,
> 
> Will there be any way at all to access a 672hf chip on the i2c bus, or
> will the ISA-only 672hf module be the /only/ way?  I'm asking so I can
> start altering the .config files I've written if I need to.
> 
> On Sat, 2003-06-07 at 13:47, Mark D. Studebaker wrote:
> > Thank you very much for posting sensors.conf files on your website for your motherboards.
> > You are the first manufacturer we know of to do this, it is quite helpful.
> > If you have any questions about our package please let uw know.
> >
> > Note that in CVS we have a new w83627hf module that is ISA-only
> > and finds the device with Super I/O probing.
> > This will make things much easier for our users when our 2.8.0 release comes out.
> >
> > thanks again
> > mds
> >
> >
> >
