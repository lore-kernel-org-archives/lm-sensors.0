From: JGong@winbond.com (JGong at winbond.com)
Date: Mon, 08 Jan 2007 08:49:59 +0000
Subject: [lm-sensors] sensors.conf for supermicro x7dbe+
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE01A31584@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701031701.08165.nromer@arcmailtech.com>
In-Reply-To: <200701031701.08165.nromer@arcmailtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi, Rudolf, Noah

>> w83793-i2c-0-2f
>> Adapter: SMBus I801 adapter at 1100
>> VCoreA:    +1.22 V  (min =  +0.92 V, max =  +1.49 V)   
>> VCoreB:    +1.26 V  (min =  +0.92 V, max =  +1.49 V)   
>> -12V:      +1.49 V  (min =  +1.34 V, max =  +1.65 V)   
>> +1.5V:     +3.30 V  (min =  +2.96 V, max =  +3.63 V)   
>> +3.3V:    +11.90 V  (min = +10.75 V, max = +13.25 V)   
>> +12V:      +4.97 V  (min =  +4.49 V, max =  +5.50 V)   
>> +5V:       +4.92 V  (min =  +4.49 V, max =  +5.50 V)   
>> 5VSB:      +3.25 V  (min =  +2.99 V, max =  +3.66 V)   


>Why has your board 5VSB connected to 3.3V? The chip specs say it needs
this >to be 5V? Maybe Supermicro did this wrong??? (I checked different
board and >it has there 5V)
>Please can you ask them if pin7 5VSB is connected to 5VSB?

According to the voltage readings, I think Noah's sensor.conf may be
something wrong like this:

label in0 "VcoreA"
label in1 "VcoreB"
label in3 "-12V"
label in5 "+1.5V"
label in6 "+3.3V"
label in7 "+12V"
label in8  "+5V"
label in9  "5VSB"

So the output seems a little messy, try this one, Noah.

    label in0 "VCoreA"
    label in1 "VCoreB"
    label in2 "Vtt"
    label in3 "-12V"
    label in4 "+1.5V"
    label in5 "+3.3V"
    label in6 "+12V"
    label in7 "+5V"
    label in8 "5VSB"
    label in9 "VBAT"

>> cpu0_vid: +1.075 V (VRM Version 10.0)
>> cpu1_vid: +0.000 V (VRM Version 10.0)
>This is also bit strange, maybe it is not connected.

Well, Rudolf, usually the motherboard manufacturer uses the w83793's PIN
49-56 for fan usage, and in fact we can see the register of VIDB latch
value to judge whether the VIDB has been connected. On my w83793 board,
the VIDB has not been connected...

Best regards,
PI14
Gong Jun


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

