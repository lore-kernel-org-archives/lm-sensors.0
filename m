From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 27 May 2014 06:35:41 +0000
Subject: Re: [lm-sensors] info about  driver for chip EMC1402
Message-Id: <20140527083541.18f8bda9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1401139433.59243.YahooMailNeo@web172006.mail.ir2.yahoo.com>
In-Reply-To: <1401139433.59243.YahooMailNeo@web172006.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter, Kenny,

On Mon, 26 May 2014 17:15:54 -0700, Guenter Roeck wrote:
> On 05/26/2014 02:23 PM, Kenny Lake wrote:
> > I have serious temp problem with my laptop, it has a EMC1402 chip and I would like to know if is there any new driver  that I can try to use.
> > Thanks
> 
> A patch to add suport for this chip is pending for integration into the 3.16 kernel.
> It is available in the linux-next repository. Can you use that ?

On laptops it is almost never possible to access monitoring chips
directly, one has to go through ACPI or a vendor-specific layer. So
Kenny should prepare himself to the idea that the emc1403 driver in
linux-next will most likely not work. But it's certainly worth a try
anyway.

Kenny, how do you know that your laptop has an EMC1402 chip? Doesn't
the ACPI thermal driver work for you? Did you try the vendor-specific
driver for your laptop? Some of them (asus-wmi, compal-laptop,
eeepc-laptop and thinkpad_acpi) provide temperature readings.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
