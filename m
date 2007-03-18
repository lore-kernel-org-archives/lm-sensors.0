From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Mar 2007 20:00:27 +0000
Subject: [lm-sensors] http://www.lm-sensors.org/ticket/2188
Message-Id: <20070318210027.f1567811.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703150941v6af08f75k7f8ef5dea70d8264@mail.gmail.com>
In-Reply-To: <191fb4ca0703150941v6af08f75k7f8ef5dea70d8264@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 18 Mar 2007 15:16:30 +0100, Hans de Goede wrote:
> General remarks:
> - i2x writes / read status never gets checked anywhere, I dunno if this is done
>    in other lm_sensors drivers similary, but IMHO these things should be
>    checked!

Most other I2C/SMBus hardware monitoring drivers indeed do not check
the status on I2C transactions and assume they were successful. This is
bad, but OTOH in a vast majority of cases it doesn't cause problem.
SMBus appears to be very reliable in practice.

Not to say that I do not encourage driver authors to check the status
of I2C transactions, but this is definitely not mandatory to get your
driver accepted in mainline.

-- 
Jean Delvare

