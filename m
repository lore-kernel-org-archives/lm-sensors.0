From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: More on SMBus multiplexing
Message-Id: <8p5D89Tq.1099558397.0373510.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041023200215.38e375a1.khali@linux-fr.org>
In-Reply-To: <20041023200215.38e375a1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Greg,

> > On second thought, don't. As I said on LKML this morning, my autoload
> > code doesn't work and we will have to stick to manual loading for now.
> > I'll provide a simplified patch that does this tomorrow.
> >
> > Thanks and sorry for the trouble.
>
> Heh, glad I've been putting i2c patches off for a while, it payed off
> here :)

Hehe, true enough. That said, I think you have been curiously silent
about the SMBus multiplexing issue. Care to tell me if the last approach
I am proposing (minus the autoloading) is fine with you? If you don't
want to comment on the i2c part of it, please at least tell me if it is
acceptable kernel-wise.

Thanks,
Jean
