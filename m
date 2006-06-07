From: andy@warmcat.com (Andy Green)
Date: Wed, 07 Jun 2006 10:18:36 +0000
Subject: [lm-sensors] Black box flight recorder for Linux
Message-Id: <4486A7FC.2090904@warmcat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44379AB8.6050808@superbug.co.uk>	<m3psjqeeor.fsf@defiant.localdomain>	<443A4927.5040801@warmcat.com>	<m3zmgqxjs8.fsf@defiant.localdomain> <20060607100349.a990e054.khali@linux-fr.org>
In-Reply-To: <20060607100349.a990e054.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Jean Delvare wrote:

Hi Folks -

Impressed with Krzysztof doing the work!

>> The first part is the "console" driver (obvious parts removed). It works
>> with both my Asus A7V333 (VIA KT333, VIA SMBUS driver) and with VGA DDC
>> interface on a Cirrus Logic GD 5446 VGA chip (simplified source attached
>> as well). Using respectively 2464 and 24512 set to ID 0x57.
> 
> How do you intend to connect your device to the DDC channel if there's
> already a monitor connected to the VGA or DVI port?

For both VGA and DVI I think the optimal answer is to build a small 
back-back breakout adapter.  The parts seem to be quite reasonably 
priced and reasonably available, eg from Farnell (www.farnell.co.uk):

VGA: Plug partcode 1071807 GBP 1.76   Socket partcode 1071811 GBP 2.10

DVI: Plug partcode 9965190 GBP 1.38   Socket partcode 1012227 GBP 2.01


If the original cabling looks like this:

   <Video card Socket>
     |
   <Original Cable Plug>
     |
     |
     |
   <Original Cable Plug>
     |
   <Monitor Socket>


then the breakout concept looks like this:

   <Video card Socket>
     |
   <Adapter Plug>
     |--------------------- I2C signal wires broken out
     |                      All wires passed to corresponding pins
   <Adapter Socket>
     |
   <Original Cable Plug>
     |
     |
     |
   <Original Cable Plug>
     |
   <Monitor Socket>

> Beware that many monitors have EDID EEPROMs responding to all I2C
> addresses within the 0x50 - 0x57 range, so it'll be hard to add an
> EEPROM on the bus for your own purpose without hitting an address
> conflict.

The adapter does give an opportunity to interrupt the connectivity of 
the I2C to the monitor if worst comes to worst, I guess no traffic is 
typically present after X init or Linux touching it.  Pretty ugly that 
things ignore b2-b0 of the I2C address.

A whole other way forward is to consider to replace the EEPROM from the 
original proposal (which does provide its own advantages such as 
simplicity, I accept) with something else that ends up on another PC. 
In this concept some logic presents a fake I2C peripheral to the DDC 
interface at an I2C address of our choosing.  This logic acts as a 
bidirectional "UART" type of thing, allowing transfer of data in both 
directions between the Linux box being debugged and another PC.

I designed something conceptually similar for the effort to hack the 
original Xbox, which was very effective (and is GPL'd):

http://warmcat.com/milksop/filtror.html

However this would be much simpler, not even needing RAM.  It can hook 
to the second PC by the same I2C method, parallel printer port, RS232 or 
USB depending on the level of complexity of the design.

I guess the link will feel quite like a 9600 or 19200 baud serial port 
in terms of throughput.

>> The following is an adapter for Cirrus Logic 5446 VGA on my old R440LX
>> test machine:
>>
>> There is a locking problem - the VGA is (can be) shared between VT console,
>> X11 and the driver. I'll look at CL FB driver to see how/if it's done.
> 
> The current trend is to merge the DDC access driver into the
> framebuffer driver. This solves one of the conflicts, and also makes
> sense because the EDID data can be used to automatically setup the
> framebuffer. We still have a few standalone DDC access drivers
> (i2c-i810, i2c-savage4...) but they are considered deprecated and will
> probably be deleted in a near feature.
>
> This will be a second problem for you though. Most distributions don't
> make use of hardware-specific framebuffer drivers by default, but use
> the VESA framebuffer driver. This driver doesn't have DDC support.

Maybe this effort is considered too esoteric, but it seems to me to be a 
reason to keep the DDC access drivers standalone, the hardware-specific 
framebuffer drivers can call through to them and we can use them in a 
clean way.  I realize this is a bit of a late objection and that there 
was not previously much point to keeping them as separate things in the 
world.

> Note that I am not trying to dicourage you, Andy's idea has merit for
> sure. I just mean that it won't be usable by everyone out of the box.
> People will have to use the right driver and pay attention to address
> conflicts.

Address conflicts we can solve by widening the scope and powers of the 
interface into a generic communications link by adding a little 
hardware, removing the address clash.  If basically magic-ing a 
cheap-to-drive comms link out of nowhere, on most all PC-type hardware, 
has value then maybe it can sway people to keep the separated DDC drivers.

-Andy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4492 bytes
Desc: S/MIME Cryptographic Signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060607/4c483431/attachment.bin 
