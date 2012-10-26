From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 26 Oct 2012 01:28:49 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83627hf) Add support for suspend
Message-Id: <20121026012849.GA5144@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121023175025.6d6e46a4@endymion.delvare>
In-Reply-To: <20121023175025.6d6e46a4@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 24, 2012 at 08:17:26AM +0200, Jean Delvare wrote:
> On Tue, 23 Oct 2012 20:33:55 -0700, Guenter Roeck wrote:
> > On Tue, Oct 23, 2012 at 05:50:25PM +0200, Jean Delvare wrote:
> > > On suspend some register values are lost, most notably the Value RAM
> > > areas but also other limits. Restore them on resume. On top of that,
> > > some fixups are needed to work around BIOS bugs, in particular when
> > > the BIOS omits running the same initialization sequence on resume
> > > that it does after boot. In that case we have to carry initialization
> > > over suspend.
> > > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > 
> > Does the BIOS bug apply to all BIOSes, or just to some, or does it not matter ?
> 
> At least mine. But there is no downside on other systems, reading and
> writing two extra registers over the LPC bus is pretty cheap. And I
> would be very surprised if other BIOSes out there don't need the same
> anyway.
> 
> > I have a system with w83627hf - want me to test the code with it ?
> 
> Would be great, yes. Dumping the registers before and after suspend
> would be a good way to ensure it worked fine.
> 
Acked-and-Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
