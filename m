From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: [PATCH] Port of w83627hf to kernel 2.6
Message-Id: <20040219040102.GI21829@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c3f596$0f1ffd00$0300a8c0@berninoti>
In-Reply-To: <000801c3f596$0f1ffd00$0300a8c0@berninoti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bernhard:

* Bernhard Schrenk <clemy@clemy.org> [2004-02-18 12:38:33 +0100]:
> Thanks for your suggestions for improvement. I have incorporated them into
> the patch and merged the modifications from the latest CVS driver version.
> The new patch is attached to this mail.

Nice work.

But, there's still this (which is my fault for not being clear earlier):

> #define IN_FROM_REG(val) (((val) * 16 + 5) / 10)

And then later...

>         return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr] * 10)); \

The '/10' and '*10' are artifacts of the 2.4 representation.  They're
not needed here.  This is what I mean by keeping the conversions in
one place... there's no reason to carry around an intermediate 
representation which differs by a factor of ten (or whatever).

I know... the obvious example (w83781d.c) gets this wrong as well.

In the mean time, I'm off to actually load the code and try it. ;)

Thanks and regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
