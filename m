From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 22 Mar 2007 17:49:03 +0000
Subject: [lm-sensors] #2195: Fails to detect ITE family chip with ID
Message-Id: <20070322184903.a58402f4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703220924o604d104iaf34922f53c7cf83@mail.gmail.com>
In-Reply-To: <191fb4ca0703220924o604d104iaf34922f53c7cf83@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Thu, 22 Mar 2007 09:38:55 -0700, Juerg Haefliger wrote:
> looking at sensors-detect:
> 
> > # $_[0]: A reference to the file descriptor to access this chip.
> > # $_[1]: Address
> > # Returns: undef if not detected, 5 or 6 if detected.
> > # Registers used:
> > #   0x3E: Manufacturer ID
> > #   0x3F: Version/Stepping
> > #   0x40: Configuration (2 reserved bits)
> > #   0x42: Interrupt Status 2 (1 reserved bit)
> > #   0x43: VID (2 reserved bits)
> > sub dme1737_detect
> > {
> >   my ($file, $addr) = @_;
> >   return unless i2c_smbus_read_byte_data($file, 0x3E) = 0x55
> 
> this should be 0x5c not 0x55.

Correct, I came up to the same conclusion.

> >            and (i2c_smbus_read_byte_data($file, 0x3F) & 0xF8) = 0x88
> >            and (i2c_smbus_read_byte_data($file, 0x40) & 0xC4) = 0x04
> >            and (i2c_smbus_read_byte_data($file, 0x42) & 0x02) = 0x00
> >            and (i2c_smbus_read_byte_data($file, 0x43) & 0xC0) = 0x00;
> 
> Are the checks of addresses 0x40, 0x42 & 0x43 really necessary?
> 
> >   return ($addr = 0x2e ? 6 : 5);
> }

There are no standard registers and no standard values to identify I2C
manufacturers and devices. So adding a few tests where possible cannot
hurt and is considered a good practice. So unless you have a reason to
believe that these tests could fail for an otherwise valid chip, I'd
leave them in. Especially the test of register 0x40 is valuable - the
test of register 0x42 certainly less.

We don't need to do this for Super-I/O or PCI devices because they have
standard identification registers.

Can you please provide a patch fixing sensors-detect for the DME1737?

Thanks,
-- 
Jean Delvare

