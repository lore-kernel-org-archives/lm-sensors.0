From: danielrj@mail.dk (Daniel Rune Jensen)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: lm_sensors i2c-amd756 detection trouble
Message-Id: <20031210145022.7216.DANIELRJ@mail.dk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031209143722.46F5.DANIELRJ@mail.dk>
In-Reply-To: <20031209143722.46F5.DANIELRJ@mail.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On Wed, 10 Dec 2003, Daniel Rune Jensen wrote:
> 
> > I have looked at the i2c-viapro module, and changed the i2c-amd756.c
> > source code so the module_init looks the same, but it still won't load.
> > Gives a:
> > /lib/modules/2.4.23/kernel/drivers/i2c/busses/i2c-amd756.o: init_module:
> > No such device
> > Can anyone clarify this for me ?
> 
> Maybe the  other driver has reserved the SMBus I/O region, either for a
> reason or due lazy programming. There should be something in the
> logfiles. If not,  compare output of the following with and without
> amd76x_pm to see what regions it claims. Or read the source..
> 
> cat /proc/ioports
> cat /proc/iomem
> /sbin/lspci -xxx
> 
> -- 
>   Ky?sti M?lkki  <kyosti.malkki@welho.com>

Been working on this for hours but not getting much further :)
Logs doesn't show much:
while apmd is not running
i2c-amd756.o version 2.8.1 (20031005)
i2c-amd756: SMBREV = 0x3
i2c-amd756: AMD756_smba = 0xE4E0

and when running it just gives a:

i2c-amd756.o version 2.8.1 (20031005)

Have compared output and only the one from lspci differs
Output from lspci -xxx  with apmd loaded

00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 7443 (rev 03)
00: 22 10 43 74 00 00 80 02 03 00 80 06 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 44 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 80 b1 09 42 00 00 00 00 aa 00 50 00 00 00 00 01
50: 01 80 00 00 0f 00 ab 4c 01 e4 00 00 00 00 00 00
60: 00 00 80 06 1f 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 44 80
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 8c 98 13 00 00 00 00 00 00 00 00 00 00 00 00 00


Output from lspci -xxx  without apmd loaded
00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 7443 (rev 03)
00: 22 10 43 74 00 00 80 02 03 00 80 06 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 44 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 80 b1 09 42 00 00 00 00 aa 00 50 00 00 00 00 01
50: 01 80 00 00 0f 00 ab 4c 01 e4 00 00 00 00 00 00
60: 00 00 80 06 1f 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 44 80
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: eb 0d 35 00 00 00 00 00 00 00 00 00 00 00 00 00

Output from lspci -xxx  with  i2c-amd756 loaded

00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 7443 (rev 03)
00: 22 10 43 74 00 00 80 02 03 00 80 06 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 44 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 80 b1 09 42 00 00 00 00 aa 00 50 00 00 00 00 01
50: 01 80 00 00 0f 00 ab 4c 01 e4 00 00 00 00 00 00
60: 00 00 80 06 1f 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 44 80
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 8f b0 30 00 00 00 00 00 00 00 00 00 00 00 00 00

as i am not a coder i really can't use this for much other than i can
see the last line is different :)

The code from i2c-amd756.c:
};

static int __init i2c_amd756_init(void)
{
        printk(KERN_INFO "i2c-amd756.o version %s (%s)\n", LM_VERSION, LM_DATE);
        return pci_module_init(&amd756_driver);
}


static void __exit i2c_amd756_exit(void)
{
        pci_unregister_driver(&amd756_driver);
        release_region(amd756_ioport, SMB_IOSIZE);
}

And the code with modifications:

static int __init i2c_amd756_init(void)
{
        struct pci_dev *dev;
        const struct pci_device_id *id;

        printk(KERN_INFO "i2c-amd756.o version %s (%s)\n", LM_VERSION, LM_DATE);

        return pci_module_init(&amd756_driver);
        pci_for_each_dev(dev) {
                id = pci_match_device(amd756_ids, dev);
                if(id)
                        if(amd756_probe(dev, id) >= 0)
                                return 0;
        }
        return -ENODEV;


}


static void __exit i2c_amd756_exit(void)
{
        pci_unregister_driver(&amd756_driver);
        release_region(amd756_ioport, SMB_IOSIZE);
}


Regards
Daniel


