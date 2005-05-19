From: demeterft@dremium.com (Demeter F. Tamas)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: problem with via686a sensor (lm-sensors 2.6.3) - bug + resolve
Message-Id: <3CEA5928.6060201@dremium.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi,

I want to install lm-sensor 2.6.3 on my system (ABIT-KT7 mobo) and i 
couldn't get info about the via686a chip.
So I started to browse the code and I found a bug in the 
prog/sensors-detect script.
when it detect a VT82C686 chip it set the procid => "VIA Technologies 
VT82C686 Apollo ACPI" but in the sub via686a_isa_detect it try to 
compare the procid with the "VIA Technologies VT 82C686 Apollo ACPI" 
string and the result of the comparing is false because "VT 82C686" # 
"VT82C686".
When I corrected this mistake the detecting become fine.

Best Regards,


              Demeter F. Tam?s

              ---------------------------------------------------------
              Web......: http://www.dremium.com
              Web......: http://www.dreamgate-design.com
              E-mail...: demeterft@dremium.com
              E-mail...: demeterft@dreamgate-design.com
              E-mail...: demeterft@mail.datanet.hu
              Tel/Phone: (36-20) 450 99 91
              Tel/Phone: (36-70) 258 59 17
              Tel/Phone: (36-94) 331 771
					  							   
							   

