From: druid@takeover.nl (Michiel Rook)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: adm9240 chip on a intel se440bx-2
Message-Id: <5.1.0.14.2.20040719232605.0128ff78@192.168.1.4>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c4620c$f27351f0$3635430a@glauke>
In-Reply-To: <000001c4620c$f27351f0$3635430a@glauke>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry for the late reply, I have been awfully busy. Anyway, adm9240.c
is up at http://solar.xs4all.nl/share/ with most of the fixes.

Cheers,

Michiel

At 22:57 8-7-2004, Jean Delvare wrote:
> > There are one or two errors in the build, which surfaced when I
> > upgraded to gcc-3.3, I'll fix them tonight and resubmit the adm9240.c
> > file. Magnitude problems are fixed, most issues you mentioned some
> > time ago too.
>
>OK. As a reminder, please make sure that:
>
>1* Magnitudes for temperatures and voltages are 3. It's the standard and
>that's how I tweaked the library in CVS.
>2* Chip drivers should *NOT* set limits at init time unless default
>limits for the chip are known to be broken (which is rare but happens).
>
>Thanks.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040719/063e357d/attachment.html
