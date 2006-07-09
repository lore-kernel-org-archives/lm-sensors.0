From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 09 Jul 2006 08:16:06 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <44B0BB46.8000209@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Sunil Kumar wrote:
> Hi Hans,
> 
> I am seeing these messages in the dmesg:
> 
> abituguru: timeout exceeded waiting for ready state
> abituguru: timeout exceeded waiting for ready state
> abituguru: timeout exceeded waiting for read state (bank: 34, sensor: 15)
> abituguru: CMD reg does not hold 0xAC after ready command
> abituguru: timeout exceeded waiting for read state (bank: 38, sensor: 2)
> abituguru: timeout exceeded waiting for ready state
> 

Hmm, were these messages close together in time, or now and then a message?

> I am not sure if they are related to a freeze I saw today. My machine
> wasn't
> being used and when I came back, it was frozen.

I seriously doubt the freeze and these messages are related. The uGuru
only uses 2 io ports todo all communication with the outside. So reading
the ports doesn't always get you the same register there is a sortoff
network protocol which you speak over the ports. These messages mean
that the uGuru failed to response within a reasonable time. Unfortunate
on some uGuru's this is quite normal. It seems the older the
Motherboard, the more often this happens (iow the buggier the uGuru
firmware).

Regards,

Hans

