From: danielrj@mail.dk (Daniel Rune Jensen)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: lm_sensors i2c-amd756 detection trouble
Message-Id: <20031211004207.721A.DANIELRJ@mail.dk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031209143722.46F5.DANIELRJ@mail.dk>
In-Reply-To: <20031209143722.46F5.DANIELRJ@mail.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On Wed, 10 Dec 2003, Daniel Rune Jensen wrote:
> 
> > static int __init i2c_amd756_init(void)
> > {
> >         struct pci_dev *dev;
> >         const struct pci_device_id *id;
> >
> >         printk(KERN_INFn 0;
> >         }
> >         return -ENODEV;
> >
> >
> > }
> >
> >
> > static void __exit i2c_amd756_exit(void)
> > {
> >         pci_unregister_driver(&amd756_driver);
> >         release_region(amd756_ioport, SMB_IOSIZE);
> > }
> 
> Comment out pci_module_init and pci_unregister_driver. This was the
> critical change of not claiming the complete PCI device in i2c-viapro
> and others.
> 
> -- 
>   Ky?sti M?lkki  <kyosti.malkki@welho.com>

Oh must really have been sleeping, did not notice it was uncommented.
And yes it actually seems to work now, thanx a lot for your help.
Here is the code which i changed, and finnaly got to work:

starting on line 400: (cvs version 10/12-2003)

/* Don't register driver to avoid driver conflicts */
/*
static struct pci_driver amd756_driver = {
        .name           = "amd7xx smbus",
        .id_table       = amd756_ids,
        .probe          = amd756_probe,
        .remove         = __devexit_p(amd756_remove),
};
*/

static int __init i2c_amd756_init(void)
{
        struct pci_dev *dev;
        const struct pci_device_id *id;
 
        printk(KERN_INFO "i2c-amd756.o version %s (%s)\n", LM_VERSION, LM_DATE);
/*
        return pci_module_init(&amd756_driver);
*/
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
/*
        pci_unregister_driver(&amd756_driver);
*/
        release_region(amd756_ioport, SMB_IOSIZE);
}

MODULE_AUTHOR("Merlin Hughes <merlin@merlin.org>");
MODULE_DESCRIPTION("AMD756/766/768/8111 and nVidia nForce SMBus driver");
MODULE_LICENSE("GPL");

module_init(i2c_amd756_init)
module_exit(i2c_amd756_exit)

Regards
Daniel




