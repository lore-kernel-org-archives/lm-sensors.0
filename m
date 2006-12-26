From: juergh@gmail.com (Juerg Haefliger)
Date: Tue, 26 Dec 2006 14:25:03 +0000
Subject: [lm-sensors] HP Compaq ProLiant DL380 detect failure
Message-Id: <191fb4ca0612260625n3ff8b97fh12fdcd8bc25715b8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4568C502.6070305@lymenet.org>
In-Reply-To: <4568C502.6070305@lymenet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> Thanks for the proposal. Basically we want to know what hardware
> monitoring chips are used in the system, and how they are wired. I
> suspect that HP uses a non-standard I2C bus, possibly GPIO-driven.

If I'm not totaly mistaken it's all controlled by the proprietary iLO
ASIC which shows up as a PCI device. I don't know the interface to
that beast and how temp and sensors are connected to it. I'll check
the schematics as soon as I have established connection to the HP
intranet. I'm currently slacking away in Switzerland but am supposed
to work remotely... :-)
Not a big deal until it starts snowing...

...juerg


> Thomas, I've thought a bit more about your problem, and I'm now almost
> certain that you won't find anything attached to your motherboard's
> SMBus, even if you upgrade the BIOS or force the SMBus base address.
> You said that the "hplog" utility was printing temperature values, so
> it must get them from somewhere, and it definitely can't get them from
> anything connected to the currently disabled SMBus. So there has to be
> another, non-standard I2C bus somewhere on the board.
>
> --
> Jean Delvare
>

