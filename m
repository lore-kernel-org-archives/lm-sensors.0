From: =?UTF-8?Q?Ond=c5=99ej_Lyson=c4=9bk?= <olysonek@redhat.com>
Date: Wed, 23 Jan 2019 13:54:12 +0000
Subject: Re: Intel X550-T2
Message-Id: <de68d4bf-06de-31ef-1759-0ad5501267a5@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4e3b24db-7946-23f8-3f95-650b29f28a17@gmail.com>
In-Reply-To: <4e3b24db-7946-23f8-3f95-650b29f28a17@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 23. 01. 19 13:15, Mikko Laaksonen wrote:
> Hello,
> 
> I would like to know how I can go about adding support for an Intel
> X550-T2 PCI-E network card in lm_sensors. The card comes with a number
> of sensors, including temperature, and a 1,200-page reference manual.
> sensors-detect does not recognize the card off the shelf.

Detection support in sensors-detect doesn't mean much, so I'd first
focus on whether data from the sensors is exported by the driver.
Looking at the ixgbe driver (am I looking at the correct driver?), it
does register a hwmon device, so the data could be available. Let's
verify that - what's the output of the 'sensors' program and the output
of 'cat /sys/class/hwmon/*/name'?

Ondra
