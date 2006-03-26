From: akpm@osdl.org (Andrew Morton)
Date: Sun, 26 Mar 2006 22:58:40 +0000
Subject: [lm-sensors] [PATCH 2.6.16-mm1 3/3] rtc: add support for m41t81
Message-Id: <20060326145840.5e578fa4.akpm@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <440B4B6E.8080307@sh.cvut.cz>
	<zt2d4LqL.1141645514.2993990.khali@localhost>
	<20060307170107.GA5250@mag.az.mvista.com>
	<20060318001254.GA14079@mag.az.mvista.com>
	<20060323210856.f1bfd02b.khali@linux-fr.org>
	<20060323203843.GA18912@mag.az.mvista.com>
	<20060324012406.GE9560@mag.az.mvista.com>
In-Reply-To: <20060324012406.GE9560@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: lm-sensors@lm-sensors.org, r.marek@sh.cvut.cz, khali@linux-fr.org, linux-kernel@vger.kernel.org

"Mark A. Greer" <mgreer at mvista.com> wrote:
>
>  +	struct i2c_msg msgs[] = {
>  +		{ save_client->addr, 0, 1, msgbuf },
>  +		{ save_client->addr, I2C_M_RD, 8, buf }

The

	.name = value,

form would be preferred.  It reduces the possibility of silent breakage if
someone changes struct i2c_msg.

