From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 04 Nov 2005 20:48:18 +0000
Subject: [lm-sensors] RE: Helps: how to use i801--SMBus functions via
Message-Id: <436BBADA.8090505@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
In-Reply-To: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Gu, Mingkun wrote:
> Could anyone advise how I can make use i2c-i801 and/or i2c-dev to access
> ICH6 SMBus controller on a PC motherboard? I have Linux 2.6.10 and
> loaded i2c-core, i2c-i801and i2c-dev modules. lsmod command gave me the
> following info:

> 
> It seems that i2c-i801 is not used by other modules.

This is OK.

If I understand it correctly all you want is to create the _userspace_ program that will send commands to the specific device on the bus.
If so please have a look to linux-2.6.x/Documentation/i2c/dev-interface


Further example could be found in lm-sensors package.
i2cdump.c   i2cset.c etc...

I hope this helps,

Regards
Rudolf

