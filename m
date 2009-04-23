From: Marek Vasut <marek.vasut@gmail.com>
Date: Thu, 23 Apr 2009 18:11:28 +0000
Subject: Re: [lm-sensors] build issue #7 for v2.6.30-rc3 :defined but not
Message-Id: <200904232011.28308.marek.vasut@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200904232001.21042.toralf.foerster@gmx.de>
In-Reply-To: <200904232001.21042.toralf.foerster@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, lm-sensors@lm-sensors.org

On Thursday 23 of April 2009 20:01:20 Toralf F=C3=B6rster wrote:
> include/linux/ucb1400.h:139: warning: 'ucb1400_adc_read' defined but not
> used

include/linux/ucb1400.h:139: warning: 'ucb1400_adc_read' defined but not us=
ed

That function should probably go into ucb1400-core.c

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
