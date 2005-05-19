From: dhylands@gmail.com (Dave Hylands)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: Adding "host as slave" support
Message-Id: <c32efac404111821437855ef16@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c32efac40411152312171e21db@mail.gmail.com>
In-Reply-To: <c32efac40411152312171e21db@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Wed, 17 Nov 2004 20:56:44 -0500, Mark Studebaker <mds4@verizon.net> wrote:
> The SMBus host is generally the 'ARP Master' if ARP is used (see the SMBus 2.0 spec for details...),
> so host-as-slave must be implemented to support the 'Notify ARP Master' function.

Ahhh. I see I have some more reading to do :) My original intention
was just adding support for i2c. I knew that smbus tied in there
somewhere, but my impression was that it was just a simplified
physical layer with a more defined protocol layer. I will research
more before continuing.

> What chip are you considering implementing this on?

The PXA255 (which is the ARM XScale processor used in the gumstix).

Ok - I've downloaded and read through most of the SMBus 2.0 spec. It
seems that to implement an arp capable SMBus device requires being
able to respond to two addresses, the slave address and the SMBus ARP
Address (1100 001).

So far all of the i2c hardware support that I've seen (including the
AVR ATmega series and the PXA255) can only respond to the general call
address and the slave address. The PCF8584 has a monitor mode which
allows it to detect any slave address, but I haven't seen any other
i2c hardware that can support this (which isn't to say that it doesn't
exist, I just haven't found anything).

So am I missing something? Has anybody come up with a way of
implementing an SMBus device using hardware i2c support? Obviously,
this could be done using bit banging.

> > - Loss of arbitration on a send would need to try sending again when
> > the bus isn't busy.
> 
> All SMBus drivers check for busy busses and wait for the bus to be free already;
> SMBus is inherently mulit-master;
> no code changes necessary.

Well if I can use the smbus code/drivers then that might make the
Linux side of things easier (well it might actually make it work such
that I don't even need to make any driver changes - we'll see).

> > - The adapter would need to know it's address so it can detect if an
> > incoming request is for it.
> > - The dev interface would need an ioctl to set the adapter address
> > - The dev interface would need an ioctl to get the data from another
> > master. This would need to include the address used (in the event that
> > the general call address is supported or multiple addresses are
> > assigned to the host)
> 
> sounds right to me.

Thanks for the thought provocation...

-- 
Dave Hylands
Vancouver, BC, Canada
http://www.DaveHylands.com/
