From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 31 Jan 2012 08:08:02 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of LM96080
Message-Id: <20120131090802.1777c205@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 31 Jan 2012 08:37:41 +0100, Frans Meulenbroeks wrote:
> 2012/1/28 Jean Delvare <khali@linux-fr.org>
> 
> > Add detection of the National Semiconductor (now Texas Instruments)
> > LM96080. It is functionally compatible with the LM80 but detection is
> > completely different.
> > ---
> > Frans, if you want to test this, a pre-patched version of
> > sensors-detect is available at:
> > http://khali.linux-fr.org/devel/misc/sensors-detect
> >
> 
> Jean, all,
> 
> I wanted to give this a stab but then noticed this was a perl script, and
> the board on which the LM96080 lives is a small embedded system that does
> not have perl, so unfortunately I cannot test it.
> 
> Sorry! Frans

No problem. I've tested on the dump you sent to me, and it works OK, so
let's just claim this is good enough.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
