From: ConiKost@gmx.de (ConiKost at gmx.de)
Date: Wed, 09 Aug 2006 11:23:59 +0000
Subject: [lm-sensors] Sensors are not working :(
Message-Id: <20060809112359.285100@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Guys!        I got here installed Gentoo Linux with Kernel 
2.6.18-rc4.        I got this mini pc: 
http://www.dtresearch.com/prod_webDT168.html        ?        There seems 
to be the LM82 Sensors but i just can't get this working.        ?        
sensors-detect don't find any sensors :( I enabled Geode Access Bus, lm83 
modules (its supports lm82), and the i2c modules ...        ?        when 
i try to load lm83 i get this in /var/log/messages:        ?        Aug? 
9 11:47:07 BlackBox i2c-core: driver [lm83] registered
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: found normal entry for adapter 
0, addr 0x18
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: size=0, address=0x18, 
command=0x0, len=0, read=0
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: state quick, status = 0x43
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: state write, status = 0x13
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: negative ack in state write
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: transfer done, result: -6
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: found normal entry for adapter 
0, addr 0x19
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: size=0, address=0x19, 
command=0x0, len=0, read=0
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: state quick, status = 0x43
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: state write, status = 0x13
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: negative ack in state write
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: transfer done, result: -6
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: found normal entry for adapter 
0, addr 0x1a
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: size=0, address=0x1a, 
command=0x0, len=0, read=0
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: state quick, status = 0x43
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: state write, status = 0x13
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: negative ack in state write
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: transfer done, result: -6
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: found normal entry for adapter 
0, addr 0x29
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: size=0, address=0x29, 
command=0x0, len=0, read=0
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: state quick, status = 0x43
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: state write, status = 0x13
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: negative ack in state write
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: transfer done, result: -6
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: found normal entry for adapter 
0, addr 0x2a
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: size=0, address=0x2a, 
command=0x0, len=0, read=0
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: state quick, status = 0x43
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: state write, status = 0x13
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: negative ack in state write
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: transfer done, result: -6
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: found normal entry for adapter 
0, addr 0x2b
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: size=0, address=0x2b, 
command=0x0, len=0, read=0
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: state quick, status = 0x43
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: state write, status = 0x13
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: negative ack in state write
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: transfer done, result: -6
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: found normal entry for adapter 
0, addr 0x4c
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: size=0, address=0x4c, 
command=0x0, len=0, read=0
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: state quick, status = 0x43
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: state write, status = 0x13
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: negative ack in state write
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: transfer done, result: -6
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: found normal entry for adapter 
0, addr 0x4d
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: size=0, address=0x4d, 
command=0x0, len=0, read=0
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: state quick, status = 0x43
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: state write, status = 0x13
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: negative ack in state write
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: transfer done, result: -6
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: found normal entry for adapter 
0, addr 0x4e
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: size=0, address=0x4e, 
command=0x0, len=0, read=0
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: state quick, status = 0x43
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: state write, status = 0x13
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: negative ack in state write
Aug? 9 11:47:07 BlackBox i2c_adapter i2c-0: transfer done, result: -6
        Please help :(    
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060809/e3b88702/attachment.html 
