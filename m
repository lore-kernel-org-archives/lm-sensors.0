From: Rudolf Marek <r.marek@assembler.cz>
Date: Mon, 15 Oct 2007 09:12:02 +0000
Subject: Re: [lm-sensors] 2.6.23.1 x86 hardware monitoring bug?
Message-Id: <47132EE2.1050208@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0710141526590.3935@p34.internal.lan>	<20071015025331.GA3676@jupiter.solarsys.private> <Pine.LNX.4.64.0710150406220.9867@p34.internal.lan>
In-Reply-To: <Pine.LNX.4.64.0710150406220.9867@p34.internal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, apiszcz@solarrain.com, lm-sensors <lm-sensors@lm-sensors.org>, linux-kernel@vger.kernel.org, Hans de Goede <j.w.r.degoede@hhs.nl>

Hi,

Most likely you have distro and custom libsensors installed on the system. (and 
different PATH for root)

Please check how many of libsensors libraries is installed.

Thanks,

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
