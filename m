From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: sensors-detect feedback
Message-Id: <1083757407.4098d35f331d9@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040324043651.1891.qmail@web80501.mail.yahoo.com>
In-Reply-To: <20040324043651.1891.qmail@web80501.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> This IBM is a good candidate to be a guinea pig.  I understand the 
> consequences.  (It's a lease from work, and I do the ordering...hehehe).
> 
> Let me know how and I'll try it out and send you the results.

Well, as you wish.

I've recently modified sensors-detect and i2cdetect so as to prevent any
kind of corruption of the AT24RF08. There was a different fix previously,
but it was known to possibly not work under special circumstances. The new
one is safer but could have additional side effects.

So, if you want to help and have no fear, you could try both tools on your
IBM system, with a reboot between each test. If the EEPROM is present and
got corrupted, you'll now it because the system won't boot anymore. Tests
are also welcome on non-IBM systems so as to verify that I did not
introduce nasty side effects.

Please get the latest CVS version of lm_sensors:
http://secure.netroedge.com/~lm78/download.html#cvs

Compile and install, then edit /usr/local/sbin/sensors-detect. Near line
4497, replace "exit;" with "return 1;" (at the end of function
safe_system_vendor). Thid will bypass the IBM test.

Then run sensors-detect. It should detect two busses and propose you to
load
i2c-i801 and i2c-i810. Accept (hopefully you have these modules
availablable on your system). Then let the script scan them. Please provide
a full output of the run ("script" may help).

After that, reboot and check that everything still works.

Then you can do the same for i2cdetect. There is no IBM test to bypass
there. Just run "i2cdetect N" where N is the number of the i801 bus. You
can do the same for the i810 bus if you wish. Again, full output of the
run(s) is requested. Reboot again and ensure that nothing bad happened.

If the new corruption prevention mechanism seems to work with no additional
drawbacks, a similar change will be done in i2c-core (Linux 2.6 only) some
times later and the lm_sensors on IBM nightmare will hopefully be gone
forever.

Thanks for your help.

-- 
Jean Delvare
http://khali.linux-fr.org/
