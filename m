From: spamguard@earthlink.net (Spam Guard)
Date: Tue, 14 Jun 2005 18:22:23 +0000
Subject: [lm-sensors] Configuring I2C on a Thinkpad T42
Message-Id: <42AF040C.8090109@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I was hoping you might help resolve some confusion on my part regarding I2C.

I have a Thinkpad T42, and as far as I can tell, it has an Intel 82801
SMBus (which I gather from the output of lspci), and a National
Semiconductor PC87591 sensors chip (which I read at
http://archives.andrew.net.au/lm-sensors/msg31277.html).

I'm not completely new to Linux, but I don't know much about I2C,
although I've read some of the basics.  From what I understand, I2C can
be used by lm-sensors, and possibly by ACPI. 

I've read ominous things about lm-sensors in regards to Thinkpads (at
http://www.thinkwiki.org/wiki/Problem_with_lm-sensors), but I don't know
if this means that I should abandon trying to get any benefit from the
I2C bus.

Here's a few questions I have:

   1. Do I need to have the kernel configured for /both/ hardware bus
      support /and/ sensors chip support to get any value out of I2C, or
      is it possible there are other devices on the bus that might be of
      service?
   2. Is there any great way to confirm that Thinkpad T42's actually
      have a NS PC87591 sensors chip?  I was hesitant to run the
      sensors-detect on my Thinkpad because of sharp warnings I found
      on-line.
   3. If I can't use lm-sensors on a Thinkpad, does ACPI rely at all on
      I2C?  If so, what kind of configuration do I need to set that up
      (kernel-wise or user-space-wise)?
   4. How should I test that I2C is working when everything's all set up?

I appreciate any feedback you can provide, even if just pointing me
towards other resources.

Thanks,
Sukant
