From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: DMI detection
Message-Id: <3D42C6C0.3CF26F8E@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020724162451.F8689@Stimpy.netroedge.com>
In-Reply-To: <20020724162451.F8689@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm going to work on putting DMI detection in i2c-piix4.
Any voluteers for doing the same in perl for sensors-detect? (please!)


"Mark D. Studebaker" wrote:
> 
> I haven't seen where doing a 'make' will write DMI stuff to .config.
> But you never know. Not that you can look in .config from a running
> kernel anyway...
> 
> I don't think we have any choice but to copy what we need from
> dmi_scan.c and put it in piix4.c.
> And copy dmidecode.c (that I found on Alan's server and I sent you)
> and port it to perl and put it in sensors-detect. Yuck.
> 
> Actually I think we should take i8k.c and make it a combination bus/chip
> driver
> for our package. THAT would be a good project.
> 
> phil@netroedge.com wrote:
> >
> > Oh, incidently, I thought I read that Alan's DMI stuff writes stuff to
> > .config?  It might be much easier to use DMI if we can read his
> > results instead of doing the horrible copy-and-paste stuff which was
> > done in drivers/char/i8k.c.
> >
> > Phil
> >
> > --
> > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> >    phil@netroedge.com -- http://www.netroedge.com/~phil
> >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
