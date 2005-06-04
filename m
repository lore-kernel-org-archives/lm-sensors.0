From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sat, 04 Jun 2005 00:50:09 +0000
Subject: [lm-sensors] [0/6] New w1 features.
Message-Id: <d120d50005060315492cc848af@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050604013008.05d3bc87@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050604013008.05d3bc87@zanzibar.2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 6/3/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> :) because USB controller will catch interrupt about new device attached.

It does not really matter how we discover a device. I am arguing to
what should be done once we know about it.

> 
> > Btw, that's what my modalias patch was doing for w1 as well.
> 
> yep. I liked your hotplug if you remember.
> But you broke too many other things.
> 

Not exactly, you just did not like a lot of things because you did not
want to let go of your first design.

> > If you don't bind to a driver to begin with you don't have to reconnect, do you?
> 
> And what to do with that device when there is no driver for it.
> Forget about it? This is wrong. Wait for driver and rescan the bus when it is added?
> This is wrong.

No,don;t forget. You just add a device to the bus. Without driver, that is it.

> Do not compare w1 with USB/scsi/PCI any other "advanced" buses, this is completely
> different things, so they just can not be compared.
> 
> Dmitry, I see this discussion goes wrong way again...
> Let's continue it from technical point:
> you want different w1 design - like USB for example,
> but it is completely wrong with w1 since
> [quite previous e-mail] we can perform the search only
> one time, and load a driver far after it. This is a feature,
> which you want to remove [again], which allows such behaviour,
> without it you just drop the device and just can not recall
> later about it without full rescan.[/quote].

No, that is not what I am saying or proposing to do. When you find a
device just add it to the master's bus, do not drop it. Just realize
that having a family attached to it is not required. It will be just a
device, without any attributes, sitting on the bus. When appropriate
family driver is loaded it will scan all devices (rather in-kernel
representation of them) and bind to ones it supports. Just like every
other bus.

Am I still being unclear as to what I propose?

-- 
Dmitry
