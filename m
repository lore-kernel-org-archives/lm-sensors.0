From: Clemens Ladisch <clemens@ladisch.de>
Date: Mon, 14 Jul 2014 20:21:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon, k10temp: Add support for AMD F15h M60h processor
Message-Id: <53C43BDF.2070403@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1405369388-12729-1-git-send-email-Aravind.Gopalakrishnan@amd.com> <20140714195128.GA25124@pd.tnic>
In-Reply-To: <20140714195128.GA25124@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, jdelvare@suse.de, linux@roeck-us.net, rdunlap@infradead.org, bhelgaas@google.com, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

Borislav Petkov wrote:
> On Mon, Jul 14, 2014 at 03:23:08PM -0500, Aravind Gopalakrishnan wrote:
>> +	if (boot_cpu_data.x86 = 0x15 && boot_cpu_data.x86_model = 0x60) {
>> +		pci_bus_write_config_dword(pdev->bus, PCI_DEVFN(0, 0),
>> +					   NB_SMU_IND_ADDR, IND_ADDR_OFFSET);
>> +		pci_bus_read_config_dword(pdev->bus, PCI_DEVFN(0, 0),
>> +					  NB_SMU_IND_DATA, &regval);

How do you prevent races with any other code that accesses some indirect
register?

>> +
>> +	} else
>> +		pci_read_config_dword(pdev, REG_REPORTED_TEMPERATURE, &regval);

Why the empty line?  Also, use braces in both branches.


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
