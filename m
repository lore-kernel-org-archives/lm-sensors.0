From: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Problems with Tyan Thunder LE-T
Message-Id: <20031210175052.GG23731@stop.crashing.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.50.0312052212300.7299-100000@trottelkunde.amd.co.at>
In-Reply-To: <Pine.LNX.4.50.0312052212300.7299-100000@trottelkunde.amd.co.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Dec 09, 2003 at 01:58:40PM +0100, Michael Renner wrote:

> 
> 
> On Sat, 6 Dec 2003, Jean Delvare wrote:
> 
> > > I was trying to get I2C/lm_sensors running on one of our "refurbished"
> > > servers, but ran into freezes while loading the i2c-piix driver.
> >
> > Get an updated lm_sensors2 from CVS and it should work OK. Sorry for the
> > trouble.
> 
> Hi Jean, Tom!
> 
> Thanks for your fast reply, everything works fine now (using 'todays'
> cvs).
> 
> The only thing left is the following message I get when loading
> the i2c-piix4 module:
> 
> Found ServerWorks OSB4 South Bridge device
> dmi_scan.o version 2.8.1 (20031005)
> dmi_scan.o: SM BIOS found
> i2c-piix4.o: Unusual config register value (0x03)
> i2c-piix4.o: Please report!

Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
