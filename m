From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: need more than eeprom :)
Message-Id: <6sLVNW4x.1113335677.4223010.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <425C221D.5010909@lugmen.org.ar>
In-Reply-To: <425C221D.5010909@lugmen.org.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > > Probing for `Winbond W83627HF Super IO Sensors'
> > >   Success... found at address 0x0290
>
> 0295-0296 : pnp 00:0b

Recompile your kernel without CONFIG_PNPACPI.

http://bugme.osdl.org/show_bug.cgi?id@14

Then the w83627hf driver should actually work as intended.

--
Jean Delvare
