From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: Regardding Ticket #: 1791
Message-Id: <5Zbpbyy8.1097737944.7496130.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c4ad5f$6d5d83c0$843f4853@jonathan>
In-Reply-To: <000001c4ad5f$6d5d83c0$843f4853@jonathan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>I sent you information about where to download source code for a IPMI
>bus. I have a question, Should I be able to get the temperature readings
>through lm_sensors if the driver works or am I supposed to find another
>program?

I don't know. All I vaguely know is that we have drivers named i2c-ipmi,
i2c-ipmb and bmcsensors which I think can be used to access the IPMI
data. I have no idea how well they work nor whether you need additional
stuff to get them to work. I never had to use this myself.

Jean
