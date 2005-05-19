From: cat@zip.com.au (CaT)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: 2.6.0-t1: i2c+sensors still whacky
Message-Id: <20030717153348.GO4612@zip.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030715090726.GJ363@zip.com.au> <20030715161127.GA2925@kroah.com> <20030716060443.GA784@zip.com.au> <20030716061009.GA5037@kroah.com> <20030716062922.GA1000@zip.com.au> <20030716073135.GA5338@kroah.com> <20030716224718.GA4612@zip.com.au> <20030716225452.GA3419@kroah.com>
In-Reply-To: <20030716225452.GA3419@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Greg KH <greg@kroah.com>, sensors@stimpy.netroedge.com, frodol@dds.nl
Cc: linux-kernel@vger.kernel.org, phil@netroedge.com

On Wed, Jul 16, 2003 at 03:54:52PM -0700, Greg KH wrote:
> On Thu, Jul 17, 2003 at 08:47:18AM +1000, CaT wrote:
> > On Wed, Jul 16, 2003 at 12:31:35AM -0700, Greg KH wrote:
> > > Then just load the i2c_piix4 module.  If things still work just fine,
> > > then try the i2c-adm1021 driver.  See what the kernel log says then.
> >=20
> > All went well till the last step of loading the adm1021 driver.
>=20
> And you are sure you have this hardware device?  Is that what the

Yes. I am very definate that this worked in past 2.5 kernels. Remember
how it used to turn my laptop off under load? I was able to read my
temps and stuff though.

> sensors package for 2.4 uses?  And 2.4 works just fine, right?

I don't use 2.4. Haven't for ages.

> If so, I suggest you ask the sensors developers on their mailing list as
> this is a driver specific issue, and doesn't sound like a problem due to
> the 2.5 port.

I've added them to To/Cc. (Hey folks :) The full thread is available
here:

http://marc.theaimsgroup.com/?t=105826046600003&r=3D1&w=3D2

If you could have a look I'd really appreciate it.

> > i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0018
> > i2c_adapter i2c-0: Transaction (pre): CNT=00, CMD	, ADD0, DAT0=FF, DAT1=
=FF
> > i2c_adapter i2c-0: Error: no response!
>=20
> It's really looking like the driver is trying to talk to a device that
> isn't present, hence the timeouts.

I tried the other drivers and they all failed nicely and without hassle. I
looked through my past .config files and this is the driver that appears
the most in use.

--=20
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
