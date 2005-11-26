From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Sat, 26 Nov 2005 11:56:54 +0000
Subject: [lm-sensors] Analogue Devices ADT7476ARQZ chip status
Message-Id: <20051126105641.GC20399@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4387E587.20302@reub.net>
In-Reply-To: <4387E587.20302@reub.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 26 Nov 2005, Jean Delvare wrote:
> > The board I have is an Intel D945PVSLKR, and it has two relevant i2c chips on 
> > it.  There is an SMC LPC47M182 chip, but also an Analogue Devices ADT7476ARQZ 
> > onboard near the CPU.  I suspect that the Analogue Devices chip is the more 
> > useful chip of the two (see ticket comment by Khali).
> 
> It's "SMSC", and "Analog Devices". The LPC47M182 is not an "i2c chip".

Still, the LPC47M182 is an ISA interface chip and it has sensors in it (two
tachometer inputs), so while it is not i2c material, it could be supported
by hwmon/lm-sensors.

I *really* doubt Intel is using tachometer inputs on the LPC47M182 if they
have a ADT7476ARQZ on-board, though.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
