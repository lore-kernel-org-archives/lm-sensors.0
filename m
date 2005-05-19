From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: i2c-amd756 and dual opteron sensors not foun
Message-Id: <20040226220437.28745abc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
In-Reply-To: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Please feel free to log onto this box - i'm sure I am just slowing
> you down.

Don't think that. More times also gives everyone an oportunity to have
more (and better) ideas ;)

> Hopefully this is good news (W83627THF found but not activated)

Not significant. Once the detection is bypassed, sensors-detect had to
say something about how he felt about the chip. "Not activated" wasn't
exactly good news.

I tried to forcibly enable the device. Looks like I did not break
anything, but the supposed address of the device (0x200) is empty :( So
it is probably not there at all.

There's nothing more I can do at the moment.

Two possible tracks:

1* Open the case and look for your monitoring chip. Maybe we are not
looking for the right thing. Visual confirmation would help.

2* Enable the AMD8111 SMBus. I have no idea how this can be done, but if
your monitoring chip is there, we won't reach it else.

Sorry I can't help more, this is simply at the limit of my knowledge of
the topic (wrong side of the limit, unfortunately...)

Maybe you can ask the motherboard manufacturer, or hardware supplier,
for information?

Good Luck.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
