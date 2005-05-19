From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: 'sensors' never installed
Message-Id: <3EF48615.50808@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030615132841.54681.qmail@web40809.mail.yahoo.com>
In-Reply-To: <20030615132841.54681.qmail@web40809.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm not even going to attempt to answer any of the rest of it but for
an explanation of fan monitors and why anything below 2600 is 0 see doc/fan-divisors.

Brian Papantonio wrote:

> Also, since sensors.conf is useless, I suppose the
> answer to this question is "You can't" also: At fan
> speed set to lowest, fan2 (the only fan showing
> anything) is 0. At max it shows:
> 
> [root@localhost as99127f-i2c-0-2d]# cat < fan2
> 3000 5487
> 
> Anything below ~2600rpm shows 0 (when it does show a
> value, it is exactly what the mobo would report in the
> BIOS's hardware monitor). If this cannot be fixed, no
> biggie. The processor temperature is my main concern,
> as I generally do NOT have any computer monitor hooked
> up to the video card (I may even remove that), so I
> have to rely on this program to report the temperature
> to me.
> 
