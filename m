From: reuben-lmsensors@reub.net (Reuben Farrelly)
Date: Sat, 26 Nov 2005 05:33:57 +0000
Subject: [lm-sensors] Analogue Devices ADT7476ARQZ chip status
Message-Id: <4387E587.20302@reub.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

A while ago I opened a support ticket for a chip which I believe is currently 
unsupported:

http://www.lm-sensors.org/readticket.cgi?ticket 43

It was suggested that I post more information to the mailing list, so here goes :)

The board I have is an Intel D945PVSLKR, and it has two relevant i2c chips on 
it.  There is an SMC LPC47M182 chip, but also an Analogue Devices ADT7476ARQZ 
onboard near the CPU.  I suspect that the Analogue Devices chip is the more 
useful chip of the two (see ticket comment by Khali).

I have posted the rather lengthy output of sensors-detect up on my website at 
http://www.reub.net/files/kernel/

There's a data sheet about this chip here:

http://www.analog.com/en/prod/0%2C2877%2CADT7476%2C00.html

If this chip is in fact unsupported, what can I do to help with getting it 
supported and functional?

Thanks,
Reuben

