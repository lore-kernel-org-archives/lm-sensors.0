From: =?UTF-8?Q?Ond=c5=99ej_Lyson=c4=9bk?= <olysonek@redhat.com>
Date: Wed, 23 Jan 2019 14:13:53 +0000
Subject: Re: Intel X550-T2
Message-Id: <4c123c0c-52dc-6cb4-6ab0-c8b412c711eb@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4e3b24db-7946-23f8-3f95-650b29f28a17@gmail.com>
In-Reply-To: <4e3b24db-7946-23f8-3f95-650b29f28a17@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 23. 01. 19 15:05, Mikko Laaksonen wrote:
> and cat /sys/class/hwmon/*/name gives
> 
> nouveau
> coretemp
> coretemp
> nct7904
> 
> lspci | grep -i eth gives
> 
> 03:00.0 Ethernet controller: Intel Corporation Ethernet Controller 10G
> X550T (rev 01)
> 03:00.1 Ethernet controller: Intel Corporation Ethernet Controller 10G
> X550T (rev 01)
> 05:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network
> Connection (rev 03)
> 06:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network
> Connection (rev 03)
> 
> from which I get with
> 
> find /sys | grep drivers.*03:00.1
> 
> /sys/bus/pci/drivers/ixgbe/0000:03:00.1

Ok, I suggest that you talk to the ixgbe maintainers about exporting the
sensor data from your card through hwmon. When support for that is
available, I'll try to add detection support to sensors-detect. Other
than that, there's really not much to be done on lm_sensors side.

Ondra
