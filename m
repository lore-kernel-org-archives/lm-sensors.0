From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Sep 2010 08:05:45 +0000
Subject: Re: [lm-sensors] Lack of fan sensor output after Ubuntu upgrade
Message-Id: <20100913100545.39816ffb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201009101529.26294.larsivar@igesund.net>
In-Reply-To: <201009101529.26294.larsivar@igesund.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 12 Sep 2010 12:32:13 -0700, Guenter Roeck wrote:
> On Sat, Sep 11, 2010 at 05:03:31AM -0400, Jean Delvare wrote:
> > BTW... A quick search reveals that several Dell XPS Studio laptops
> > embed an ITE IT8512 infra-red receiver chip. Probably not a
> > coincidence...
> > 
> You are right. IT8512E/F is a Super-IO chip from ITE, and it uses 0x8512 as chip ID.

How do you know for sure? Do you have a datasheet? Once we're sure we
can identify the chip reliably, support should be added to
sensors-detect.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
