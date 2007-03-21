From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 21 Mar 2007 18:41:51 +0000
Subject: [lm-sensors] Fintek F71805F on Jetway 627FWE1G
Message-Id: <20070321194151.453543d7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070321155103.GD19205@storm.local.network>
In-Reply-To: <20070321155103.GD19205@storm.local.network>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Forest,

On Wed, 21 Mar 2007 14:05:03 -0400, Forest Bond wrote:
> On Wed, Mar 21, 2007 at 06:32:19PM +0100, Jean Delvare wrote:
> > Hmm, 35 degrees C in your room? Where do you live? :) Do temp2 and
> > temp3 change at all?
> 
> Sorry, I live in a non-Celsius country, and didn't realize how hot that is. :)

Poor you ;)

You might enjoy "sensors -f" then.

> > So this "0 degree C" for CPU is raising on load / fan unplug? Up to
> > what value?
> 
> Yes, it does climb up to the 30-40 C range, at least, when I run my CPU burn
> utility and unplug the CPU fan momentarily.  I don't recall the exact value, but
> it did seem to be a typical fluctuation (under the circumstances).

I'm not sure you want to do that, actually 33 + 40 leads to 73 degrees
C which is quite high for a Nehemiah. Don't go frying your CPU just to
demonstrate that your BIOS has a bug ;)

> I imagine that value gets chopped at zero rather than going negative.  When I
> grabbed the data, the CPU burn utility was not running, and the CPU fan was on.
> I didn't realize until after that that the CPU temperature was being reported as
> 0C.

Yes, the value gets chopped at 0 by the F71805F.

> The BIOS displays two temperatures:
> 
> CPU Temp: 12 C
> System Temp: 37 C

OK, so the CPU temp is unreasonably low just as it is under Linux.

> What do you suppose is the third temperature I see from sensors?  Could it be a
> duplicate reading of the system temperature?  Or is the BIOS just ignoring a
> temperature sensors for some reason?

Cannot be a duplicate reading, physically it wouldn't make sense. It
really has to be a 3rd sensor. Either the BIOS is averaging temp2 and
temp3 into "System Temp", or they indeed just ignore temp3. Given that
temp2 appear to have the same value anyway, no big deal.

> Agreed.  I will pose this question to my contact at Jetway, and perhaps we can
> get to the bottom of this.
> 
> Thanks again for your time, Jean.

You're welcome. I'm happy to see my driver is widely used :)

-- 
Jean Delvare

