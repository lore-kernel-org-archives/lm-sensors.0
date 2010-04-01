From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 01 Apr 2010 19:30:14 +0000
Subject: Re: [lm-sensors] lm-sensors with ASUS P6TD Deluxe and Ubuntu 9.04
Message-Id: <j2z68676e01004011230vc8ab779cy483e9bee60f8586a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001cad1d0$d5ea3820$81bea860$@org.uk>
In-Reply-To: <000001cad1d0$d5ea3820$81bea860$@org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 1, 2010 at 9:23 PM, Jon & Lisa Williams
<jon-lisa@doctors.org.uk> wrote:
> Hi,
>
> I make use of lm-sensors to monitor CPU core temps in Ubuntu 9.04 while
> running the Folding@Home project (it thrashes the CPU) – it’s been great
> with ASUS P5K and P5Q skt 775 motherboards!
>
> However, I’ve moved to a skt 1366 motherboard, the ASUS P6TD Deluxe (like
> many other ‘Folders’), and I can’t get lm-sensors to work.

I suspect that you're seeing this:
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31

> someone on the
> official Folding Forum has said that even this doesn’t support the P6TD – is
> that right?

asus_atk0110 driver should be able to handle the monitoring (but it
does not support direct fan control); if it doesn't work please report
back so I can fix it :-)

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
