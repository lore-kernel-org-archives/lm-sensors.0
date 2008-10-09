From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 09 Oct 2008 11:37:37 +0000
Subject: Re: [lm-sensors] [PATCH 07/12] ics932s401: New driver
Message-Id: <20081009133737.7d692a3b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081007011859.12701.8929.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081007011859.12701.8929.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 8 Oct 2008 11:26:37 -0700, Darrick J. Wong wrote:
> On Wed, Oct 08, 2008 at 01:09:59PM +0200, Jean Delvare wrote:
> > > +This chip has 4 clock outputs--a base clock for the CPU (which is likely
> > > +multiplied to get the real CPU clock), a system clock, a PCI clock, a USB
> > > +clock, and a reference clock.  The driver reports selected and actual
> > > +frequency.  If spread spectrum mode is enabled, the driver also reports by what
> > > +percent the clock signal is being spread, which should be between 0 and -0.5%.
> > > +All frequencies are reported in KHz.
> > > +
> > > +The ICS932S401 monitors all inputs continuously. The driver will not read
> > > +the registers more often than once every other second.
> > 
> > I fail to see how this has anything to do with hardware monitoring.
> 
> This driver enables users to monitor the clock generator chips on the
> motherboard.  Not a traditional hwmon chip in the temp/volt/fan sense, I
> agree, but it's been useful for me when I want to confirm that clock
> rates are what they're supposed to be.  It's also helpful to know
> whether or not spread spectrum is enabled if the CPU clock is a few
> tenths of a % below what I think it should be.
> 
> (Yes you can over/underclock by writing to this chip, but someone else
> can do that; I don't recommend it.)

I'm not arguing the usefulness of the driver. I'm just saying that it
doesn't belong to drivers/hwmon and shouldn't call
hwmon_device_register().

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
