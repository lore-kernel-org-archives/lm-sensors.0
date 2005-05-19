From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: Ticket#916
Message-Id: <3D13E641.5C14AA79@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D11A7DE.5010105@myezmail.com>
In-Reply-To: <3D11A7DE.5010105@myezmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I think you need -DMODVERSIONS.
Look in the top level Makefile, where it has the 'magic invocation'
for MODVER. THe p4b Makefile doesn't have anything like that.
Try adding that to the compile flags. You may need the modversions.h
too.

dyKa wrote:
> 
> Hi again, team!
> 
> Thanks for your fast reply! I still have some troubles on it... he are
> the results of my tests on the FAQ 3.9:
> 
> * nm --extern /lib/modules/2.4.16/misc/m7101.o
> 
>          U __check_region_Rf1d0cdab
> 00000060 ? __module_author
> 000000e0 ? __module_description
> 00000028 ? __module_parm_acpi_io
> 00000037 ? __module_parm_smb_io
> 00000410 T cleanup_module
> 00000240 T init_module
>          U ioport_resource_R865ebccd
>          U kfree_R037a0cba
>          U kmalloc_R93d4cfe6
>          U pci_enable_device_R944b5e42
>          U pci_find_device_R8b4d5816
>  >         U pci_insert_device
>          U pci_read_config_byte_R3bd38f74
>          U pci_read_config_word_R013f4ee4
>  >         U pci_remove_device
>  >         U pci_setup_device
>          U pci_write_config_byte_Rc19e8242
>          U pcibios_present_R520a75b9
>          U printk_R1b7d4074
> 
> * grep SYMBOL /proc/ksyms
> 
> c01bbec8 pci_setup_device_R__ver_pci_setup_device
> c01bb524 pci_insert_device_R__ver_pci_insert_device
> c01bb590 pci_remove_device_R__ver_pci_remove_device
> 
> There are no version numbers! What does it mean? I've compiled against
> the kernel I'm running. I'm thinking about moving to another kernel
> version, maybe a 2.5.x, but I don't know if that would help... Can you
> help me...again?
> 
> Regards, dyKa.
