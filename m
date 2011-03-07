From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 07 Mar 2011 17:58:51 +0000
Subject: Re: [lm-sensors] tempX_source sysfs attribute needed ?
Message-Id: <20110307175851.GA14001@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110208171026.GE13717@ericsson.com>
In-Reply-To: <20110208171026.GE13717@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Mon, Mar 07, 2011 at 11:54:24AM -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> Sorry for the late reply.
> 
No problem. We are all busy ...

> On Tue, 8 Feb 2011 09:10:26 -0800, Guenter Roeck wrote:
> > in the recent months, I have seen two instances where a sysfs attribute 
> > identifying the source associated with a temperature sensor would have been 
> > helpful.
> > 
> > One is max6639. For this chip, the source of the second temperature channel
> > can be configured to be local or remote.
> > 
> > The others are W83677HG-B, NCT6775F, and NCT6776F. Those chips have four to six
> > temperature channels with a configurable source.
> > 
> > Current approach is to stick with whatever is configured by the BIOS for the Nuvoton
> > chips,
> 
> Definitely a good approach. For PC boards, we always assumed that the
> BIOS had configured that kind of things properly, and it is almost
> always the case.
> 
> > and to use the local source for the max6639 driver.
> 
> I guess that the local source is always available while the remote
> source isn't necessarily, and that dictated the decision? It makes some
> sense, but given that the hardware default is local, I'd rather just
> read the value from the configuration register, and trust it. It's
> either the hardware default and it is safe, or it was changed by the
> BIOS/firmware and can certainly be trusted.
> 
I'd have to ask the driver developer, but I guess that is what they use
on their board.

> > For the Nuvoton chips,
> > my prototype driver for NCT6775F and NCT6776F reports the temperature source 
> > in tempX_label.
> 
> I presume this can't hurt, as we usually don't have anything else to
> report here.
> 
> > Possible solutions might be:
> > - Stick with the current situation, ie do nothing.
> > - Use module parameters. Doesn't really work well for max6639 since it affects 
> >   all instances of the driver, and if the driver is built into the kernel.
> 
> Array parameters exist, and passing parameters to built-in modules is
> supported for years, so you don't really have an excuse if you want to
> go this way. That being said, we purposely got rid of this in i2c
> drivers are wide not so long ago, so I wouldn't encourage you to do
> that unless you really have to.
> 
> You may still look at driver thmc50 for a counter-example. Module
> parameter adm1022_temp3 is there for historical reasons, I don't think
> we would accept it if the driver was submitted for inclusion today.
> 
> > - Use platform data. Might work for max6639, but not for the Nuvoton chips.
> 
> For max6639 this would definitely be the right thing to do, if the
> kernel (not the BIOS/firmware) has to configure the device.
> 
Ok, I think I'll continue along that path. The parameter isn't there right now
in the max6639 driver, but it can be added anytime if needed. Plus, nowadays there
is also the option of using the device tree.

> > - Define a new sysfs attribute to make the temperature source configurable,
> >   and to report the current selection.
> 
> This seems very difficult and dangerous to me. Difficult because I'd be
> very surprised if you can find a stable standard for source
> identification. Each chip, each board will have its own possibilities.
> So it would be up to each driver to list what possible source values
> are valid. This doesn't seem to fit in the current sysfs interface /
> libsensors implementation. Not to say it can't be done, but it's not
> particularly appealing.
> 
> Dangerous because in many cases, only one configuration will be valid
> for the given hardware, so letting the user change it may result in
> an invalid setup, in turn leading to wrong temperature values, in turn
> leading to a confused user at best and a confused automatic fan speed
> control (with the potential to fry the hardware) in the worst case.
> 
Yes, I agree. This is too board specific to let the user configure it
during runtime.

> This is a generic problem, BTW, and the approach I have been advocating
> so far is to leave things unchanged, don't let the user change them,
> and simply report the chip-specific settings in the kernel logs if they
> are relevant. See the lm63 driver for example. This may sound limited,
> but apparently it worked well enough in practice and complaints have
> been few.
> 
> Back to the specific problem of temperature sources, we may not get
> away with it. I recall think along the same lines you're doing now when
> I started reviewing the fan control part of the w83795 driver. The chip
> doesn't map fans to real temperature channels, but to virtual ones,
> which are in turn mapped to real ones via a kind of multiplexer. It
> doesn't fit in our sysfs interface. Thankfully it only affected the
> automatic fan speed control tweaking, which I consider an optional
> feature.
> 
> I'll definitely have to look into it again someday, and maybe after
> reading your code for the NCT6775F and NCT6776F, I'll have a clearer
> view of what can be done. But don't hold your breath, it's nowhere near
> the top of my to-do list currently.
> 
Mine not either. Frankly, I pretty much forgot about it. Just too much to do.

Speaking about NCT6775F/NCT6776F - did you follow the fan debounce discussion ?
I advocated using a module parameter there, but your response above seems 
to suggest that this may not be the way to go (I still prefer it, though).
Other options would be a non-standard sysfs attribute or to always enable it.
It would help to get your input on this.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
