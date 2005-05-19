From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: Adding "host as slave" support
Message-Id: <419C015C.5030602@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <c32efac40411152312171e21db@mail.gmail.com>
In-Reply-To: <c32efac40411152312171e21db@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The SMBus host is generally the 'ARP Master' if ARP is used (see the SMBus 2.0 spec for details...),
so host-as-slave must be implemented to support the 'Notify ARP Master' function.

What chip are you considering implementing this on?

see other comments below

Dave Hylands wrote:
> Hi,
> 
> I'm in the process of building a robot using a gumstix as the main
> processor. My gumstix is currently running 2.6.9-rc1. I'd like to use
> the i2c bus to hook together a bunch of I/O processors to the gumstix
> and I'd like to have the I/O processors act as masters to send
> information to the host (gumstix) asynchronously.
> 
> I'm primarily interested in using the dev interface
> 
> I found the i2c TODO list:
> http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/i2c/TODO
> 
> And, I think I'd like to work on this particular item (I'm still trying
> to come to terms with all of the terminology so I could be wrong :)
> 
>     97	* Host-as-slave mode in i2c adapters may need to be integrated
>     98	  with the adapter host code, because the lm_sensors-type chip driver
>     99	  architecture is not well suited to implementing a chip slave,
>    100	  the slave mode will require locking with the master mode, and
>    101	  specialized commmunication such as "Notify ARP Master".
>    102	  Adapters may respond to one or more host-as-slave addresses. The
>    103	  functionality bits and the rest of the API will have to be extended
>    104	  to support slaves embedded in host adapters.
> 
> I saw the recent thread on multiple master
> http://archives.andrew.net.au/lm-sensors/msg27650.html
> 
> I don't quite understand the "Notify ARP Master". I searched through
> the i2c sources (drivers/i2c) and could find no references to "arp".
> 
>>From my recent readings about i2c, here's my naive brain dump (my
> terminology could be off - please correct) of what might be required.
> 
> - The host would leave the i2c adapter in slave mode so that it could
> accept incoming data from another master.
> - Sending data would switch into master mode and proceed as it dows now.

The datasheets I've seen can support master and slave at the same time, there
isn't any 'mode' selection possible or necessary


> - Loss of arbitration on a send would need to try sending again when
> the bus isn't busy.

All SMBus drivers check for busy busses and wait for the bus to be free already;
SMBus is inherently mulit-master;
no code changes necessary.

> - The adapter would need to know it's address so it can detect if an
> incoming request is for it.
> - The dev interface would need an ioctl to set the adapter address
> - The dev interface would need an ioctl to get the data from another
> master. This would need to include the address used (in the event that
> the general call address is supported or multiple addresses are
> assigned to the host)

sounds right to me.

> 
> That should be enough to start some discussion....
> 
