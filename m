From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: Sensors whackyness under 2.6.x
Message-Id: <20030815143453.4483e0c9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030815110924.GC501@zip.com.au>
In-Reply-To: <20030815110924.GC501@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Well I just wanted to report a problem I'm having with the sensors
> code. I've done some debugging work to track it down and this is
> best found in the following threads:
> 
> http://marc.theaimsgroup.com/?t5826046600003&r=1&w=2
> http://marc.theaimsgroup.com/?t5845678400003&r=1&w=2
> 
> There's a bit of info there so I hope noone minds me linking
> to those threads rather then retyping everything. As always
> I'm happy to answer questions or do any required debugging.

Oh. Now I remember you ;) The second thread made it to the list already.
But nobody took the time to handle it. So you are well inspired to wake
us up. Let's see what we can do for you now.

> Well I hope this helps. I can both duplicated and fix the problem
> under 2.4. To duplicate all I have to do is compile the kernel without
> ISA support and, consequently, not use the ISA bus to read the sensors
> data. 2.4 then displays the exact same symptoms that 2.5 does. If I
> compile ISA in and use it for the data then I get my data and kernel
> works fine. To test if all was well I compiled 2.5 (for the next test)
> and constantly checked the temperature. It went up during the compile
> nicely and dropped when it stopped so I'll assume that the sensors
> stuff works perfectly fine under 2.4 with ISA.

I don't get you. The adm1021 module is an i2c-only driver. It doesn't
work with the isa bus. So, what do you mean with "If I compile ISA in
and use it for the data"? I can't believe you get any result using only
the i2c-core, i2c-proc, i2c-isa and adm1021 modules.

> Powercycle and try again, this time only doing:
> 
> modprobe i2c-isa
> modprobe adm1021
> 
> Kernel works fine but no sensor data. find returned only empty
> directories.

Confirms what I said, that's an i2c-only driver.

> I then did:
> 
> modprobe i2c-piix4
> 
> and boom! molasses again and dmesg was filled with the errors I
> previously posted.

What if you load i2c-piix4 first, and then adm1021? If the slowdowns
appear before loading adm1021, then the i2c-piix4 driver is at fault,
else either adm1021 or i2c-piix4 is at fault.

I would like you to try with i2c-CVS and lm_sensors-CVS. We made a
change to the i2c-piix4 driver recently that could influence your
problem. Download instructions are to be found here:
http://secure.netroedge.com/~lm78/download.html#cvs

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
