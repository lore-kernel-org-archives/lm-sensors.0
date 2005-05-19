From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: join i2c ml + question
Message-Id: <3E2CAD17.10600@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E23FF51.3C9851D6@plain.de>
In-Reply-To: <3E23FF51.3C9851D6@plain.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the i2c mailing list is dead
for the sensors mailing list contact phil@netroedge.com

I don't think any of the sensors drivers use irq's.
There are a couple in the i2c package (grep irq kernel/*.c).
I don't know if any of them are anything good enough to use
for an example...
we are working on bringing our drivers in line with 2.4/2.5
standards, I'm not sure which of those is the closest
to your "elegant" standard...

mds


Markus Schorer wrote:
> hi,
> 
> i would like to join the linux-i2c ml.
> 
> and my question is: ;-)
> 
> i have a i2c controlled chip, that has a "data available" signal.
> i've connected it to an interrupt.
> how do i service the chip, eg read the data, in/from an interrupt?
> 
> is this a case for a bottom half? what options do i have?
> what is elegant?
> 
> regards,
> 
