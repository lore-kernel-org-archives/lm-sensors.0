From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: lm_sensors && bt869
Message-Id: <20040102135658.73babf66.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031228153744.49065c91.khali@linux-fr.org>
In-Reply-To: <20031228153744.49065c91.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> >> 6. switch_output_format : 2=RGB, 1=SVIDEO, 0=Composite
> 
> JD> Using "format" is a bit confusing IMHO. What about
> JD> "output_source"? (Oh well this is maybe even more confusing...)
> 
> Perhaps output_mode ?

I thought "source" because that's the term that is used in xawtv when
you have to choose between tuner, composite and s-video for input. I
admit that output_source sounds a bit strange but input_source (for
an hypothetical video decoder chipset) would be correct. This is the
reason why I was proposing this. "Mode", as "format", is not explicit
enough and could apply to other things as well. I think I'd go for
"output_source" because people will probably understand immediately what
it represents, although "output" and "source" are somewhat contradictory
terms.

> JD> Well, without the hardware I probably won't help much - and I
> JD> don't really plan to read the full data sheet ;) Don't know what
> JD> to do with these. If it's not a "public" think, we don't care
> JD> much, except that it might conflict with something else someday...
> JD> Do as you want. If it's not widely used, this also mean we can
> JD> change it later if needed.
> 
> When I tried it in the past (with a 2.4 kernel) it gave out quite
> strange results. I think I'll name it bt869_status[1-3] so that it
> doesn't interfere. OK?

This is OK for me.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
