From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: still ASUS ASB100 Bach
Message-Id: <3D248B39.6BBBA94A@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D24823D.40909@boneti.com>
In-Reply-To: <3D24823D.40909@boneti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It will be most difficult without a datasheet. Maybe impossible.

Here are the steps:
	- Find the chip in memory. Is it on the isa bus or an i2c bus?
	  Is it part of a PCI chip or a Super I/O chip?
          Use i2cdetect and i2cdump or isadump to find it and look at
the registers
	- Use an existing driver, use force parameters to give it the address,
	  and see how it goes. Using force_as99127f on the w83781d is a good
guess.
	- Start tweaking / reverse engineering to fix up the driver for the new
chip.

Good luck!



Carlos Boneti wrote:
> 
> Hi,
> 
> As I wrote to you one week earlier, I would like to help you with
> development.. I have an ASUS a7v333 which has an ASB100 Bach chip.
> You replied to my e-mail telling me to see /doc/developers/new_drivers.
> As I don't have the specs for this chip, I still trully don't know
> how/what to do.  I asked datasheets from asus but they said they can't
> give such info to end users...
> Do you have any clue/help?
