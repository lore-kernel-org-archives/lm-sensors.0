From: mgreer@mvista.com (Mark A. Greer)
Date: Wed, 18 Jan 2006 22:06:00 +0000
Subject: [lm-sensors] [RFC] i2c: Combined ST m41txx i2c rtc chip driver
Message-Id: <20060118220600.GF15714@mag.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4378960F.8030800@varma-el.com> <20051115215226.4e6494e0.khali@linux-fr.org> <20051116025714.GK5546@mag.az.mvista.com> <20051219210325.GA21696@mag.az.mvista.com> <43A7D76E.5050008@varma-el.com> <20060111000912.GA11471@mag.az.mvista.com> <43C4D275.2070505@varma-el.com> <20060111161954.GB6405@mag.az.mvista.com> <43C5567C.8070106@varma-el.com>
In-Reply-To: <43C5567C.8070106@varma-el.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Volkov <avolkov@varma-el.com>
Cc: "Mark A. Greer" <mgreer@mvista.com>, Jean Delvare <khali@linux-fr.org>, adi@hexapodia.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 10:03:24PM +0300, Andrey Volkov wrote:
<snip>
> P.S. Jean, "i2c_master_send vs i2c_smbus_write_byte_data"
> problem still open.
> Could you made executive decision about it?

Hi Andrey,

I'm taking the roaring silence to mean nobody really cares so I don't
really have a problem going your way.  I'll submit a patch and if it
gets pooh-pooh'd, we can always change it back.

Stay tuned.

Mark

