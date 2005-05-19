From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: as99127f pwm registers
Message-Id: <20030724224729.1fed348d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722093411.25d749c5.khali@linux-fr.org>
In-Reply-To: <20030722093411.25d749c5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Well if the MBM user base is any indication then there are no
> side-effects using the bank switch, it did solve a lot of detection
> problems I got.  When I 1st started using this there where a few
> issues with bios's that asumed they where on bank 1 and did not check
> or put it to bank 1 after mbm set it to 0, but have no encountered
> that in ages :)

Well, what would happen if the chip there isn't really a w83781d or
clone? You would write 0 to a register and you don't know what can
result of this action. That's what I was thinking of. I suppose that it
is very, very unlikely that another chip would be in that address range,
pass two id checks and is *not* what you thought it was. However, I
think we will stick to our detection policy and not write anything to
the chip (which means we only detect the chip if a the bank is 0 at
start). We could improve things a bit and detect it with a lower
confidence value if the bank is 1 or 2.

> thanks for the url, will save that.

Note that the text isn't there yet. I'll take some time to add it
tomorrow.

> the voltages of MBM are in the voltage.ini so no code change needed
> either and you can rip them out if you want/need them, there are a lot
> of board specific voltages

Likewise, feel free to take a look at our sensors.conf file if there's
anything you can learn. We have few board specific configurations, but
some comments are very interesting.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
