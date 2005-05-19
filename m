From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: lm_sensors i2c-amd756 detection trouble
Message-Id: <20031210223954.7cecfef9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031209143722.46F5.DANIELRJ@mail.dk>
In-Reply-To: <20031209143722.46F5.DANIELRJ@mail.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> And the code with modifications:
> 
> static int __init i2c_amd756_init(void)
> {
>         struct pci_dev *dev;
>         const struct pci_device_id *id;
> 
>         printk(KERN_INFO "i2c-amd756.o version %s (%s)\n", LM_VERSION,
>         LM_DATE);
> 
>         return pci_module_init(&amd756_driver);
          ^^^^^^

That return in the middle of the function might explain why you don't
see the change... ;) Strange if gcc did not tell you about that.

>         pci_for_each_dev(dev) {
>                 id = pci_match_device(amd756_ids, dev);
>                 if(id)
>                         if(amd756_probe(dev, id) >= 0)
>                                 return 0;
>         }
>         return -ENODEV;
> 
> 
> }

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
