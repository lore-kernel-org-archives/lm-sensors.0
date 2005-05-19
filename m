From: d.piccoli@murdoch.edu.au (Daniel Piccoli)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: ADM 1025 on 2.6 kernel
Message-Id: <1089173282.7376.1.camel@powerride>
List-Id: <lm-sensors.vger.kernel.org>
References: <1084951647.6186.13.camel@powerride>
In-Reply-To: <1084951647.6186.13.camel@powerride>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

I have just tried the unified linux patch for ADM 1025 and everything
seems to be working fine.

The VID value is +1.700 V

regards,

Daniel.

On Mon, 2004-06-28 at 03:55, Jean Delvare wrote:
> Hi Daniel,
> 
> Including Freitas as well since you seem to share interests.
> 
> > just wondering the approximate timeframe for ADM 1025 support on the
> > 2.6 kernel.
> 
> I just finised my port, sorry for the delay. You can get it here:
>   http://khali.linux-fr.org/devel/i2c/linux-2.6/
> 
> Either apply the adm1031 and adm1025 patches in order (I don't think the
> adm1025 patch alone will apply cleanly) or the unified
> linux-2.6.7-i2c.patch.gz, to any 2.6.7+ kernel.
> 
> You will need lm_sensors CVS for user-space tools for full support. If
> you have an older version (but at least 2.8.5) it should still work,
> you'll only miss the VID value in "sensors".
> 
> I'm particularly interested in feedback concerning VID value. As you may
> know, the ADM1025 chip may either monitor +12V and have 4-bit VID
> values, or have 5-bit VID values. In the first case, I'm not sure of the
> value to give to the missing bit. The driver and datasheet suggest 0,
> but another doc I found about Pentium Pro (which is the target CPU for
> the ADM1025 according to the datasheet) suggests 1. That's not something
> I can verify on my evaluation board, of course, since it has no CPU.
> 
> Let me know how it works for you!
> 
> > Thanks for the great sw.
> 
> Thanks :)
