From: lmsensors@lizardlogic.co.uk (Stig Telfer)
Date: Tue, 04 Oct 2005 12:51:54 +0000
Subject: [lm-sensors] Patch for i2c-elektor driver
Message-Id: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi -

Please excuse me if this is not the right place to send a patch.

I have updated the i2c-elektor driver to work on kernel 2.6.13.  The 
driver now compiles cleanly and works on my system.  However, I only 
have access to a UP2000 Alpha system to test the i2c-elektor driver.  I 
don't think anything else will be broken by this patch, but I don't 
have an Elektor ISA card to test to be certain.  Does anybody have one? 
  Are they still in use?

The patch is available at:

http://www.lizardlogic.co.uk/software/hwmon/elektor-alpha.patch

Share and Enjoy,
Stig Telfer

