From: rhirst@levanta.com (Richard Hirst)
Date: Thu, 08 Sep 2005 17:34:03 +0000
Subject: [lm-sensors] i801_smbus 0000:00:1f.3: Bus collision!
Message-Id: <20050908153321.GK8392@levanta.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050907213603.GW8392@levanta.com>
In-Reply-To: <20050907213603.GW8392@levanta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Sep 08, 2005 at 09:56:29AM -0400, Yani Ioannou wrote:
> On 9/8/05, Richard Hirst <rhirst@levanta.com> wrote:
> 
> > > > The board has an mBMC which is basically working in that I can read
> > > > the sensors either by 'ipmitool' or 'sensors'.
> > > >
> > > > However, round about every 10 reboots or so, I get the Bus collision
> > > > message and the system locks up solid during boot after outputting a
> > > > few messages such as
> > > >
> > > > i801_smbus 0000:00:1f.3: Bus collision!
> > > > i801_smbus 0000:00:1f.3: Reset failed! (01)
> > > > i801_smbus 0000:00:1f.3: Reset failed! (01)
> > > > i801_smbus 0000:00:1f.3: Reset failed! (01)
> > > > bmcsensors.o: Error 0xff on cmd 0xa/0x23; state = 2; probably fatal.
> > > > i801_smbus 0000:00:1f.3: Reset failed! (01)
> > > > i801_smbus 0000:00:1f.3: Reset failed! (01)
> > > > i801_smbus 0000:00:1f.3: Reset failed! (01)
> 
> The bus collisions are expected - both the IPMI BMC (not bmcsensors
> directly) and the i2c modules you have loaded are competing for the
> smbus. However although I've done this (loaded both bmcsensors and i2c
> modules and got bus collisions) its never resulted in a lockup.

The lockup seems to be as a result of stack recursion; I modified
the "Reset failed!" message to report the address of a local stack
variable and after about 5 such messages the variable address starts
working down the stack until it hangs.  Trying to get a decent
stack trace now.

I currently have these modules loaded:

Module                  Size  Used by
...
bmcsensors             53861  0 
eeprom                 11353  0 
i2c_sensor              7361  1 eeprom
i2c_ipmi                8397  0 
ipmi_msghandler        41509  1 i2c_ipmi
i2c_dev                13249  0 
i2c_i801               13053  0 
...
i2c_piix4              12113  0 
i2c_core               29889  7 bmcsensors,eeprom,i2c_sensor,i2c_ipmi,i2c_dev,i2c_i801,i2c_piix4
...

The system is actually only interested in getting sensor values
by reading files in /sys/class/i2c-dev/... (I didn't write that bit).

> No, not directly. bmcsensors uses the IPMI messaging interface to send
> out queries to the IPMI BMC which then reads the sensors readings over
> the i2c/smbus (which is sometimes shared with the system).
...
> The IPMI BMC won't be using the i801 interface driver...its basically
> another computer on your motherboard :), I'd suspect the i2c drivers
> or i801 are causing the system lockup, as Mark says though you
> shouldn't be using both (but it shouldn't lockup IHMO).

So, out of the above modules, which can I do without?  eeprom, at
least; any others?

My understanding is that I'm talking over the i2c to the mBMC, and it
is then talking over (a different?) i2c to the sensors.  So the collision
is presumably effectively between the bmcsensors and the eeprom code.

You can get an idea of the h/w from a previous post, if you have
the time:

<http://lists.lm-sensors.org/pipermail/lm-sensors/2005-June/012847.html>

Thanks for the helpful response,

Richard

