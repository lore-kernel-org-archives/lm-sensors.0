From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 26 Mar 2012 20:39:53 +0000
Subject: Re: [lm-sensors] Not detecting all fan RPMs
Message-Id: <1332794393.21301.78.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1332789633.10230.9.camel@dfghom-gjhollo2.site>
In-Reply-To: <1332789633.10230.9.camel@dfghom-gjhollo2.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2012-03-26 at 16:33 -0400, Glenn Hollowell wrote:
> I'd assumed that since I am able to see correct RPMs for all fans while
> in BIOS, I'd be able to parse out correct RPMs in Linux-OS as well. My
> impression is also that correct RPMs are also displayed using the
> Windows-OS application, "SpeedFan". 
> Thanks again for your thoughts on this matter. gh
> 
Please don't top-post.

Problem is that the Windows application folks don't typically share
their information with us. Unlike Linux, Windows is not an open source
operating system, and that is often reflected in the attitude of Windows
application developers.

Guenter

> 
> On Mon, 2012-03-26 at 22:28 +0200, Jean Delvare wrote:
> > On Mon, 26 Mar 2012 13:16:35 -0700, Guenter Roeck wrote:
> > > On Mon, 2012-03-26 at 15:44 -0400, Jean Delvare wrote:
> > > > The NCT6775 supports only 4 fans, so either there is some multiplexing
> > > > in place (which we don't support) or you have a second hardware
> > > > monitoring chip on your system.
> > >
> > > I had not thought about multiplexing - good point. That would explain
> > > why the chassis fans can only be configured for manual mode or full on.
> > 
> > From a monitoring perspective, this makes absolutely no sense of
> > course, as this means a delay in detecting fan failure. But the fact is
> > that we've already seen this in the past. Manufacturer apparently
> > preferred to save a few cents per board by using multiplexing and
> > getting an ugly and unreliable solution rather than adding a second
> > hardware monitoring chip for a clean and reliable one. Tsss...
> > 
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
