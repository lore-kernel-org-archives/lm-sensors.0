From: post@hendrik-sattler.de (Hendrik Sattler)
Date: Thu, 24 Aug 2006 10:40:23 +0000
Subject: [lm-sensors] linux-i2c and smbalert
Message-Id: <200608241240.24981.post@hendrik-sattler.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

in my notebook, I have a chip (namely O2 Micro OZ99x) that probably can do 
SMBALERTs for events (panel buttons in this case).
The SMBus specification[1] says that it's optional.

The only mentioning of alert reponse address (ARA) in the i2c-ali1535. And 
according to specs from intel[2], the i815 has it, too.

I guess, the interrupt handler should check if the interrupt was due to an 
SMBALERT and then handle the alert properly by issuing a read from the ARA 
(0x0C), thus finding the device address. Then it should call the driver that 
was registered for that address.

Was there any work done on this? I would really like to try this out with the 
above device combination, however the i2c-i810 doesn't even listen on the 
irq ?!?

HS

PS: I am not subscribed, so please CC: me

[1]: http://www.smbus.org/specs/smbus20.pdf or
     http://www.smbus.org/specs/smb10.pdf
[2]: http://www.intel.com/design/chipsets/datashts/29065503.pdf

