From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Nov 2009 08:25:37 +0000
Subject: Re: [lm-sensors] ASUS P6T, 2.6.31-14, no pwm devices
Message-Id: <20091124092537.0922adfc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <8c4290000911141138v161593b0u785895e5a7960587@mail.gmail.com>
In-Reply-To: <8c4290000911141138v161593b0u785895e5a7960587@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Reinhard,

On Sun, 15 Nov 2009 23:08:01 +0100, Reinhard Nissl wrote:
> Am 15.11.2009 22:53, schrieb Jean Delvare:
> 
> >> Looks like gkrellm doesn't use libsensors so the location matters
> >> until it supports both locations too.
> > 
> > Recent versions of gkrellm (2.3.1 and later) do support libsensors, if
> > built properly.
> 
> openSUSE 11.2 provides 2.3.1. Changelog says, they upgraded to
> 2.3.1 about 2 years ago. But ldd /usr/gkrellm doesn't mention

Do you mean "ldd /usr/bin/gkrellm"?

> libsensors, although openSUSE 11.2 provides both v3 and v4.
> 
> So, looks like poor me is using a gkrellm without libsensors support.

I have double-checked with the relevant package maintainer and openSUSE
11.2 has gkrellm 2.3.2, not 2.3.1. And it definitely has libsensors
support.

So either you are running an older version of openSUSE, or you somehow
messed up your ldd command when checking.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
