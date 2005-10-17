From: sevans@vmetro.com (Steve Evans)
Date: Mon, 17 Oct 2005 11:11:25 +0000
Subject: [lm-sensors] Support for Linux 2.6 only drivers
Message-Id: <507CF24DDCB8114C82ABCC09CBC1E9EE75C1D3@transtech-2000.transtech.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have written a driver for the Analogue Devices AD7417 temperature
sensor/quad ADC and have a couple of questions:
 
o My development calls only for Linux 2.6 support. Your "new_drivers"
document suggests that support should be provided for 2.4 and then
optionally also for 2.6. Is this still the current development model, or
are you now moving away from 2.4 support? I see from lib/chips.c that
the W83627EHF device is not supported for 2.4 (yet), so perhaps this is
the way things are moving?
 
o The driver has been written such that it should support the AD7416 and
AD7418 as well as the AD7417. These devices provide a subset of the
functionality of the AD7417 (fewer inputs etc.). Unfortunately I am not
able to test my code with these devices as my hardware only supports the
AD7417. Would you prefer to see such support present, but with an
"untested" comment, or removed completely?
 
Regards,
 
Steve
 

  _____  

Steve Evans

VMETRO Limited
Manor Courtyard
Hughenden Avenue
High Wycombe
Bucks HP13 5RE
Direct Line +44 (0) 1494 476023
Tel +44 (0) 1494 476000
Fax +44 (0) 1494 464472
www.vmetro.co.uk <http://www.vmetro.co.uk/> 	  VMETRO
Limited<http://www.vmetro.co.uk/emailimages/vmetroid.gif> 	
  _____  

This transmission is confidential and intended solely for the person or
organisation to whom it is addressed.
It may contain privileged and confidential information. If you are not
the intended recipient, you should not copy, distribute or take any
action in reliance on it. Please return any such mail to their
originator.

Although all messages/file attachments passing through this gateway are
scanned for viruses we cannot guarantee that any file is 100%
virus-free. 	
 
