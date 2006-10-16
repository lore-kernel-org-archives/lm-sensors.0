From: r.marek@assembler.cz (Rudolf Marek)
Date: Mon, 16 Oct 2006 19:25:26 +0000
Subject: [lm-sensors] ADT7468 support
Message-Id: <4533DCA6.6020008@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Christoph Pittracher wrote:
> Hello list,
> what's the state in supporting the ADT7468 chip? I've got a Tyan mainboard 
> using this one and tried the lm85 adt7463 module forcing the address.
> I get valid FAN values (the voltage values seems ok too) but the temperature 
> values are completely wrong.
> 
> Is there ongoing support for the ADT7468? Anybody working on it?
> Should I try to hack a driver myself? If yes, patching the lm85 driver or 
> writing a completely new one?

Sorry all I know is just what Jean wrote:

(2004-04-10) Forcing the lm85 driver, chip adm1027, may work. We have an 
evaluation board.

Can you try to force the lm85 driver as the adm1027?

Thanks,

regards
Rudolf

