From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 05 Jun 2012 18:19:15 +0000
Subject: Re: [lm-sensors] [PATCH RFC] hwmon: (coretemp) Improve support for TjMax detection on Atom CPUs
Message-Id: <1338920355.478.241.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1338827851-702-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1338827851-702-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-06-05 at 14:04 -0400, Jean Delvare wrote:
> On Tue, 5 Jun 2012 09:29:22 -0700, Guenter Roeck wrote:
> > On Tue, 2012-06-05 at 04:02 -0400, Jean Delvare wrote:
> > > On Mon,  4 Jun 2012 09:37:31 -0700, Guenter Roeck wrote:
> > > > +	{ "CPU E620T", 110000 },
> > > > +	{ "CPU E640T", 110000 },
> > > > +	{ "CPU E660T", 110000 },
> > > > +	{ "CPU E680T", 110000 },
> > > 
> > > This probably won't work either, as for an unknown reason Intel did not
> > > encode the model number for at least some of these Atom CPUs:
> > > http://lists.lm-sensors.org/pipermail/lm-sensors/2011-June/033010.html
> > > This is even the reason why we did not use the processor name strings
> > > back then.
> > > 
> > Ah, now I remember. That explains why I didn't find any online logs with
> > those IDs. Would be great to find PCI bridge ID we could use instead ...
> 
> You can read the whole thread, to see if this was already discussed. I
> seem to recall we did and concluded it wasn't an option, but I could
> remember wrongly.
> 
It doesn't cover all CPUs, but it should cover all Atoms except for the
E6xx series. I did find model name info for all other Atom CPUs on the
web - this is how I noticed the N2000 and D2000 series. The N2000 and
D2000 series all have a TjMax of 100 degrees C, so we don't need a table
for those. I changed the code to handle model ID 0x36 separately and set
TjMax for those directly to 100 degrees C.

Do you have access to the Medfield Atom (Z2640) specification ? I did
not find anything on the Intel web site. It would be interesting to know
its TjMax. Same for the CE4100 - Intel seems to closely guard those
specifications.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
