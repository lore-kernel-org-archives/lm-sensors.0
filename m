From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 24 Jan 2013 09:51:04 +0000
Subject: Re: [lm-sensors] tap SMBus vis PCI slot?
Message-Id: <20130124105104.19a6a8ea@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAEGEQC+-T34gofYjZyGZ-NQtJK+smUghtbLXx-h5GgMbqO2FVQ@mail.gmail.com>
In-Reply-To: <CAEGEQC+-T34gofYjZyGZ-NQtJK+smUghtbLXx-h5GgMbqO2FVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 24 Jan 2013 10:17:17 +0100, Robert Smith wrote:
> I am interested in connecting my arduino to my motherboard's SMBus and I
> read the 'Hardware Hacking' web page here:
> 
> http://www.lm-sensors.org/wiki/HardwareHacking
> 
> It occurred to me that the SMBus pins are routed to the PCI slot pins
> A40/A41, so I figured it should be possible to modify a PCI riser card and
> use this to access the SMBus.
> 
> Just wondering if anyone has any experience to share regarding this as it
> wasn't mentioned as a possibility on the Hardware page it seems that it
> would be a lot simpler than modifying a DIMM since you can get riser cards
> which use ribbon cables.

I have not done that, but it should work, assuming the vendor actually
routed the SMBus signals to all PCI slots. I think they are supposed to
do so, but...

Alternatively, a number of motherboard models make the SMBus accessible
directly through pins, similar to extra USB port connectors. You should
check first if your board has this.

> FYI, with the Arduino I would like to create a PID fan controller which can
> access the motherboard sensors directly. It would also be able to
> control/read the motherboard's built in fan controller as well as control
> additional PWM fans, at least that's the idea.

I admit I am very skeptical how you intend to achieve this. Please
remember that the SMBus is not designed to be multi-master and thus you
have absolutely no guarantee that things will work if you attempt to
make the Arduino an SMBus master. I also see no way you can talk to
non-SMBus (e.g. LPC or CPU-embedded) sensors.

So you would need dedicated software on the host to periodically poll
and send all the information to the Arduino. At which point you might
as well have said software do the fan speed control by itself, assuming
the board includes fan speed controllers. Most do these days.

> I hope to also be able to configure the arduino from the PC via the SMBus
> and possibly feed it cpu load information if that is useful in controlling
> the fans... probably not necessary with the PID controller. It could be
> useful to be able to switch between different cooling profiles.

Happy hacking nevertheless :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
