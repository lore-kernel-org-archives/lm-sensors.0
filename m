From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 24 Jan 2011 21:27:23 +0000
Subject: Re: [lm-sensors] insane readings on Asus A7M266 motherboard
Message-Id: <20110124222723.6a558f89@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <761574.42437.qm@web36601.mail.mud.yahoo.com>
In-Reply-To: <761574.42437.qm@web36601.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 24 Jan 2011 13:10:29 -0800 (PST), Audio Phile wrote:
> --- On Mon, 1/24/11, Jean Delvare <khali@linux-fr.org> wrote:
> 
> > This alone is usually a good hint that the VIA686A/B
> > integrated sensors
> > aren't used on the board.
> 
> I thought so too but it worked for years until I had to reinstall.

No, it did not. The VIA686A/B sensors are _not_ used on this board, I
am totally positive on this.

> > The A7M266, as most Asus board at the time, is using an
> > Asus-specific
> > ASIC for hardware monitoring, rather than the sensors
> > integrated in the
> > south bridge. In your case, that would be an AS99127F, so
> > you should
> > load the w83781d driver rather than the via686a driver.
> > sensors-detect
> > should have told you exactly this,
> 
> I tried this:
> 
> # rmmod via686a
> # modprobe w83781d
> # sensors
> No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.

So for some reason the AS99127F isn't usable by the w83781d driver.

> > BTW. If it did not,
> > please send the
> > full output of sensors-detect for analysis.
> 
> Attached. 
> (...)
> Lastly, we can probe the I2C/SMBus adapters for connected hardware
> monitoring devices. This is the most risky part, and while it works
> reasonably well on most systems, it has been reported to cause trouble
> on some systems.
> Do you want to probe the I2C/SMBus adapters now? (YES/no): YES
> Using driver `i2c-viapro' for device 0000:00:04.4: VIA Technologies VT82C686 Apollo ACPI
> Module i2c-dev loaded successfully.
> 
> Next adapter: NVIDIA i2c adapter  (i2c-0)
> Do you want to scan it? (YES/no/selectively): YES
> 
> Next adapter: NVIDIA i2c adapter  (i2c-1)
> Do you want to scan it? (YES/no/selectively): YES
> 
> Next adapter: NVIDIA i2c adapter  (i2c-2)
> Do you want to scan it? (YES/no/selectively): YES

The VIA Pro SMBus isn't probed, meaning that the driver failed to bind
to the device. You should see some error message in the kernel logs
when i2c-viapro is loaded.

One possible cause is an ACPI resource conflict [1]. I am a little
surprised as I didn't expect this kind of problem on such an old board.
If this is the case, booting with acpi_enforce_resources=lax should
solve your problem.

[1] http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
