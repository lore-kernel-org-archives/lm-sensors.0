From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Dec 2005 18:39:17 +0000
Subject: [lm-sensors] [PATCH 3/3] i386: CS5535 chip support - SMBus
Message-Id: <20051218193917.1a021ac7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512070934m25fb4a10pd0df8702b9228f2a@mail.gmail.com>
In-Reply-To: <808c8e9d0512070934m25fb4a10pd0df8702b9228f2a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> > Why not extend that driver then, rather than having a separate one?
> (...)
> I started off thinking that the two wouldn't be compatible... and
> never re-examined what I was doing.
> Oh, well. I hope I didn't waste too much of your time!

No worry. It's still better to realize it now than having duplicated
code with twice as much maintenance work.

Thanks,
-- 
Jean Delvare

