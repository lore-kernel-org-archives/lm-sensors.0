From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 13 Sep 2010 14:17:16 +0000
Subject: Re: [lm-sensors] Lack of fan sensor output after Ubuntu upgrade
Message-Id: <20100913141716.GD359@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201009101529.26294.larsivar@igesund.net>
In-Reply-To: <201009101529.26294.larsivar@igesund.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Sep 13, 2010 at 04:05:45AM -0400, Jean Delvare wrote:
> On Sun, 12 Sep 2010 12:32:13 -0700, Guenter Roeck wrote:
> > On Sat, Sep 11, 2010 at 05:03:31AM -0400, Jean Delvare wrote:
> > > BTW... A quick search reveals that several Dell XPS Studio laptops
> > > embed an ITE IT8512 infra-red receiver chip. Probably not a
> > > coincidence...
> > > 
> > You are right. IT8512E/F is a Super-IO chip from ITE, and it uses 0x8512 as chip ID.
> 
> How do you know for sure? Do you have a datasheet? Once we're sure we
> can identify the chip reliably, support should be added to
> sensors-detect.
> 
I was able to dig up a datasheet on the web, and checked the chip ID.
The datasheet is at http://www.docin.com/p-4432074.html. The site is in Chinese (?), 
and the datasheet is not in pdf but displayed with flash, so it is a bit cumbersome
to read.

Chip ID is 0x8512 (registers 0x20 and 0x21), and chip version is 0x22 (register 0x22).
Not sure if the version is correct, as it matches the register address, but that is
what it says.

I agree, it would make sense to add it to sensors-detect. I looked through the code,
but wasn't entirely sure how to do that, since the NS chip IDs are all 8 bit.
Can I just add an entry for chip ID 0x8512 ? Also, I don't know what to specify as logdev,
since the sensors are all accessed through an embedded 8032 controller. 

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
