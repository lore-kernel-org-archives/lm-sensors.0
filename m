From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: Documentation Bug (Re: Ticket #1126)
Message-Id: <3E503EBB.4060503@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030209084710.GA1470@earthlink.net>
In-Reply-To: <20030209084710.GA1470@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

good suggestions, thanks, I'll try and add some of them to our docs.
mds

Jason Bucata wrote:
> This is regarding ticket #1126.
> 
> The suggestion to turn on CONFIG_I2C_ALGOBIT worked; thanks.  So it
> appears to be a documentation bug instead of a code/config file bug.
> 
> It makes sense to have to turn something on like that before you can see
> the option, but IMHO it's very important to tell the users that they
> need to!
> 
> None of the following sources of information say anything about having
> to enable bit-banging devices when compiling the kernel to use this
> driver:
> 	http://secure.netroedge.com/~lm78/supported.html
> 	http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/busses/i2c-via
> 	sensors-detect
> 
> Maybe that should be stated directly on the Supported Chips and Drivers
> page, but I think ideally it should go on the per-driver doc page, and
> have the Supported Chips and Drivers page hyperlink to those, so that we
> know there's more info available.  (I didn't even know about the
> driver-specific pages until just now.)
> 
> Jason B.
> 
