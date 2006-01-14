From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 14 Jan 2006 04:09:14 +0000
Subject: [lm-sensors] Loaded Modules but 'No sensors found'
Message-Id: <20060114040914.GB29747@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <W5422813796241071136954279@webmail2>
In-Reply-To: <W5422813796241071136954279@webmail2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Kevin:

Kevin wrote:
> > > > I've followed all instructions I could find. It seems as if all modules get
> > > > detected and load fine. Yet running 'sensors returns 'No sensors found'. Any
> > > > thoughts?????

Mark wrote:
> > > I guess: unload eeprom, i2c-amd756, and i2c-amd8111; then try again.  Your
> > > hardware monitor (w83627hf or some such) is probably visible through i2c-isa
> > > alone.  If that doesn't work, please send the output from sensors-detect.

Kevin wrote:
> > I haven't had the chance yet to try this but I did try a new kernel and 
> > that worked.
> > I tried kernel 2.6.15 w/ gentoo and ck patches. I will try you above 
> > suggestion and also vanilla kernel 2.6.15 for comparison.

* Jean Delvare <khali at linux-fr.org> [2006-01-13 23:29:35 +0100]:
> My own guess is the conflict between PNPACPI and the w83627hf driver,
> which is known to have affected the Linux kernels from 2.6.10 to 2.6.14:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id@14

Oops, I forgot about that one.  You're probably right.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


