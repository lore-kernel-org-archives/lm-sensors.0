From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 18 Jan 2006 19:59:30 +0000
Subject: [lm-sensors] support for Asus K8N-DL
Message-Id: <43CE9E22.9090502@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43CE3DEF.9060207@cox.net>
In-Reply-To: <43CE3DEF.9060207@cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dave Shiels wrote:
> This is the Nvidia Crush chip output from lspci -v
> 00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
>         Subsystem: ASUSTeK Computer Inc.: Unknown device 8162
>         Flags: 66Mhz, fast devsel, IRQ 5
>         I/O ports at fc00 [size2]
>         I/O ports at 1c00 [sized]
>         I/O ports at 1c40 [sized]
>         Capabilities: [44] Power Management version 2


Hello,

What kernel are you using? (uname -a)

Did you run sensors-detect script?

If so, nvidia smbus was not detected? (or driver was not working?)
Please send us output of lspci -n

If you have nforce4 you can try following patch:
http://khali.linux-fr.org/devel/i2c/linux-2.6/i2c-nforce2-support-nforce4-mcp04.patch

If sensors-detect fail to find the chip W83792D (you must use lm-sensors version 2.9.2)
then you will need to upgrade the BIOS.

If any problems, contact us please,

regards,
Rudolf

