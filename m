From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 05 Feb 2007 17:20:31 +0000
Subject: [lm-sensors] DS75
Message-Id: <20070205182031.f727c6e7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45BDE148.7020108@pipstechnology.co.uk>
In-Reply-To: <45BDE148.7020108@pipstechnology.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alan, 

On Mon, 05 Feb 2007 13:12:46 +0000, Alan Clucas wrote:
> > Yes, I'd appreciate a debug log and/or output of i2cdump for a Dallas
> > DS75 chip.
> 
> Hi Jean, this is the output I get for the device:
> 
> localhost ~ # i2cdump -y 0 0x48
> No size specified (using byte-data access)
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 50 30 4b 50 50 50 50 50 50 50 50 50 50 50 50 50    P0KPPPPPPPPPPPPP
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 20: XX XX 4b XX XX XX XX XX XX XX XX XX XX XX XX XX    XXKXXXXXXXXXXXXX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 40: 50 00 4b 50 50 50 50 50 50 50 50 50 50 50 50 50    P.KPPPPPPPPPPPPP
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX 50 XX    XXXXXXXXXXXXXXPX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 
> localhost ~ # i2cdump -y 0 0x48 w
>       0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
> 00: 8050 0030 004b 0050 0050 0050 0050 0050
> 08: 0050 0050 0050 0050 0050 0050 0050 0050
> 10: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> 18: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> 20: XXXX XXXX 004b XXXX XXXX XXXX XXXX XXXX
> 28: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> 30: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> 38: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> 40: 8050 0000 004b 0050 0050 0050 0050 0050
> 48: 0050 0050 0050 0050 0050 0050 0050 0050
> 50: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> 58: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> 60: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> 68: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> 70: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> 78: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> 80: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> 88: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> 90: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> 98: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> a0: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> a8: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> b0: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> b8: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> c0: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> c8: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> d0: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> d8: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> e0: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> e8: XXXX XXXX XXXX XXXX XXXX XXXX 0050 XXXX
> f0: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> f8: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX

Wow. I have to admit it's not exactly what I expected. The fact that
some (seemingly random) unused addresses work while others return an
error instead is rather puzzling. At least this gives us several ways
to detect the DS75.

> If there are any other particular parameters to i2cdump you'd like me to 
> try I'll happily do so.

No, the above should be enough.

> > Your email client is wrapping the long lines so I couldn't apply the
> > patch above even if I wanted.
> 
> Argh, does the attached one work for you (just testing, not expecting 
> you to apply it) and comply with guidelines - I'll see it for myself 
> when it arrives back from the list.

Yes, the attached patch worked for me, and I'm fine with patches sent
as text attachements.

> > I'm not fine with this approach anyway. I fear that plain dropping the
> > check above will again cause non-compatible chips to be attached to the
> > lm75 driver. I'd rather leave the LM75 detection code as is and add
> > code to explicitely detect the DS75, even though we can have both
> > kinds advertised as "lm75" for compatibility reasons. What do you think?
> 
> Only if we can find something else which distinguishes the device 
> correctly, otherwise there isn't much point as it'll detect 
> non-compatible chips as DS75s doing exactly the same thing anyway. The 
> patch which added this address cycling DID add some other tests which 
> the DS75 passes. Leaving it reported as an lm75 makes sense though.
> 
> > Can you use perl on your system? I'd like to add detection for the DS75
> > to sensors-detect first, and when it's ready, port the code to the lm75
> > driver.
> 
> Yes, I have perl. sensors-detect currently does not detect it as an 
> lm75, agreeing with the unpatched kernel.
> 
> We only have a couple of fully functional boards, and I may break stuff 
> or need to run other long term tests, so turnaround on testing may be 
> intermittent.

OK. Attached is a patch against sensors-detect from our SVN repository.
Please give it a try, it should detect your DS75. Compared to the LM75
detection, I removed the cycle-over-8 test as your kernel patch did,
and additionally I'm checking that registers 0x08 to 0x0f behave the
same as 0x04 to 0x07 (which isn't true of the LM75.) If it works OK for
you, we can use the same approach in the lm75 kernel driver. Please
report.

Thanks,
-- 
Jean Delvare
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sensors-detect-add-DS75-support.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070205/8dd0dd21/attachment-0001.pl 
