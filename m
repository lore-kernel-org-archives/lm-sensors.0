From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 27 Jan 2014 23:41:35 +0000
Subject: Re: [lm-sensors] lm90 driver no longer working on PCs in 3.13
Message-Id: <20140127234135.GA18059@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <52E561D0.4040308@roeck-us.net>
 <20140126211357.6fa68909@endymion.delvare>
 <52E573B6.9040903@roeck-us.net>
 <20140126214936.7736f530@endymion.delvare>
 <52E58330.90602@roeck-us.net>
 <52E58656.7000903@roeck-us.net>
 <20140126235103.GP11727@sirena.org.uk>
 <52E6951C.60609@wwwdotorg.org>
 <20140127185031.GA28910@roeck-us.net>
 <20140127230447.7e8be3a4@endymion.delvare>
In-Reply-To: <20140127230447.7e8be3a4@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Wei Ni <wni@nvidia.com>, linux-kernel@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>

On Mon, Jan 27, 2014 at 11:04:47PM +0100, Jean Delvare wrote:
> On Mon, 27 Jan 2014 10:50:31 -0800, Guenter Roeck wrote:
> > On Mon, Jan 27, 2014 at 10:19:24AM -0700, Stephen Warren wrote:
> > > On 01/26/2014 04:51 PM, Mark Brown wrote:
> > > > On Sun, Jan 26, 2014 at 02:04:06PM -0800, Guenter Roeck wrote:
> > > > 
> > > >> I think I have a better idea: Surround the regulator code, or at least
> > > >> its error handling, in the lm90 driver with
> > > > 
> > > >> 	if (IS_ENABLED(CONFIG_OF)) {
> > > >> 	}
> > > > 
> > > >> Would that be ok ? If yes I'll submit a patch. I'll do the same in
> > > >> another driver I am working on.
> > > > 
> > > > That's not going to have the desired effect in cases where DT is built
> > > > into the kernel but not in use on the current system (which is a
> > > > configuration that gets used) ...
> > > 
> > > The solution to that particular aspect of the problem is the following:
> > > 
> > > if (of_have_populated_dt()) {
> > > 	...
> > > 
> > 
> > Turns out that won't help either after Mark's patches to ACPI and
> > to the regulator core are applied. Right now I don't have a solution
> > that would work for all systems.
> > 
> > I'll leave it up to Jean to decide how to proceed.
> 
> I have no idea, really. I have seen multiple patches flying around,
> each seems to have its own merits, but I simply don't know which is
> going in the direction. I don't know a thing about regulators, OF, DT
> etc. so I am really not the right person to make a decision about this.
> 
> All I can say is: either someone comes up with a patch set which
> properly fixes the regression for all lm90 drivers users, or I will have
> to revert commit 3e0f964f.
> 
I'll test Mark's two patches on my system and let you know the results.
After looking some more into it, those _may_ actually fix the problem at least
for systems supporting ACPI. No promise, though, and I am not sure if that
would be sufficient (it may still not work on non-ACPI PCs). But then who
am I to say ...  Mark keeps repeating that I don't know what I am talking about,
after all, and maybe he has a point ;-).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
