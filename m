From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 12:13:25 +0000
Subject: [lm-sensors] Analogue Devices ADT7476ARQZ chip status
Message-Id: <20051126121419.6afa5391.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4387E587.20302@reub.net>
In-Reply-To: <4387E587.20302@reub.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Henrique,

> > (...) The LPC47M182 is not an "i2c chip".
> 
> Still, the LPC47M182 is an ISA interface chip and it has sensors in it (two
> tachometer inputs), so while it is not i2c material, it could be supported
> by hwmon/lm-sensors.

True.

> I *really* doubt Intel is using tachometer inputs on the LPC47M182 if they
> have a ADT7476ARQZ on-board, though.

My point exactly, which is why I think we better don't waste time on
it. As I said in ticket #2043, the LPC47M182 is special in that the
hardware monitoring LDN (logical device number) depends on a
configuration bit. So even adding proper detection to sensors-detect
wouldn't be trivial.

-- 
Jean Delvare
