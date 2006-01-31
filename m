From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 31 Jan 2006 21:03:33 +0000
Subject: [lm-sensors] wrong readings for w83627ehf on p5mt-m - solution
Message-Id: <20060131220333.54cad1e7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43DA95AC.70504@sh.cvut.cz>
In-Reply-To: <43DA95AC.70504@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexander,

> you are right  - there is w83792ad chip on board.
> I am sorry I did not see it  - but the lm_sensors did not even probe
> for it (see below). Please let me know if I am doing something wrong.

Asus has the habit to hide the W83792D/AD chip on their boards by
multiplexing the SMBus using arbitrary GPIO pins. This is why
sensors-detect fails to even see the chip.

We need additional information from Asus to work it out. They helped
Rudolf Marek a few times before already, so hopefully they'll help
again.

Thanks,
-- 
Jean Delvare

