From: jwbaker@acm.org (Jeffrey W. Baker)
Date: Sat, 23 Sep 2006 04:28:49 +0000
Subject: [lm-sensors] Intel DG956RY motherboard with LPC47M182
Message-Id: <1158985729.9242.6.camel@ubuntu.gghcwest.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1158983695.9242.3.camel@ubuntu.gghcwest.com>
In-Reply-To: <1158983695.9242.3.camel@ubuntu.gghcwest.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2006-09-22 at 20:54 -0700, Jeffrey W. Baker wrote:
> I have an Intel DG965RY motherboard, which the lm-sensors in Ubuntu Edgy
> does not seem to support.  I received a message from Rudolf Marek by way
> of Andrew Barr that I should examine the chips near the floppy connector
> and mail it here.
> 
> The chip near the floppy connector is an SMSC LPC47M182.  I did not see
> any other integrated circuits in that area of the motherboard.
> 
> I don't subscribe so kindly CC me if more information is required.

I just tried the SVN snapshot and got this output:

Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      Yes
Found unknown chip with ID 0x7401
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found unknown chip with ID 0x7401
Trying family `VIA/Winbond/Fintek'...                       No
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No

Regards,
Jeffrey Baker


