From: David Cussans <David.Cussans@bristol.ac.uk>
Date: Fri, 25 Jun 2010 08:38:33 +0000
Subject: Re: [lm-sensors] ASUS P7P55D PRO
Message-Id: <4C246B09.8040500@bristol.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <43865.137.222.58.99.1277137848.squirrel@webmail.bris.ac.uk>
In-Reply-To: <43865.137.222.58.99.1277137848.squirrel@webmail.bris.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Luca,
     Many thanks for your mail, and the information that where is an 
ACPI driver that should work.

     Alas, I am using Scientific Linux 5.4 ( a variant of RHEL 5.x ) 
which uses kernel version 2.6.18, where this driver isn't present. 
Although I am very keen to find out how hot the CPU is running I doubt I 
will have time to back-port the asus_atk0110 driver and I am reluctant 
to risk breaking a lot of other things by moving away from a locally 
supported platform.

     I don't really understand which firmware is using the hardware 
monitoring device (W83667HG-B ? ). Forgive my confusion, but is it 
possible, even in theory, to write a user-space lm_sensors driver for 
this motherboard?

         Regards,
                 David


On 22/06/10 12:32, Luca Tettamanti wrote:
> On Mon, Jun 21, 2010 at 6:30 PM, DG Cussans<David.Cussans@bristol.ac.uk>  wrote:
>    
>> Hi,
>>    I have a PC with a ASUS p7p55d motherboard. sensors-detect indicates
>> that it uses a W83667HG-B
>> Is there any estimate of how long it will take before there is a driver
>> for this device?
>>      
> The native driver won't load because the hwmon chip is actively used
> by the firmware. asus_atk0110 should work fine on this board.
>
> Luca
>    


-- 
Dr David Cussans                University of Bristol,
office: +44-(117)-95 46879      H.H. Wills Physics Laboratory,
    lab: +44-(117)-33 17199      Tyndall Avenue,
    fax: +44-(117)-925 5624      Bristol BS8 1TL, UK


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
