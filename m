From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 05 Jun 2012 18:04:25 +0000
Subject: Re: [lm-sensors] [PATCH RFC] hwmon: (coretemp) Improve support for TjMax detection on Atom CPUs
Message-Id: <20120605200425.1ddc05a9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1338827851-702-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1338827851-702-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 5 Jun 2012 09:29:22 -0700, Guenter Roeck wrote:
> On Tue, 2012-06-05 at 04:02 -0400, Jean Delvare wrote:
> > On Mon,  4 Jun 2012 09:37:31 -0700, Guenter Roeck wrote:
> > > +	{ "CPU E620T", 110000 },
> > > +	{ "CPU E640T", 110000 },
> > > +	{ "CPU E660T", 110000 },
> > > +	{ "CPU E680T", 110000 },
> > 
> > This probably won't work either, as for an unknown reason Intel did not
> > encode the model number for at least some of these Atom CPUs:
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2011-June/033010.html
> > This is even the reason why we did not use the processor name strings
> > back then.
> > 
> Ah, now I remember. That explains why I didn't find any online logs with
> those IDs. Would be great to find PCI bridge ID we could use instead ...

You can read the whole thread, to see if this was already discussed. I
seem to recall we did and concluded it wasn't an option, but I could
remember wrongly.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
