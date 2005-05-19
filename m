From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: [Fwd: Re: [PATCH]2.4.20 ARCH=i386 create dmi_scan.h and move decl
Message-Id: <3D59BC9D.C4F47EB3@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D591B61.27865177@attbi.com>
In-Reply-To: <3D591B61.27865177@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

well, Alan originally said we could do it either way but now he
says we can only export the flags rather than export dmi_ident.

Albert, I'll come up with a patch to dmi_scan and send it to you to look
at
and send on.

mds


Albert Cranford wrote:
> 
> fyi
> -------- Original Message --------
> Subject: Re: [PATCH]2.4.20 ARCH=i386 create dmi_scan.h and move decl fromdmi_scan.c
> Date: 13 Aug 2002 13:13:04 +0100
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: Albert Cranford <ac9410@attbi.com>,Linus Torvalds<torvalds@transmeta.com>
> CC: Marcelo Tosatti <marcelo@conectiva.com.br>,Linux Kernel List<linux-kernel@vger.kernel.org>
> References: <3D589E11.6093B119@attbi.com>
> 
> On Tue, 2002-08-13 at 06:50, Albert Cranford wrote:
> > -
> > -static char *dmi_ident[DMI_STRING_MAX];
> > +char *dmi_ident[DMI_STRING_MAX];
> 
> Be very careful with this change btw. The dmi_ident strings are unmapped
> at the point dmi_table() returns. That means you can only use them in
> the decode callback, and so it seems odd to export them. It certainly
> wants clear documentation if you are doing it that way.
> 
> What you probably should do is create some flag bits for i2c/smbus and
> set those then export the flag data (we do the same for APM), rather
> than export them as globals
