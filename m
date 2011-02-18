From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Feb 2011 12:09:45 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of AMD
Message-Id: <20110218130945.0e706bbc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 17 Feb 2011 11:56:40 -0800, Guenter Roeck wrote:
> Index: CHANGES
> =================================> --- CHANGES	(revision 5932)
> +++ CHANGES	(working copy)
> @@ -27,6 +27,7 @@
>                          EMC1072, EMC1073, EMC1074, EMC1402, and EMC1424
>                    Fixed address ranges checked for SMSC EMC1403 and EMC1404.
>                    Fix detection of SPD EEPROM on DDR3 memory modules
> +                  Add detection of AMD family 12h and 14h thermal sensors
>  
>  3.2.0 (2010-10-10)
>    libsensors: Increase MAX_SENSORS_PER_TYPE to 24
> Index: prog/detect/sensors-detect
> =================================> --- prog/detect/sensors-detect	(revision 5932)
> +++ prog/detect/sensors-detect	(working copy)
> @@ -2128,6 +2128,10 @@
>  		driver => "k10temp",
>  		detect => \&fam11h_pci_detect,
>  	}, {
> +		name => "AMD Family 12h and 14h thermal sensors",
> +		driver => "k10temp",
> +		detect => \&fam12h_14h_pci_detect,
> +	}, {
>  		name => "Intel digital thermal sensor",
>  		driver => "coretemp",
>  		detect => \&coretemp_detect,
> @@ -6028,6 +6032,12 @@
>  	return 9;
>  }
>  
> +sub fam12h_14h_pci_detect
> +{
> +	return unless exists $pci_list{'1022:1703'};
> +	return 9;
> +}
> +
>  sub intel_amb_detect
>  {
>  	if ((exists $pci_list{'8086:25f0'}) ||	# Intel 5000
> 

The code looks good and the ID is in line with Clemens' patch. Please
commit and update wiki/Devices accordingly [1].

That being said, I'm a little curious about a couple things. Why
PCI_DEVICE_ID_AMD_CNB17H_F3 and PCI device ID 0x1703 if the supported
CPUs are family 12h and 14h (and not 17h)?

What about PCI_DEVICE_ID_AMD_15H_NB_MISC (PCI device ID 0x1603)? No
thermal sensors here?

How comes that PCI_DEVICE_ID_AMD_15H_NB_MISC is listed in
arch/x86/kernel/amd_nb.c but PCI_DEVICE_ID_AMD_CNB17H_F3 is not? I
suspect a couple more patches will be needed in the future to get it
all to work.

[1] FYI, I have applied Clemens' patch to "my" standalone k10temp
driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
