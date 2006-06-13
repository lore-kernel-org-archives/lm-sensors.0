From: ymu@winbond.com (Yuan Mu)
Date: Tue, 13 Jun 2006 04:37:55 +0000
Subject: [lm-sensors] W83793 driver
Message-Id: <448E4123.1020506@winbond.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44893948.2070709@winbond.com>
In-Reply-To: <44893948.2070709@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,
> 
>> I have not send any news about w83793 driver because we met a problem --
>> the system always auto reboot even if
>> w83793 driver not loaded :(
>> Now they think the reason is the cpu fan is not fixed on the MB, and i
>> will try to make the driver work on
>> other version of kernels...
> 
> Well you may try to compile Machine check excpetion support and thermal
> throttling interrupt support. Then you will know if it has some thermal problems
> or not.
> 
> Well maybe you can do that without a hardware. Check the i2c-stub driver.
> 
> If we would create more inteligent i2c-stub driver that supports banks, then we
> can emulate this i2c chip with it. (This may work because registers are either
> RO/RW no special behaviour mostly) With the emulation I mean that when you write
> something to register it will be there.
> 
> The idea is following:
> You need to dump all chip banks with i2cdump command. Then the driver i2c-stub
> should be updated to support different banks. I could do it and test it on the
> W83792d hardware machine if we are willing to go this direction.
> 
Sounds interesting, i think we do not need to do this now since the machine did not
reboot for 3 days, maybe the reason is they use a aeroengine as the cpufan...
I will dig what you said after finish the schedule about 793 :)
Now I got it work on FC5 and FC4, but FC3 met the same problem as i met before,
maybe i801 driver missing ICH7 PCI ID, and i'm trying to make it work :(

>> Could you do me a favor to review the attached w83793 driver? i think i
>> must fix the bugs before do the backport.
> 
> I will just do a "quick" review later today and send you the results. I have in
> my queue also VT1211 driver, hopefully I can do both today or in near future.
> 

Thanks, and later a 2.4 version :p

-- 
Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

