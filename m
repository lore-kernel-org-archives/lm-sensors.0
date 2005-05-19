From: clemy@clemy.org (Bernhard Schrenk)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: [PATCH] Port of w83627hf to kernel 2.6
Message-Id: <002701c3f6c6$86aa6fa0$3d07010a@isispapyrus.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c3f596$0f1ffd00$0300a8c0@berninoti>
In-Reply-To: <000801c3f596$0f1ffd00$0300a8c0@berninoti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

From: "Mark M. Hoffman" <mhoffman@lightlink.com>
> But, there's still this (which is my fault for not being clear earlier):
>
> > #define IN_FROM_REG(val) (((val) * 16 + 5) / 10)
>
> And then later...
>
> >         return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr] *
10)); \

I have corrected this and attached the new patch to the mail.

Regards,
Bernhard
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627hf.patch3.bz2
Type: application/octet-stream
Size: 9405 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040219/68476067/w83627hf.patch3.obj
