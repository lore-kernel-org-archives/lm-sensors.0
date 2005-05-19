From: jon@resfeber.se (Jon)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: Ticket # 986 (problems with loading i2c-amd756)
Message-Id: <20020829114236.145a8b1c.jon@resfeber.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020829104620.48164567.jon@resfeber.se>
In-Reply-To: <20020829104620.48164567.jon@resfeber.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry for mailbombing you like this, I've come one step forward but still get the same error. I had failed to do a correct install of lm_sensors-2.6.4 but have fixed that now so all the modules are new:
# ls -l /lib/modules/2.4.7-10custom/kernel/drivers/i2c/
total 236
-rw-r--r--    1 root     root        13476 Aug 29 10:33 i2c-algo-bit.o
-rw-r--r--    1 root     root         9740 Aug 29 10:33 i2c-algo-pcf.o
-rw-r--r--    1 root     root         8292 Aug 29 11:11 i2c-ali1535.o
-rw-r--r--    1 root     root         8508 Aug 29 11:11 i2c-ali15x3.o
-rw-r--r--    1 root     root         7344 Aug 29 11:11 i2c-amd756.o
-rw-r--r--    1 root     root        27784 Aug 29 10:33 i2c-core.o
-rw-r--r--    1 root     root         7884 Aug 29 10:33 i2c-dev.o
-rw-r--r--    1 root     root         6032 Aug 29 10:33 i2c-elektor.o
-rw-r--r--    1 root     root         4320 Aug 29 10:33 i2c-elv.o
-rw-r--r--    1 root     root         3672 Aug 29 11:11 i2c-hydra.o
-rw-r--r--    1 root     root         9352 Aug 29 11:11 i2c-i801.o
-rw-r--r--    1 root     root         5516 Aug 29 11:11 i2c-i810.o
-rw-r--r--    1 root     root         3040 Aug 29 11:11 i2c-isa.o
-rw-r--r--    1 root     root         6724 Aug 29 10:33 i2c-pcf-epp.o
-rw-r--r--    1 root     root         5244 Aug 29 10:33 i2c-philips-par.o
-rw-r--r--    1 root     root         8208 Aug 29 11:11 i2c-piix4.o
-rw-r--r--    1 root     root         4304 Aug 29 10:33 i2c-pport.o
-rw-r--r--    1 root     root        10600 Aug 29 10:33 i2c-proc.o
-rw-r--r--    1 root     root         4772 Aug 29 11:11 i2c-savage4.o
-rw-r--r--    1 root     root         7848 Aug 29 11:11 i2c-sis5595.o
-rw-r--r--    1 root     root         4096 Aug 29 10:33 i2c-velleman.o
-rw-r--r--    1 root     root         4496 Aug 29 11:11 i2c-via.o
-rw-r--r--    1 root     root         8396 Aug 29 11:11 i2c-viapro.o
-rw-r--r--    1 root     root         5828 Aug 29 11:11 i2c-voodoo3.o

But when I run depmod -a do I get 'Unresolved symbols in' for all new modules, here are some:
depmod: *** Unresolved symbols in /lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-amd756.o
depmod: *** Unresolved symbols in /lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-core.o
depmod: *** Unresolved symbols in /lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-dev.o
depmod: *** Unresolved symbols in /lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-elektor.o
depmod: *** Unresolved symbols in /lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-elv.o

So I guess I've done something wrong again. When I run sensors-detect I get these errors:
Load `i2c-amd756' (say NO if built into your kernel)? (YES/no): 
/lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-amd756.o: unresolved symbol schedule_timeout_R17d59d01
/lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-amd756.o: unresolved symbol pci_find_device_R04d7c705
/lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-amd756.o: unresolved symbol __check_region_Rf1d0cdab
/lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-amd756.o: unresolved symbol pcibios_present_R520a75b9
/lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-amd756.o: unresolved symbol __request_region_R1a1a4f09
/lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-amd756.o: unresolved symbol i2c_del_adapter_R97e1c952
/lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-amd756.o: unresolved symbol sprintf_R3c2c5af5
/lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-amd756.o: unresolved symbol ioport_resource_R865ebccd
/lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-amd756.o: unresolved symbol pci_read_config_word_R2482fae9
/lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-amd756.o: unresolved symbol __release_region_Rd49501d4
/lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-amd756.o: unresolved symbol printk_R1b7d4074
/lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-amd756.o: unresolved symbol i2c_add_adapter_Rd50a523b
/lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-amd756.o: unresolved symbol pci_read_config_byte_R2942b2b0
/lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-amd756.o: insmod /lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-amd756.o failed
/lib/modules/2.4.7-10custom/kernel/drivers/i2c/i2c-amd756.o: insmod i2c-amd756 failed
Loading failed ()... skipping.


Any idea what this may be?

/Jon




On Thu, 29 Aug 2002 10:46:20 +0200
Jon <jon@resfeber.se> wrote:

> Hi,
> 
> You wrote:
> --------------------------------------------
> did you do a make install?
> Your module is version 2.5.5 but your sensors-detect is version 2.6.4.
> Get rid of old modules, install new ones, you will be fine.
> ---------------------------------------------
> 
> I've don a make install in i2c-2.6.4 but it doesn't include an amd module, here's from todays make install:
>  ls -l /lib/modules/2.4.7-10custom/kernel/drivers/i2c/
> total 204
> -rw-r--r--    1 root     root        13476 Aug 29 10:33 i2c-algo-bit.o
> -rw-r--r--    1 root     root         9740 Aug 29 10:33 i2c-algo-pcf.o
> -rw-r--r--    1 root     root         7896 Feb  5  2002 i2c-ali15x3.o
> -rw-r--r--    1 root     root         6508 Feb  5  2002 i2c-amd756.o
> -rw-r--r--    1 root     root        27784 Aug 29 10:33 i2c-core.o
> -rw-r--r--    1 root     root         7884 Aug 29 10:33 i2c-dev.o
> -rw-r--r--    1 root     root         6032 Aug 29 10:33 i2c-elektor.o
> -rw-r--r--    1 root     root         4320 Aug 29 10:33 i2c-elv.o
> -rw-r--r--    1 root     root         3716 Feb  5  2002 i2c-hydra.o
> -rw-r--r--    1 root     root         9260 Feb  5  2002 i2c-i801.o
> -rw-r--r--    1 root     root         5620 Feb  5  2002 i2c-i810.o
> -rw-r--r--    1 root     root         3084 Feb  5  2002 i2c-isa.o
> -rw-r--r--    1 root     root         6724 Aug 29 10:33 i2c-pcf-epp.o
> -rw-r--r--    1 root     root         5244 Aug 29 10:33 i2c-philips-par.o
> -rw-r--r--    1 root     root         8224 Feb  5  2002 i2c-piix4.o
> -rw-r--r--    1 root     root         4304 Aug 29 10:33 i2c-pport.o
> -rw-r--r--    1 root     root        10600 Aug 29 10:33 i2c-proc.o
> -rw-r--r--    1 root     root         4096 Aug 29 10:33 i2c-velleman.o
> -rw-r--r--    1 root     root         4444 Feb  5  2002 i2c-via.o
> -rw-r--r--    1 root     root         8256 Feb  5  2002 i2c-viapro.o
> -rw-r--r--    1 root     root         5940 Feb  5  2002 i2c-voodoo3.o
> 
> Actually i can't find anything with amd ("find . -name '*amd*'") in the i2c-2.6.4 dir returns nothing. Do I have to download something else? The package I have is from your download section.
> 
> /Jon
