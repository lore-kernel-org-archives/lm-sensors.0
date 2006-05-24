From: ymu@Winbond.com.tw (Yuan Mu)
Date: Wed, 24 May 2006 08:45:49 +0000
Subject: [lm-sensors] w83792d works under 2.6 kernel, but not 2.4 kernel
Message-Id: <44741D3D.6090803@winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <44730D34.4080802@morison.biz>
In-Reply-To: <44730D34.4080802@morison.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rod Morison wrote:
> Rudolf Marek wrote:
>> Hello,
>>
>> As for the 2.4 version I cannot see that you have loaded the w83792d 
>> kernel module.
>>
>> Please try the modprobe w83792d
>> and then sensors
> You're right. Now I'm fairly sure I have all the sensor bus/chip drivers 
> loaded under 2.4 that are loaded in the 2.6 kernel, but still I'm 
> missing the w83792d-i2c-0-2f information. Is it possible that I need to 
> load the w83792d driver with some option settings?
> 
> Am I missing something else?
> 
Is there Any information about w83792d in "/proc/sys/dev/sensors" ?
Any messages when load the driver?

Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

