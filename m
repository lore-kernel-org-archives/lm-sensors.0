From: "Bart van Kuik" <lmsensors@vankuik.nl>
Date: Fri, 06 Jul 2007 16:33:44 +0000
Subject: Re: [lm-sensors] Odp:  Sensors working on DL360?
Message-Id: <40196.83.87.167.242.1183739624.squirrel@webmail4.transip.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <468e04f3cde05@wp.pl>
In-Reply-To: <468e04f3cde05@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Devices logo (white square with black triangle) in the middle of the chip.
> The top line says "1022" or "1022A" (it depends on chip revision).

Yeah, it's there and I made a photo of it. It's right in the middle of the
picture:

  http://www.vankuik.nl/download/1022a_on_compaq_dl360_motherboard

I found only one and I looked pretty thoroughly. Anyway, it's not even
_close_ to the CPU sockets (two sockets, one taken), a bit funny that.

Some ASCII art

 -------------Casing-------------
 |                              |
 |                              |
 |           --------           |
 |           |      |           |
 |           |      --Mobo----  |
 |           |               |  |
 |           |               |  |
 |           |               |  |
 |           |               |  |
 |           |           CPU0|  |
 |           | Sens          |  |
 |           |           CPU1|  |
 |           |               |  |
 |           |               |  |
 |           -----------------  |
 --------------------------------


I'm going to try and compile the patch.

B


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
