From: Rudolf Marek <r.marek@assembler.cz>
Date: Thu, 21 Jun 2007 19:10:27 +0000
Subject: Re: [lm-sensors] AMB FB DIMM driver
Message-Id: <467ACD23.5010508@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070523000559.GA7009@jgarrett.org>
In-Reply-To: <20070523000559.GA7009@jgarrett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jeffrey,

Sorry for the delay,

>>> static struct sensor_device_attribute temp_input[] = {
>>> 	SENSOR_ATTR(temp00_input, S_IRUGO, show_temp, NULL, 0),
>> Without leading zero and decimal please. Maybe you can even do this in 
>> dynamic fashion. I think there was at least one driver doing it this way, 
>> but I dont recall right now.
> 
> Noted.  Should there be any communication with the user about names
> then?  For example, in the DSBF-D manual it calls the DIMMs DIMM_00,
> DIMM_01, etc. based on channel & number. And this would correlate to
> temp00_input, etc.  In other words, locating a hot DIMM is relatively
> easy with this information.  If they're called, say,
> temp{1,2,17,18,33,34,49,50}_input, then a user can still figure out
> which DIMM is which, but has to realize how to correlate 17 to DIMM_10.
> It's a little bit more opaque.  And if they're called
> temp{1,2,3,4,5,6,7,8}_input, it's even more so.

> So, should there be a separate sysfs attribute, something like
> temp1_name which may read DIMM_00, for example?

Yes we have _label (coretemp driver for example). Please fill the label with string.

> Also, which of the two options above is preferable [no gaps, or gaps but
> numbers that are stable...  temp17 always points to the same slot]?

If we have _label files so perhaps static approach is easiest.

> I made it kinda sorta dynamic...   i.e. the structs are in data, so they
> are allocated dynamically, not statically, and initialized when needed.
> But it still allocates space for 64...

Ok I dont know if Mark will like it, anyway this may be changed in next iteration.



>>> static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
>>> static struct pci_device_id ambtemp_ids[] = {
>>> 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x25f0) },
>> the 0x25f0 should go to the pciids.h Moreover I do not recall if this is 
>> used also for something else? I mean has this PCI device some other 
>> function?
> 
> It's called the error reporting registers by lspci.  As far as I can
> tell, it's just a bunch of registers associated to the MCH, and nothing
> else in the kernel claims it.

And what about EDAC? (check the edac project please) maybe we need to do same 
trick as for i2c-viapro driver, return -ENODEV to PCI layer but normally 
request_region for the MEM region.

> Helps immensely.  I'm a bit new to this.  Thanks very much,

Good. Sorry for the delays, this week I have first opportunity to have free 
evening :/

Hope it helps a bit.

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
