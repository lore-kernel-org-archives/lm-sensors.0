From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Sep 2010 08:03:05 +0000
Subject: Re: [lm-sensors] [PATCH] lm75: some optimisations
Message-Id: <20100913100305.28542955@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284052336-25864-1-git-send-email-shubhrajyoti@ti.com>
	<20100909175537.GA16681@ericsson.com>
	<20100909201128.3840431b@hyperion.delvare>
	<30674.1284351000@localhost>
In-Reply-To: <30674.1284351000@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Valdis.Kletnieks@vt.edu
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, Shubhrajyoti D <shubhrajyoti@ti.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, 13 Sep 2010 00:10:00 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 09 Sep 2010 20:11:28 +0200, Jean Delvare said:
> 
> > Please do NOT CC linux-kernel@vger.kernel.org. We have a mailing list
> > dedicated to hardware monitoring, there's no point to add to the 200,000
> > messages (literally) LKML gets every year. The more messages a list
> > gets, the fewer readers it has.
> 
> Any way to represent this in the MAINTAINERS file, so that people who come
> along in the fugure know that lm-sensors gets special handling in that regard?

Unfortunately not. The only way would be to convince the maintainers of
scripts/get_maintainer.pl to NOT unconditionally add LKML to its output.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
