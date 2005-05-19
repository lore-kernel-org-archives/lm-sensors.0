From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: W83L785R Support
Message-Id: <20040221055108.58757f72.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200402201842.48537.coflynn@newae.com>
In-Reply-To: <200402201842.48537.coflynn@newae.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Colin O'Flynn:

> I'm interested in getting a W83L785R sensor working on my video card.
> I can read from it fine (I actually patched the SCL/SDA lines from the
> chip to my motherboard... I was having trouble getting the I2C bus on
> the video card detected) at address 0x2d.

What video card is it?

> I see there is already a driver under development for this device, is
> there any way I can find out the status and/or help?

Back in August 2003, Rudolf Marek was working on one.

Rudolf, do you have some working code you would like to share with Colin
and the lm_sensors project?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
