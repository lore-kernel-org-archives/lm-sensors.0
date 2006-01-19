From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 Jan 2006 04:22:13 +0000
Subject: [lm-sensors] Asus a8v problems.
Message-Id: <20060119042213.GB17365@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <43CE945F.8020105@imperialnet.org>
In-Reply-To: <43CE945F.8020105@imperialnet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Patric:

* Patric <pakar at imperialnet.org> [2006-01-18 20:17:51 +0100]:
> I seem to have some problems with lm-sensors here.
> First, it seems like in some revision of lm-sensors i lost the ability 
> to see the RAM that was installed in the system (see the i2cdump later). 
> I know this worked before, but i'm not shure what version of lm-sensors 
> it was ten.

That's a feature, not a bug. ;) Seriously though, we've decided that
memory/SPD display was useful neither for sensors(1) nor libsensors(3).
You can get the same info (and much more) using the perl script 
decode-dimms.pl which is in the lm-sensors package also.

I see now, this is not mentioned in the CHANGES file.  I'll fix that.

> The problem that i'm having is that i dont seem to be able to control 
> fan3. Speeds and everything is correct, but if i just do an echo 0 >pwm3 
> the fan still does not stop. fan1 and 2 (and pwm1 and 2) works 
> perfectly. Any hints of what to look at would be a great help, or if you 
> know that there is some problems like this. (did not find any matching 
> entrys in the bug-tracker)

> [...]

> Probing for `Winbond W83627THF Super IO Sensors'
>    Success... found at address 0x0290

Using the command 'echo 0 > pwm3' should depend on the kernel driver only.
What kernel version are you using?  What version were you using the last
time that worked?  Also, can you please send the output from sensors(1) ?

> [...]

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


