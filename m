From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 May 2011 11:47:21 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110507134721.415706a8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Harry, Ric and Jeff,

On Thu, 05 May 2011 10:40:28 -0600, Harry G McGavran Jr wrote:
> I can hope for an lm-sensors driver...

I found some time to work on EMC6W201 support and I have something for
you to test. My standalone driver for this chip can be downloaded from:
  http://khali.linux-fr.org/devel/misc/emc6w201/
You only need i2c-compat.h for kernels <= 2.6.32. I build-tested the
driver down to kernel 2.6.27, older kernels may or may not work.
emc6w201.conf is a template configuration file, copy to /etc/sensors.d
and add statements as needed. Generic build instructions are available
at:
  http://khali.linux-fr.org/devel/misc/INSTALL

At this point the driver only supports basic monitoring, in read-only
mode. It seems to work reasonably well on the dumps sent by Harry and
Jeff, but real hardware can behave differently.

Anyway, let me know how it goes.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
