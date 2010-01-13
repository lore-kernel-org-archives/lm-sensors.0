From: Andriy Gapon <avg@icyb.net.ua>
Date: Wed, 13 Jan 2010 08:19:30 +0000
Subject: Re: [lm-sensors] Status/support for Linux HECI from Intel? (for
Message-Id: <4B4D8212.6080806@icyb.net.ua>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.1.10.0812300700410.11356@p34.internal.lan>	 <4964DB3E.6080908@intel.com>	 <alpine.DEB.1.10.0901071142200.29147@p34.internal.lan>	 <1231356111.6648.2.camel@maxim-laptop> <49937CDF.10307@frugalware.org>	 <alpine.DEB.1.10.0902121236120.19381@p34.internal.lan> <1820d69d1001040551k26cfd925q4ada6b226740ac30@mail.gmail.com>
In-Reply-To: <1820d69d1001040551k26cfd925q4ada6b226740ac30@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gabriel C <nix.or.die@googlemail.com>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, Gabriel C <crazy@frugalware.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Dan Williams <dan.j.williams@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

on 04/01/2010 15:51 Gabriel C said the following:
> @Andriy there is a smallish bug in your original code .. you should
> use ..... , abs(value) ...., abs(value) ...);
> that will solve the negative CPU TEMP values you get with your version.

I wasn't sure about this, my impression was that negative temperatures were
offsets from some threshold.  E.g. Tcur - Tcrit.  In my case I saw negative
temperature only for CPU which fitted the hypothesis.

-- 
Andriy Gapon

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
