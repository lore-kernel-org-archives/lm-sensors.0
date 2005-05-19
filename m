From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: fan control question
Message-Id: <Pine.LNX.4.58.0502051655550.7839@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050205151509.7b26200c.rkimber@ntlworld.com>
In-Reply-To: <20050205151509.7b26200c.rkimber@ntlworld.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> w83627thf-isa-0290

You can skip the driver initialization of the chip adding init parameter.

modprobe w83627hf init=0

In case the module loads automatically try to put
this line into /etc/modules.conf. Or disable somehow automatic loading.

options w83627hf init=0

I hope this helps.

Regards

Rudolf
