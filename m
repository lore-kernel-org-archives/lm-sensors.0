From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sat, 02 Sep 2006 06:24:24 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <4dfa50520609012324q1a47aefdkd1d59f3f6fcc3d56@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Michael, and Yuan,

Yuan: can I request the W83627DHF/DHG datasheet?

> Given that these 3 last chips (W83627HF, W83627EHF and W83627DHG) are
> Super-I/O chips and are detected again later using a  more reliable
> method, I suggest we drop the legacy detection method for them. I've
> already done so for the ITE family some weeks ago. Objection anyone?

No objections here.

> This confirms my earlier guess. Good. As I said before, we don't have
> support right now, but support could be added to the w83627ehf driver
> with relatively little effort. You'll have to wait until this happens.

From the Winbond website
(http://www.winbond-usa.com/mambo/content/view/143/273/) there is one
less Vin, and some VID I/O. The datasheet is available by request
only. But if Yuan Mu could send a datasheet, I would greatly
appreciate it. In fact, Yuan, can you CC Jean on that? He will
probably need it too.

I'd be happy to add the support. If Michael wouldn't mind testing the
driver, we could get started.

David

