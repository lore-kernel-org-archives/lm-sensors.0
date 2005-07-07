From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 07 Jul 2005 22:11:13 +0000
Subject: [lm-sensors] W83792D & Overtemperature LED on Supermicro
Message-Id: <42CD8C4F.8050204@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
In-Reply-To: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

It seems the chip was reset. If the first dump is really after reboot and second is really when the driver loads I must admit it is strange.
Please can you change

static int init;
to
static int init=0;

Maybe your kernel is not cleaning global data area...

Thanks

regards

Rudolf
