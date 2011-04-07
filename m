From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Apr 2011 08:36:21 +0000
Subject: Re: [lm-sensors] Any idea to support Fintek F71808A
Message-Id: <20110407103621.427c1809@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
In-Reply-To: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 7 Apr 2011 01:01:18 -0700, D.B. Tsai wrote:
> Thank you for clarification. But is it possible that when I/O ports is
> controlled by motherboard, the kernels can still "read" the
> information from the I/O ports rather than read and write data to I/O
> ports? I think in this case, at least, I can monitor my fan speed
> without really controlling the ports, and I think it's still safe.

Please don't top-post.

Unfortunately not, because almost all hwmon chips use an index/data I/O
port pair for register access. So you need to write to the index I/O
port even for register reads. And non-synchronized concurrent access to
such I/O port pair is disastrous.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
