From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 14 Jun 2005 20:46:21 +0000
Subject: [lm-sensors] w83781d.o: Subclient 0 registration at address
Message-Id: <20050614204521.461ca2ba.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ef564dc05061302175b8427fd@mail.gmail.com>
In-Reply-To: <2ef564dc05061302175b8427fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sukhdeep,

> I booted the device using Win 2K HDD and ran SpeedFan over it. And the
> results were the same.
> At least the second chip is reading the fan speeds correctly. There
> are 4 external fans, and 2nd chip is reading out the fan speeds for
> the 3 of them.

You may need to change the clock dividers to get proper reading.

> And one more question ... Is it possible to configure the fan1,
> fan2... settings in sensors.conf for the two chips separately ?

It is under Linux 2.4, but unfortunately no more under Linux 2.6. Just
create sections with the full chip name:

chip "w83782d-i2c-0-29"

   label fan1 "Foo Fan"
   (...)

chip "w83782d-i2c-0-2d"

   label fan1 "Bar Fan"
   (...)

-- 
Jean Delvare
