From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 02 Sep 2006 11:04:20 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060902130420.b6417e40.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David, Yuan,

> > Given that these 3 last chips (W83627HF, W83627EHF and W83627DHG) are
> > Super-I/O chips and are detected again later using a  more reliable
> > method, I suggest we drop the legacy detection method for them. I've
> > already done so for the ITE family some weeks ago. Objection anyone?
> 
> No objections here.

Good.

> > This confirms my earlier guess. Good. As I said before, we don't have
> > support right now, but support could be added to the w83627ehf driver
> > with relatively little effort. You'll have to wait until this happens.
> 
> From the Winbond website
> (http://www.winbond-usa.com/mambo/content/view/143/273/) there is one
> less Vin, and some VID I/O.

Here are my own comparison notes of some says ago:

* 8-bit VID instead of 6-bit
* No VIN4 (I don't know which one this is in the driver)
* Additional critical limit for the 3 temperature sensors - part of the
  automatic fan speed regulation interface

This was only after a quick glance, I could have overlooked something,
but all in all adding support for that chip should be pretty
straightforward.

> The datasheet is available by request
> only. But if Yuan Mu could send a datasheet, I would greatly
> appreciate it. In fact, Yuan, can you CC Jean on that? He will
> probably need it too.

I do have it already, our Winbond partners were kind enough to share it
with Rudolf Marek and me. But I cannot send it to you without the
express agreement of Yuan Mu or another Winbond representative, as the
datasheet is not public, as you found out yourself.

> I'd be happy to add the support. If Michael wouldn't mind testing the
> driver, we could get started.

Yuan, I would have added support for the W83627DHG myself but it seems
I am out of time. So I think we have a great opportunity if David does
have the time to add support. Can I share the datasheet with him? He
already contributed to our w83627ehf driver, I think we can trust him.

Thanks,
-- 
Jean Delvare

