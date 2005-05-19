From: danielrj@mail.dk (Daniel Rune Jensen)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: Fw: Re: lm_sensors i2c-amd756 detection trouble
Message-Id: <20040215033138.B1B9.DANIELRJ@mail.dk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031209143722.46F5.DANIELRJ@mail.dk>
In-Reply-To: <20031209143722.46F5.DANIELRJ@mail.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


----------------------- Original Message -----------------------
 From:    Daniel Rune Jensen <danielrj@mail.dk>
 To:      Mark Studebaker <mds@paradyne.com>
 Date:    Sat, 14 Feb 2004 17:41:35 +0100
 Subject: Re: lm_sensors i2c-amd756 detection trouble
----

> please let us know your results after you have commented out the
> offending line.
> It should work.
> 
Reported to work some time ago :) As i would like to see changes go into
the package i will now try to submit a .diff for 2.8.4 which allows
amd756 to be loaded together with amd76x_pm.o:

i2c-amd756.diff
*** i2c-amd756.c        Sun Dec 14 18:19:30 2003
--- i2c-amd756.c        Thu Jan 22 16:25:32 2004
***************
*** 396,418 ****
--- 396,436 ----
        i2c_del_adapter(&amd756_adapter);
  }

+ /* Don't register driver to avoid driver conflicts */
+ /*
  static struct pci_driver amd756_driver = {
        .name           = "amd756 smbus",
        .id_table       = amd756_ids,
        .probe          = amd756_probe,
        .remove         = __devexit_p(amd756_remove),
  };
+ */

  static int __init i2c_amd756_init(void) 
  {
+         struct pci_dev *dev;
+         const struct pci_device_id *id;
+   
        printk(KERN_INFO "i2c-amd756.o version %s (%s)\n", LM_VERSION, LM_DATE);
+ /*
        return pci_module_init(&amd756_driver);
+ */
+       pci_for_each_dev(dev) {
+                 id = pci_match_device(amd756_ids, dev);
+                 if(id)
+                         if(amd756_probe(dev, id) >= 0)
+                                 return 0;
+         }
+         return -ENODEV;
+
  }


  static void __exit i2c_amd756_exit(void)
  {
+ /*
        pci_unregister_driver(&amd756_driver);
+ */
        release_region(amd756_ioport, SMB_IOSIZE);
  }
Regards

-- 
Daniel Rune Jensen <danielrj@mail.dk>

--------------------- Original Message Ends --------------------

-- 
Daniel Rune Jensen <danielrj@mail.dk>
