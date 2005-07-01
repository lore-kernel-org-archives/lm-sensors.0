From: mds@mds.gotdns.com (Mark Studebaker)
Date: Fri, 01 Jul 2005 04:59:20 +0000
Subject: [lm-sensors] lm87 alarm threshold changed mysteriously
Message-Id: <42C4B15A.7080306@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <84ab3f2e05063006542885c7e6@mail.gmail.com>
In-Reply-To: <84ab3f2e05063006542885c7e6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I don't see anything in CHANGES or the CVS log that sounds like it would fix this.
Strange since I assume there are no writes happening to any registers in normal operation, just reads for monitoring.
Could be noise on the I2C bus or even cosmic rays that flipped a bit in the LM87.
The server wasn't in Denver, was it (high altitude)?
Sorry no great ideas on how to answer 2-4.
Hope it doesn't happen again...
mds


David Knierim wrote:
> We have a product based on the Intel E7501 chipset which uses two LM87
> sensor chips and the i2c-i801 bus driver.  We have fielded several
> hundred of these boxes over the past two years.  They are all running
> Red Hat 9 with the version of sensors that came with it (the rpm
> version is 2.6.5-5).  Yes, I know this an ancient release...
> 
> I got a call yesterday that one of the boxes had started getting
> voltage alarms.  After some investigation, I determined the problem
> was that the low voltage alarm threshold for the +V2.5 power plane had
> changed to 3.32V (from the normal value of 2.37V.   The high voltage
> threshold had not changed for the normal setting of  2.61V.   The
> measured voltage of 2.48V looked fine, too.
> 
> After running sensors -s, the problem went away (as I expected it to).
> 
> So I have a bunch of questions:
> 1 - is it likely that this problem would be fixed in a newer release
> of lm_sensors?
> 2 - if it's not fixed, how would one track down the problem so we could fix it?
> 3 - is it possible this is a hardware problem?
> 4 - Any thoughs on recovering from problem in a more automated fashion
> until a fix is found?
> 
> Any thoughts are welcome.
> 
> David
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


