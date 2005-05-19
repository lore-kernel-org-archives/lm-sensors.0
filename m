From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: [Fwd: DS1780]
Message-Id: <3ED6AB27.6090701@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3ECBA7D9.6050601@netroedge.com>
In-Reply-To: <3ECBA7D9.6050601@netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

For starters please look at your board and verify that you have two DS1780's.

Philip Edelbrock wrote:
> 
> 
> -------- Original Message --------
> From:     - Wed May 21 09:22:23 2003
> X-UIDL:     e57cf165e60880d9
> X-Mozilla-Status:     0001
> X-Mozilla-Status2:     00000000
> Return-Path:     <burt@bnl.gov>
> Received:     from smtpgw3.bnl.gov (smtpgw3.bnl.gov [130.199.3.20]) by 
> Ren.netroedge.com (8.12.8p1/8.9.1) with ESMTP id h4LDKx4e004000 for 
> <phil@netroedge.com>; Wed, 21 May 2003 06:21:00 -0700
> Received:     from bar.chm.bnl.gov ([130.199.177.226] helo=bnl.gov) by 
> smtpgw3.bnl.gov with esmtp (Exim 3.36 #1 ) id 19ITd1-00083s-00; Wed, 21 
> May 2003 09:27:35 -0400
> Message-ID:     <3ECB7EC3.5070100@bnl.gov>
> Date:     Wed, 21 May 2003 09:27:31 -0400
> From:     Burt Holzman <burt@bnl.gov>
> User-Agent:     Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) 
> Gecko/20021003
> X-Accept-Language:     en-us, en
> MIME-Version:     1.0
> To:     frodol@dds.nl, phil@netroedge.com
> Subject:     DS1780
> Content-Type:     text/plain; charset=ISO-8859-1; format=flowed
> Content-Transfer-Encoding:     8bit
> X-MailScanner:     Found to be clean
> X-SpamBouncer:     1.5 (8/16/02)
> X-SBRule:     Garbled Charset
> X-SBClass:     Blocked
> X-Spambayes-Classification:     ham; 0.01
> 
> 
> 
> Hello,
> 
> In the adm9240 documentation for lm-sensors, it states to get in touch 
> with you if you have a DS1780; well apparently I do:
> 
> ds1780-i2c-0-2c
> Adapter: SMBus I801 adapter at ccd0
> Algorithm: Non-I2C SMBus adapter
> 2.5V:      +2.51 V  (min =  +2.22 V, max =  +2.72 V)
> Vccp1:     +1.68 V  (min =  +2.40 V, max =  +2.93 V)   ALARM
> 3.3V:      +1.49 V  (min =  +2.93 V, max =  +3.59 V)   ALARM
> 5V:        +5.02 V  (min =  +4.45 V, max =  +5.44 V)
> 12V:      +11.93 V  (min = +10.68 V, max = +13.06 V)
> Vccp2:     +1.70 V  (min =  +2.40 V, max =  +2.93 V)   ALARM
> fan1:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> temp:      +42.0?C  (limit =  +60?C, hysteresis =  +50?C)
> vid:      +1.70 V
> alarms:   Chassis intrusion detection                  ALARM
> 
> ds1780-i2c-0-2d
> Adapter: SMBus I801 adapter at ccd0
> Algorithm: Non-I2C SMBus adapter
> 2.5V:      +1.08 V  (min =  +2.22 V, max =  +2.72 V)   ALARM
> Vccp1:     +1.47 V  (min =  +2.40 V, max =  +2.93 V)   ALARM
> 3.3V:      +3.31 V  (min =  +2.93 V, max =  +3.59 V)
> 5V:        +3.33 V  (min =  +4.45 V, max =  +5.44 V)   ALARM
> 12V:      +11.93 V  (min = +10.68 V, max = +13.06 V)
> Vccp2:     +1.78 V  (min =  +2.40 V, max =  +2.93 V)   ALARM
> fan1:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> temp:      +41.5?C  (limit =  +60?C, hysteresis =  +50?C)
> vid:      +1.95 V
> alarms:   Chassis intrusion detection                  ALARM
> 
> Let me know if there's anything else you'd like to know, clearly the 
> voltage measurements are not right.
> 
> - B
> 
> 
> 
> 
> 
