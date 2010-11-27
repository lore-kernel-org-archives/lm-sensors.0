From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 27 Nov 2010 17:25:24 +0000
Subject: Re: [lm-sensors] Nuvoton W83677HG-I
Message-Id: <20101127172524.GA13597@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101127155903.GB26489@hamsu.tarvainen.info>
In-Reply-To: <20101127155903.GB26489@hamsu.tarvainen.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Nov 27, 2010 at 10:59:03AM -0500, Tapani Tarvainen wrote:
> I got an Intel DQ57TM motherboard, sensors-detect says it has
> 
>     Chip `Nuvoton W83677HG-I Super IO Sensors' (confidence: 9)
> 
> for which there's no driver yet.
> 
> http://www.lm-sensors.org/wiki/Devices says there's been
> only one request for it; for what it's worth, here's another.
> 
> I don't want it quite badly enough to donate a board for
> the development (I might pitch in a small donation though),
> but I'd be more than willing to help in testing &c.
> 
> I might even have a go at it myself, but I'd need a bit of
> help to get started, most importantly: where does one get
> specs for these things? Is it possible to get docs from
> manufacturers (Nuvoton website doesn't look promising)
> or is it just experimenting/guesswork based on other
> maybe-similar older chips or does one have to reverse
> engineer Windows drivers or what?
> 
For Nuvoton, you send a request to ComputerIC@nuvoton.com and ask nicely.
The datasheet to ask for is probably NCT6776F (it used to be
NCT6775F, but it looks like they added another variant).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
