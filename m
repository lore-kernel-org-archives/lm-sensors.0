From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: More on SMBus multiplexing
Message-Id: <20041024123557.744414cc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041023200215.38e375a1.khali@linux-fr.org>
In-Reply-To: <20041023200215.38e375a1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>

Replying to myself:

> As a kind of proof of concept, I did a fake i2c-i801-vaio module to
> virtualize the SMBus on my laptop (although it doesn't have a mux
> chip). It works just OK as far as I can tell. Of course the code is
> stupidly useless (the virtual adapter doesn't do anything more than
> dumbly redirect the calls to the physical bus), and lacks the mux
> client registration part, since there is no such chip. I think that
> the idea is clear though, and at least now we have code to comment on
> ;)

I find that I am unable to actually register the mux client. Odd, since
it worked OK on a 2.4 kernel, and several tries led me nowhere on 2.6
kernels. If anyone has sample code to just occupy a given I2C address on
a given bus, please share it with me.

However, why do we even need this? Looks far easier to simply exclude
the multiplexer address from the virtual busses (which we need to do
anyway). Nobody is supposed to access the physical bus directly (it's
not in the main adapters list anyway). Again, I see no reason to protect
us from something that is just never going to happen. This makes the
whole thing even more simple, exactly as in my demo code.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
