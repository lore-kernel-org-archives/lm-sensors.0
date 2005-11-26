From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 10:51:19 +0000
Subject: [lm-sensors] Analogue Devices ADT7476ARQZ chip status
Message-Id: <20051126105212.51a1b259.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4387E587.20302@reub.net>
In-Reply-To: <4387E587.20302@reub.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Reuben,

> The board I have is an Intel D945PVSLKR, and it has two relevant i2c chips on 
> it.  There is an SMC LPC47M182 chip, but also an Analogue Devices ADT7476ARQZ 
> onboard near the CPU.  I suspect that the Analogue Devices chip is the more 
> useful chip of the two (see ticket comment by Khali).

It's "SMSC", and "Analog Devices". The LPC47M182 is not an "i2c chip".

> I have posted the rather lengthy output of sensors-detect up on my website at 
> http://www.reub.net/files/kernel/
> 
> There's a data sheet about this chip here:
> 
> http://www.analog.com/en/prod/0%2C2877%2CADT7476%2C00.html
> 
> If this chip is in fact unsupported, what can I do to help with getting it 
> supported and functional?

Please provide a dump of the Analog Devices chip:
i2cdump 0 0x2e b

-- 
Jean Delvare
