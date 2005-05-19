From: c479wy002@sneakemail.com (Geoffrey Hausheer)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: Issue getting sis630 i2c smbus driver to work
Message-Id: <3095-32877@sneakemail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <14164-38866@sneakemail.com>
In-Reply-To: <14164-38866@sneakemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Tue, 6 Jul 2004 10:59:16 +0200, "Alexander Malysh amalysh-at-web.de
|lm-sensors/1.0-Allow|" <ii2ui0fae60t@sneakemail.com> said:
> Hi,
> 
> please try attached patch...
> Thanks!
Thanks, this did indeed work, though when running sensors-detect, i get:
Next adapter: SMBus SIS630 adapter at 5080 (Algorithm unavailiable)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x10

..
Sorry, no chips were detected.
..

I assume this means that either (a) the laptop has no sensors, or (b)
they aren't supported by linux yet.  Is this a reasonable assertion?  Is
there anything I can do (short of disassembling my laptop) to help?

Thanks again,
.Geoff
