From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 12 May 2010 07:33:49 +0000
Subject: Re: [lm-sensors] after some days,
Message-Id: <20100512093349.0bcb5c09@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <g2p8cb75a4a1005110155u5b359f97z8e16ab5a2c475455@mail.gmail.com>
In-Reply-To: <g2p8cb75a4a1005110155u5b359f97z8e16ab5a2c475455@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 11 May 2010 11:39:33 +0200, Jean Delvare wrote:
> It would also be a good idea to disassemble the ACPI DSDT table to check
> whether APCI is poking at the hardware monitoring registers. If you
> send your table to me in private, I'll take a look.

I took a look, I see the BIOS is defining an I/O region as part of
PNP0C02 for the hardware monitoring chip (you probably can see it
in /proc/ioports), but it doesn't seem to make any use of it. So I
would rule out a BIOS interaction.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
