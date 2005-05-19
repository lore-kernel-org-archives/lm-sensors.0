From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: i2cdetect -l is broken
Message-Id: <20040213200509.462f04f9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040211213013.19dccfee.khali@linux-fr.org>
In-Reply-To: <20040211213013.19dccfee.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > But what about the linkages:
> > > 
> > > $ tree /sys/class/i2c-dev/
> > > /sys/class/i2c-dev/
> > > `-- i2c-0
> > >     |-- dev
> > >     |-- device -> ../../../devices/platform/i2c-0
> > >     `-- driver -> ../../../bus/i2c/drivers/i2c_adapter
> > > 
> > > $ tree /sys/class/i2c-adapter/
> > > /sys/class/i2c-adapter/
> > > `-- i2c-0
> > >     |-- device -> ../../../devices/platform/i2c-0
> > >     `-- driver -> ../../../bus/i2c/drivers/i2c_adapter
> > > 
> > > 
> > > You can match these devices up by looking at the 'device' symlink.
> > > 
> > > This works no matter what numbering scheme there currently is,
> > > right?
> > 
> > Yes, it looks like it does. But this requires that we walk both dirs
> > and compare the entries. Not something easy to do in C, either we
> > introduce data structures and have to handle memory allocations, or
> > we end up with a non-linear algorithm.

BTW: Now that I come to think of it, no, it doesn't work. It works in
your specific case because this isn't a PCI adapter. See these trees
with a PCI adapter instead:

i2c-dev
|-- i2c-0
|   |-- dev
|   |-- device -> ../../../devices/pci0000:00/0000:00:04.4
|   `-- driver -> ../../../bus/pci/drivers/vt596 smbus
`-- i2c-1
    |-- dev
    |-- device -> ../../../devices/platform/i2c-1
    `-- driver -> ../../../bus/i2c/drivers/i2c_adapter

6 directories, 2 files
i2c-adapter/
|-- i2c-1
|   |-- device -> ../../../devices/platform/i2c-1
|   `-- driver -> ../../../bus/i2c/drivers/i2c_adapter
`-- i2c-2
    |-- device -> ../../../devices/pci0000:00/0000:00:04.4/i2c-2
    `-- driver -> ../../../bus/i2c/drivers/i2c_adapter

6 directories, 0 files

Adapter i2c-2 matches dev i2c-0. At first sight, you'd say I can guess
that because both's device link point to PCI device
"pci0000:00/0000:00:04.4". But what if that PCI device has more than one
i2c bus? I'm lost, as i2cdetect is. So, unless I missed a thing, there
is no way to find out which adapter matched with which device in such a
case. I can go up to the PCI device, but am unable to pick the correct
i2c adapter once there.

But I may be missing the whole thing once again. As said earlier, I just
have no idea as to why there are two distincts numberings now while
there wasn't before.

> libsysfs should be able to help you out here.

Could be, but we don't want i2cdetect to need libsysfs (what about Linux
2.4 users?), and we also need the information from a Perl script.

(Thanks for pointing out the existence of it however; it could be of
much use for our future libsensors-new library.)

> > With our 2.4 system, the same operations was as simple as "cat
> > /proc/bus/i2c".
> 
> What did that show?

i2c-0   smbus           SMBus I801 adapter at 1880              Non-I2C SMBus adapter           
i2c-1   i2c             ADM1032 evaluation board                Bit-shift algorithm             

> Can you see if the numbers get out of sync:
> 	modprobe i2c_SOME_ADAPTER_DRIVER
> 	modprobe i2c_SOME_OTHER_ADAPTER_DRIVER
> 	modprobe i2c_dev
> 	rmmod i2c_SOME_ADAPTER_DRIVER
> 	modprobe i2c_SOME_ADAPTER_DRIVER
> 
> where you have both types of adapters in your system (like something
> and i2c-isa).  That should get your numbers out of sync on 2.6, right?

Yes, it does. Sensors refer to SOME_ADAPTER_DRIVER as i2c-2, while
i2cdump and i2detect refer to it as i2c-0.

> What happens on 2.4?

SOME_ADAPTER_DRIVER gets i2c-0 back as I load it the second time. No
desync, sensors and i2cdump both refer to it as i2c-0.

> > What I see from a user-space developer, user and support-guy point
> > of view is that this double numbering is a source of problems, and
> > I'd like to see it solved if possible.
> 
> Ok, can you come up with a patch that might solve this?

I don't think I can. I don't know anything about sysfs, and I don't know
anything about how the 2.4 drivers where handling the problem. I'm
probably the less qualified among us all for that task.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
