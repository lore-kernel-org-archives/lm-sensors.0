From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 23 Sep 2006 11:32:19 +0000
Subject: [lm-sensors] Intel DG956RY motherboard with LPC47M182
Message-Id: <20060923133219.5efe4974.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1158983695.9242.3.camel@ubuntu.gghcwest.com>
In-Reply-To: <1158983695.9242.3.camel@ubuntu.gghcwest.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jeffrey,

> > I have an Intel DG965RY motherboard, which the lm-sensors in Ubuntu Edgy
> > does not seem to support.  I received a message from Rudolf Marek by way
> > of Andrew Barr that I should examine the chips near the floppy connector
> > and mail it here.
> > 
> > The chip near the floppy connector is an SMSC LPC47M182.  I did not see
> > any other integrated circuits in that area of the motherboard.

This is your Super-I/O chip. I found datasheets on www.smsc.com for the
LPC47M112, LPC47M172 and LPC47M182 (thanks SMSC!). It appears that the
latter two only support minimalist fan speed monitoring - two 16-bit
fan speed values, no low limit, no control. This chip may or may not be
used for actual fan speed monitoring on your specific system.

Do you see any fan speed or temperature values in your BIOS setup
screen?

> I just tried the SVN snapshot and got this output:
> 
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `ITE'...                                      Yes
> Found unknown chip with ID 0x7401
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found unknown chip with ID 0x7401
> Trying family `VIA/Winbond/Fintek'...                       No
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `ITE'...                                      No
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No

I updated the script with the new device ID values, please give it a
try:
  http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
It should find your chip now.

-- 
Jean Delvare

