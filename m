From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Sat, 04 Jun 2005 22:18:44 +0000
Subject: [lm-sensors] [0/6] New w1 features.
Message-Id: <20050605001803.289526ac@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050604013008.05d3bc87@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050604013008.05d3bc87@zanzibar.2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 4 Jun 2005 11:59:18 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> On Saturday 04 June 2005 04:50, Evgeniy Polyakov wrote:
> > On Fri, 3 Jun 2005 18:42:25 -0500
> > Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > 
> > > On Friday 03 June 2005 18:00, Evgeniy Polyakov wrote:
> > > > On Fri, 3 Jun 2005 17:49:45 -0500
> > > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > > > On 6/3/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > > > > Dmitry, I see this discussion goes wrong way again...
> > > > > > Let's continue it from technical point:
> > > > > > you want different w1 design - like USB for example,
> > > > > > but it is completely wrong with w1 since
> > > > > > [quite previous e-mail] we can perform the search only
> > > > > > one time, and load a driver far after it. This is a feature,
> > > > > > which you want to remove [again], which allows such behaviour,
> > > > > > without it you just drop the device and just can not recall
> > > > > > later about it without full rescan.[/quote].
> > > > > 
> > > > > No, that is not what I am saying or proposing to do. When you find a
> > > > > device just add it to the master's bus, do not drop it. Just realize
> > > > > that having a family attached to it is not required. It will be just a
> > > > > device, without any attributes, sitting on the bus. When appropriate
> > > > > family driver is loaded it will scan all devices (rather in-kernel
> > > > > representation of them) and bind to ones it supports. Just like every
> > > > > other bus.
> > > > > 
> > > > > Am I still being unclear as to what I propose?
> > > > 
> > > > It is exactly how things always worked and work now.
> > > > We have 64bit ID with some information that it is orphaned device 
> > > > [it's ->family->id = 0], so this device will be checked when new family
> > > > driver added and hopefully new attributes [which all live in one place
> > > > called w1_family] added. I called process of new attribute assignment
> > > > as "reconnection".
> > > > 
> > > > Exactly as you described.
> > > >
> > > 
> > > *Sigh* We keep talking past each other...
> > 
> > Yep...
> >  
> > > What I am saying is that your decision that every W1 slave device should
> > > be bound to a family is unfortunate one. It forces you to implement
> > > "default" family and _add_ more code to handle switchover.
> > > 
> > > I am proposing that you allow w1 slaves with ->family = NULL and let
> > > driver core to do the binding whenever a new family (driver) is being
> > > registered.
> > 
> > If we do not use default family [as it was] we can not know that device
> > exists, we can not see it in sysfs, but instead dmesg was filled with
> > "Family 81 is not registered" messages each tiem the same device is found.
> >
> 
> Right. So please change w1 core to _not_ drop devices if it can't find
> proper family driver. Do _not_ invent dummy/default family drivers. Just
> add the damn device to the bus - you know it's ID, that's all you need
> to add an entry to sysfs. It is OK if it does not have any (or only has
> default) attributes. When real driver binds it will create them.   

W1 core does not drop devices, it is unforgivable act for w1 with it's 
unability to inform new devices are plugged in.

We need some flag to mark _that_ device to be different from _those_ devices,
i.e. that _that_ device does not have a driver.
So now it has it's family id to be 0.
Before it has family = NULL and messages in dmesg.
I think Ben's change to support default family is right to have devices in sysfs.

You suggest to create sysfs default directory [there is only a name there]
for that device in sysfs, and it is _only_ what _is_ done for such devices.
Your suggestion _IS_ implemented :),  you just do not see it behind
"default family" and "reconnect" words.

Device has it's family id to be zero - nothing is created for sysfs 
[except default directory] or something, when driver is loaded, 
we find that device and set it's family id to be appropriate
number, so special sysfs files and attributes are added. 
 
> -- 
> Dmitry


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
