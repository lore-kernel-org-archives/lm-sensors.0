From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <bIubQY3G.1108552552.1010050.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Christophe,

> Well there must be something wrong, because no 00:0f.3 device.
> Is there a way to check if this quirk has been "tried" by the kernel ?
> Any log to check ?
> I tried "tail -2000 /var/log/syslog | grep -i quirk" : no output.
> I tried "tail -2000 /var/log/syslog | grep -i pci" : long output that i
> don't know how to decypher, but nothing about a 00:0f.3 device...

No, quirks don't leave any trace in the logs.

However, you could easily add some printk at the location you added code
to yesterday. Something like that:

if (dev->device = PCI_DEVICE_ID_INTEL_82855PM_HB)
    switch (dev->subsystem_device) {
    case 0x184b: /* W1N notebook */
    case 0x186a: /* M6Ne notebook */
        asus_hides_smbus = 1;
+       printk(KERN_INFO "*** PCI QUIRK DONE!\n");
    }

Feel free to also add a printk in the asus_hides_smbus_lpc function
(which is the second part of the trick). Unless the two printk messages
show in your logs, the quirk has not triggered as expected.

> Yes i enabled the hotplug support but as a module and i am quite confused
> about it, because i don't know which module i am supposed to load and with
> which parameters.

I am surprised. Hotplug is a configuration flag, it cannot be made a
module as far as I know. What I am talking about is named exactly
"Support for hot-pluggable devices" and is found in "General setup".
If you have this enabled I think it's all you need.

> OK, so right now the goal is to find a way to make the kernel discover a
> device on the pci bus. Am i right ?

Exactly. Once the new device is found, you should be able to load
i2c-i801, which is your SMBus controller driver.

> I hope that kernel 2.6.8.1 can do that. It seems to be just a matter of
> finding a device on the pci bus. There must be a way to do it with 2.6.8.1.
> You suggest pci hotplug. Is it a hotplugable device that we need to find ?

The device isn't (it is already on your motherboard) but the fact that
the BIOS disabled it and we re-enable it afterwards may make the kernel
see it as if it were hotplugged. But I am not sure either.

> Are we looking for a smbus controller ?

Yes we are.

> Sorry about my newbie questions, but i like to learn.

No problem :)

--
Jean Delvare
