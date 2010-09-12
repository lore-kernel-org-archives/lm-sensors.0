From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 12 Sep 2010 19:32:13 +0000
Subject: Re: [lm-sensors] Lack of fan sensor output after Ubuntu upgrade
Message-Id: <20100912193213.GA30366@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201009101529.26294.larsivar@igesund.net>
In-Reply-To: <201009101529.26294.larsivar@igesund.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 11, 2010 at 05:03:31AM -0400, Jean Delvare wrote:
> On Sat, 11 Sep 2010 10:53:39 +0200, Jean Delvare wrote:
> > On Fri, 10 Sep 2010 09:15:27 -0700, Guenter Roeck wrote:
> > > On Fri, Sep 10, 2010 at 09:29:25AM -0400, Lars Ivar Igesund wrote:
> > > > Probing for Super-I/O at 0x4e/0x4f
> > > > 
> > > > Trying family `National Semiconductor'... Yes
> > > > 
> > > > Found unknown chip with ID 0x8512
> > > > 
> > > > Is this something of interest?
> > >
> > > Most likely this is a Nuvoton chip; they use chip id 0x85 for another chip.
> > 
> > This doesn't strike me as a particularly relevant data point.
> 
> BTW... A quick search reveals that several Dell XPS Studio laptops
> embed an ITE IT8512 infra-red receiver chip. Probably not a
> coincidence...
> 
You are right. IT8512E/F is a Super-IO chip from ITE, and it uses 0x8512 as chip ID.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
