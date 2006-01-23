From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 23 Jan 2006 22:26:42 +0000
Subject: [lm-sensors] I switched from AMD XP TB to AMD Mobile
Message-Id: <43D55822.9020102@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello,

> I switched from AMD XP TB to AMD Mobile Barton on a GB 7n400e-l (it8217)
> and now CPU temp reading has gone to -74*C from the previous +45*C
> readings. In bios temp readings are just it's fine.. right now it looks
> as a diode (meaning auto selected by sensors) but if I change it to
> thermistor (which I doubt is the type in this MB) it just changes to
> +74*C or something similar, please tell me how to reset all-together
> sensors data about the diode/thermistor settings or to pastebin my
> config? there is no offset for cputemp in bios. Many thanks in advance!

Hmm thats really strange. Maybe the temp reading are inverted for some reason?

Please have a look to propper /etc/sensors.conf section
(look for:  compute temp1     (-15.096+1.4893*@), (@+15.096)/1.4893 ) or similar)

Maybe other people round can have some idea?

Regards,
Rudolf

