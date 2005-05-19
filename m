From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: questions on i2c-isa
Message-Id: <20040104225459.5122aecf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040104165323.4a824f59.khali@linux-fr.org>
In-Reply-To: <20040104165323.4a824f59.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It looks like when i2c-viapro is loaded, then via686a won't register.
> Maybe a PCI registration conflict?

Could be. But then why doesn't the conflict happen under 2.4 as well?
Also, if I load i2c-viapro after via686a, it does not fail (although it
doesn't work). On a resource conflict, I'd have expected the module not
to load at all!

The problem isn't critical anyway, since most users will need either
modules, not both. The via686a driver doesn't provide any useful
information to me, it's obviously not wired. But I'd like to help solve
the problem anyway, if it can be. Unfortunately, I'm low skilled on PCI
and even ISA stuff, so I don't know what I should do. Any hint please?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
