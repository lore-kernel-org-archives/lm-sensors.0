From: thomas@plx.com (Thomas Leibold)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [PATCH 2.6] i2c-nforce2.c add support for nForce3 Pro 150 MCP
Message-Id: <33599.192.168.0.19.1100773423.squirrel@192.168.0.12>
List-Id: <lm-sensors.vger.kernel.org>
References: <36129.192.168.0.19.1100598647.squirrel@192.168.0.12><hKBrMfMm.1100605629.3776330.khali@gcu.info><36881.192.168.0.19.1100639614.squirrel@192.168.0.12>
    <20041116222506.7c64e122.khali@linux-fr.org>
In-Reply-To: <20041116222506.7c64e122.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: greg@kroah.com
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

Hi Greg,

This is the all new and improved version of the patch:
- following the advise from Jean Delvare I removed the redundant definition
of the PCI IDs from the driver and just add them to the pci_ids.h file.
- the patch is now created against linux 2.6.10-RC2.

Signed-off-by: Thomas Leibold <thomas@plx.com>

> (As a side note I applied your 2.4 patch to lm_sensors CVS.)
>
>> This patch applies to linux 2.6.10-RC1. I tried to follow the
>> procedures in Documentation/SubmittingPatches and I hope I got
>> everything right.
>
> Looks good to me except:
>
>> @@ -53,6 +55,10 @@ MODULE_DESCRIPTION("nForce2 SMBus driver
>>  #define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS   0x0064
>>  #endif
>>
>> +#ifndef PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS
>> +#define PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS   0x00D4
>> +#endif
>> +
>> (...)
>> --- linux-2.6.10-rc1/include/linux/pci_ids.h	2004-11-16
>> 10:22:15.000000000 -0800
>> +++ patched/include/linux/pci_ids.h	2004-11-16 11:21:28.223690880 -0800
>> @@ -1081,6 +1081,7 @@
>>  #define PCI_DEVICE_ID_NVIDIA_NVENET_8		0x0056
>>  #define PCI_DEVICE_ID_NVIDIA_NVENET_9		0x0057
>>  #define PCI_DEVICE_ID_NVIDIA_CK804_AUDIO	0x0059
>> +#define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS	0x0064
>>  #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
>>  #define PCI_DEVICE_ID_NVIDIA_NVENET_2		0x0066
>>  #define PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO		0x006a
>> @@ -1092,6 +1093,7 @@
>>  #define PCI_DEVICE_ID_NVIDIA_NFORCE3		0x00d1
>>  #define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO		0x00da
>>  #define PCI_DEVICE_ID_NVIDIA_NFORCE3S  		0x00e1
>> +#define PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS	0x00d4
>>  #define PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE	0x00d5
>>  #define PCI_DEVICE_ID_NVIDIA_NVENET_3		0x00d6
>>  #define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO		0x00da
>
>
> You're correct that the IDs are better added to pci_ids.h, but then the
> ifndef blocks in the driver become useless and can be discarded.
>
> Thanks.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: nforce3_patch
Type: text/x-diff
Size: 2893 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041118/dbf10ed9/nforce3_patch.bin
