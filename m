From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 24 Dec 2011 16:01:58 +0000
Subject: Re: [lm-sensors] ITE IT8772F
Message-Id: <20111224160158.GA7736@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFVoeGcJ8N_DL41DzbsCOw-UVOUN7e1D42SQ1j+h66WOm0UP=Q@mail.gmail.com>
In-Reply-To: <CAFVoeGcJ8N_DL41DzbsCOw-UVOUN7e1D42SQ1j+h66WOm0UP=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 23, 2011 at 06:51:47PM -0500, In-Ho Yi wrote:
> Dear lm-sensors team,
> 
> Thank you for all the hard work to support devices. I own Shuttle SH67H3, which
> is IT8772F chipset.
> Following instructions for a similar chipset, I've tried modprobe it87 force_id
> =0x8721

[ ... ]

> Note that Shuttle has only one fan built in, so fan speed readings are probably
> right. For all other weird readings, I get those from SpeedFan, too.
> I was able to do pwmconfig to make fan2 correlate to temp2, and it seems to be
> working fine.
> 
Probably quite compatible, but there are a few quirks with the 8772 for which I'd rather
see a datasheet.

On the plus side, looks like Open Hardware Monitor and Mosys (Google) support it, so
maybe there is enough information available to make it work. We'll have to see.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
