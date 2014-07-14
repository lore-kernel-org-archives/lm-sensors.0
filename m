From: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
Date: Mon, 14 Jul 2014 19:59:10 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon, k10temp: Add support for AMD F15h M60h processor
Message-Id: <53C4368E.9090103@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1405369388-12729-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
 <20140714195128.GA25124@pd.tnic>
In-Reply-To: <20140714195128.GA25124@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Borislav Petkov <bp@alien8.de>
Cc: clemens@ladisch.de, jdelvare@suse.de, linux@roeck-us.net, rdunlap@infradead.org, bhelgaas@google.com, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

On 7/14/2014 2:51 PM, Borislav Petkov wrote:
> On Mon, Jul 14, 2014 at 03:23:08PM -0500, Aravind Gopalakrishnan wrote:
>>   
>> @@ -211,6 +228,7 @@ static const struct pci_device_id k10temp_id_table[] = {
>>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_NB_F3) },
>>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M10H_F3) },
>>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M30H_NB_F3) },
>> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M60H_NB_F3) },
>>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
>>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
>>   	{}
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 7fa3173..3c8e328 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -520,6 +520,7 @@
>>   #define PCI_DEVICE_ID_AMD_15H_M10H_F3	0x1403
>>   #define PCI_DEVICE_ID_AMD_15H_M30H_NB_F3 0x141d
>>   #define PCI_DEVICE_ID_AMD_15H_M30H_NB_F4 0x141e
>> +#define PCI_DEVICE_ID_AMD_15H_M60H_NB_F3 0x1573
> I'm assuming this is used somewhere else besides k10temp.c?
>

Yeah, will most likely need to add EDAC bits. But that is something I 
can't test now.

So will have to do it only in due time.. :)

-Aravind.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
