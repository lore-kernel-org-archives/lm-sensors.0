From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 02 Apr 2006 21:15:30 +0000
Subject: [lm-sensors] [PATCH] remove the fix_hstcfg from i2c-piix4 -
Message-Id: <20060402231530.59f0587b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <442F00B8.6010507@sh.cvut.cz>
In-Reply-To: <442F00B8.6010507@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> This patch removes the fix_hstcfg option from the driver and related SMBus
> Interrupt Select register magic because now we know what are valid values
> for this register. This patch updates the documentation and adds new IRQ
> mode check so we are sure not to miss any new "unusual" value.
> 
> The PCI quirk for users of fix_hstcfg was not developed because the chipset
> lacks of subsystem ID registers and DMI is stated "To be filled". Impact to
> existing systems is minimal because the problem showed up on motherboards
> like 10 years back. On the other hand users of newer Serverworks and HT1000
> systems won't be misleaded by the message suggesting to try the fix_hstcfg
> any more.

Applied, thanks. I only changed the sample lspci line to use a real
OSB4 example (I have one.)

-- 
Jean Delvare

