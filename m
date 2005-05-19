From: christophe.dr@free.fr (christophe)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <200502172312.35401.christophe.dr@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I plead guilty for one confusion i did. I did use the printk stuff :

> if (dev->device = PCI_DEVICE_ID_INTEL_82855PM_HB)
>     switch (dev->subsystem_device) {
>     case 0x184b: /* W1N notebook */
>     case 0x186a: /* M6Ne notebook */
>         asus_hides_smbus = 1;
> +       printk(KERN_INFO "*** PCI QUIRK DONE!\n");
>     }

And i realised that when adding the patch manually to the 2.6.8.1 kernel, 
although it was a patch done for kernel 2.6.10, i inserted the "case" lines 
for w1n in the wrong if section. I inserted it for the 
PCI_DEVICE_ID_INTEL_82855GM_HB when it was for PCI_DEVICE_ID_INTEL_82855PM_HB
                        ***                                        ***
I made this mistake because in the quirks.c file there are only the first 
section for kernel 2.6.8.1
Thank you Jean Delvare for your patch.

So now the patch is correctly applied and could run sensors-detect 
successfully.
Actually, sensors-detect did not detect the adt7463 chip. But i added 
everything in the config files to insert automatically the lm85 modules, 
without any parameters, when the lm_sensors service is started.
So now, i can reduce manually the fan speed and have a longer battery time.

One more question : is there a way to adjust fan speed to one of the 
temperature ?
Or do i have to write a little script ?
Why can't i modify the content of 
the /sys/bus/i2c/devices/0-002e/fan1_pwm_enable (it contains '1') ?
What is the purpose of these fan*_pwm_enable files ?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCFRbSoBxdxgioZBIRAj3rAJ9n0vjbWWOQ12kwbhvb1Kfv4G1jowCeLKeh
vQ9jvFDE6q7XBPaydCh88Tk=kqLe
-----END PGP SIGNATURE-----
