From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: i2c-amd756 and dual opteron sensors not found
Message-Id: <20040226192512.074c3349.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
In-Reply-To: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Please edit sensors-detect. Look for the W83627THF definition array,
> > 
> > and
> > edit it:
> >
> > {
> >   name => "Winbond W83627THF Super IO Sensors",
> >   driver => "w83627hf",
> >   addrreg => 0x2e,
> >   exitreg => 0x2e,
> >   datareg => 0x2f,
> >   enter => [0x87, 0x87],
> >   devidreg => 0x20,
> >   devid => 0x82,
> >            ^^^^ write 0x90 instead
> >   logdevreg => 0x07,
> >   logdev => 0x0b,
> >   actreg => 0x30,
> >   actmask => 0x01,
> >   basereg => 0x60,
> >   exit => 0xaa,
> > },
> >
> > Then run sensors detect again and say Y to Super-I/O. Let me know if
> > sensors-detect now detects it.
> 
> Hi Jean
> 
> It does not:
> (...)

Now that I get what the value after the "Failed!" means, I understand
that I couldn't work anyway.

Please try replacing the value with 0xe9 instead. This will somewhat
force the detection, and sensors-detect will tell us a bit more (sort of
"if it was really a W83627THF, it would be in this state, at this
address"). If the details make sense, we'll continue.

If you did not do so yet, you can also try "isadump 0x295 0x296". Note
that this is potentially dangerous if it happens that this address is
used by something else (I think you can see in /etc/ioports to make sure
it's free).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
