From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Sun, 05 Jun 2005 12:49:53 +0000
Subject: [lm-sensors] [0/6] New w1 features.
Message-Id: <20050605144922.44e35ef0@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050604013008.05d3bc87@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050604013008.05d3bc87@zanzibar.2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 4 Jun 2005 22:29:22 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> On Saturday 04 June 2005 15:18, Evgeniy Polyakov wrote:
> > On Sat, 4 Jun 2005 11:59:18 -0500
> > Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > 
> > > Right. So please change w1 core to _not_ drop devices if it can't find
> > > proper family driver. Do _not_ invent dummy/default family drivers. Just
> > > add the damn device to the bus - you know it's ID, that's all you need
> > > to add an entry to sysfs. It is OK if it does not have any (or only has
> > > default) attributes. When real driver binds it will create them.   
> > 
> > W1 core does not drop devices, it is unforgivable act for w1 with it's 
> > unability to inform new devices are plugged in.
> > 
> 
> However thet is exactly what was going on before Ben's patch.

They were reported in dmesg - information about found device was not dropped,
thought device was not in core.

> > We need some flag to mark _that_ device to be different from _those_ devices,
> > i.e. that _that_ device does not have a driver.
> > So now it has it's family id to be 0.
> > Before it has family = NULL and messages in dmesg.
> > I think Ben's change to support default family is right to have devices in sysfs.
> > 
> > You suggest to create sysfs default directory [there is only a name there]
> 
> Not really, I suggest calling device_register() and have w1 bus and
> driver model/sysfs core do all necessary work for me.
> 
> > for that device in sysfs, and it is _only_ what _is_ done for such devices.
> > Your suggestion _IS_ implemented :),  you just do not see it behind
> > "default family" and "reconnect" words.
> 
> Yes, the result is the same, I am having an issue with implementation.
> I'll try explaining my point again:
> 
> 1. You made a decision that there can't be a w1_slave registered in
>    with w1 core without a family driver attached - drivers w/o a driver
>    get dropped.
> 2. Ben realized that he'd like to see devices even if there is no proper
>    driver for them and introduced default family.  
> 3. You noticed the problem when proper driver is loaded the slave is not
>    bound to it and introduced reconnect.
> 
> 2 and 3 are kludges to work around of unfortunate decision 1. If you change
> w1 core to register devices as they appear and bind families as needed later
> you will realize that 2 and 3 are not needed at all. They just add code for
> no real gain.

It-already-is-like-you-describe :)
We can see the code:
w1_slave_found() is called with new device ID.
It searches for master and checks if this device is registered already.
If not, we go into w1_attach_slave_device().
w1_attach_slave_device():
allocates new slave device using kmalloc, fills couple of it's fields
[master, flags, regnum], initialise some paramters [completion, refcnt...],
searches for family driver for device, calls __w1_attach_slave_device().
__w1_attach_slave_device() initialises drvier, device and bus_id,
then calls device_register() and creates default sysfs file with it's name.
THAT IS ALL.
Exactly like you described :)


> I do not understand why you are so resistant to converting w1 to the standard
> driver model. It will work just fine with w1.
> 
> -- 
> Dmitry


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
