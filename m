From: =?utf-8?Q?G=C3=B6ran_Uddeborg?= <goeran@uddeborg.se>
Date: Sat, 13 Apr 2013 19:09:30 +0000
Subject: Re: [lm-sensors] Configuration for Foxconn A7GM-S 2.0
Message-Id: <20841.44394.271036.543749@freddi.uddeborg>
List-Id: <lm-sensors.vger.kernel.org>
References: <20556.55176.173597.530756@freddi.uddeborg>
In-Reply-To: <20556.55176.173597.530756@freddi.uddeborg>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

G=F6ran Uddeborg:
> Jean Delvare:
> > Then for the wiki version of your configuration file, we won't ignore
> > any input. Better print 0 RPM than omit a running fan.
>=20
> Yes, that makes sense.  I'll try to remember to check next time I have
> the box open for some reason which one is the chassis fan.

It's been a while since I wrote that, but I actually haven't had
reason to open the case since then.  Not until today, and when I did I
took the opportunity to test which sensor was connected to the socket
on the board.  It turned out to be fan2.  So now I can give the last
bits of information to make the setup for the Foxconn A7GM-S 2.0
motherboard complete:

      label  fan1  "CPU fan"
      label  fan2  "Chassis fan"
      ignore fan3

Better late than never! :-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
