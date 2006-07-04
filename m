From: multinymous@gmail.com (Shem Multinymous)
Date: Tue, 04 Jul 2006 10:26:56 +0000
Subject: [lm-sensors] [Hdaps-devel] Generic interface for accelerometers
Message-Id: <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060703124823.GA18821@khazad-dum.debian.net>
	 <20060704075950.GA13073@elf.ucw.cz>
In-Reply-To: <20060704075950.GA13073@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Henrique de Moraes Holschuh <hmh@debian.org>, Stelian Pop <stelian@popies.net>, Michael Hanselmann <linux-kernel@hansmi.ch>, hdaps-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On 7/4/06, Pavel Machek <pavel at ucw.cz> wrote:
> Just use input infrastructure and be done with that? You can do
> parking from userspace.

Will moving the hdapsd userspace daemon from sysfs polling to the
input infrastructure cause a noticable latency increase compared to
polling sysfs? This functionality is highly time-critical.

Also, there's a small issue with polling frequency. hdapsd needs a
fairly high frequency (say, 50Hz) to gather statistics and keep
response latency low, whereas the hdaps driver's internal polling
(routing to the input infrastructure) is currently done at only 20Hz.
We'll need to increase the latter, thereby slightly increasing system
load when hdaps isn't running.

In terms of magnitude, an hdaps readout takes ~70usec on average and
(very rarely) up to ~1msec. This is with the tp_smapi [1] patches to
hdaps, which add the checks and retries needed to ensure the readout
is valid.

BTW, can the driver tell when nothing is accessing its input device,
and avoid polling in that case?

  Shem

[1] http://thinkwiki.org/wiki/tp_smapi

