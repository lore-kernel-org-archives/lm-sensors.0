From: s13361562@bach.sun.ac.za (Hugo van der Merwe)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: some via686a feedback...
Message-Id: <20020409102409.GA16302@vervet.localnet>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have been playing a bit with lm-sensors lately. One machine I've set
it up on has a Gigabyte GA-7DXC (iirc) motherboard. (VIA686)

I checked the config file, saw this:

"""
# Johannes Drechsel-Burkhard <jdb@chello.at> notes that on his MSI K7T Pro,
# temp1 is the CPU temp and temp2 is the SYS temp.

    label temp1 "SYS Temp"
    label temp2 "CPU Temp"
    label temp3 "SBr Temp"
<SNIP>
    set temp1_hyst 40
    set temp1_over 45
    set temp2_hyst 55
    set temp2_over 60
    set temp3_hyst 60
    set temp3_over 65
"""

On the 7DXC, I currently have a 59 degC temp1, 36 degC temp2, and 24
degC temp3. Thus I think on the 7DXC the same applies: temp1 is CPU and
temp2 is sys (it runs too hot, this machine, the BIOS agrees).

So I should push up my temp1_hyst/over to something higher, 65/70 maybe
(temp goes up when machine is very busy, I think a box fan is
necessary), make temp2 be 40/45, and temp3 ... It does seem to go up and
down with the rest, but seems too low to me (what should it be?), so I
guess this also applies:

"""
# on the Tyan S1598 as well as the Abit KA7 (Athalon), the absolute values
# of the readings from that sensor are not valid.  The readings do seem to
"""

Oh yea, I have lm-sensors 2.6.3-1, Debian package.

Thanks,
Hugo van der Merwe
