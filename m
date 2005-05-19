From: X.Xiao@motorola.com (Xiao Xianghua-r6aads)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Motorola I2C driver question
Message-Id: <BB30349BF3FE18418DC420BDDCAE22AF0267F046@az33exm54.corp.mot.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Re-send. Simon's email address in kernel's maintainer list seems invalid.

As Mark Studebaker sugggested, I will consult this with the PPC mailing list as well and try to find a place to hold the I2C patch against the kernel initially (if needed).

Thanks,

Xianghua

>>-----Original Message-----
>>From: Xiao Xianghua-r6aads 
>>Sent: Thursday, October 23, 2003 10:10 AM
>>To: 'simon@tk.uni-linz.ac.at'
>>Cc: Xiao Xianghua-r6aads
>>Subject: Motorola I2C driver question
>>
>>
>>Simon,
>>
>>I am an engineer from Motorola working in I2C driver. I 
>>noticed you're the maintainer for Linux kernel's I2C driver 
>>and I have some questions about submitting I2C drivers to the 
>>kernel source,hopefully you have time to answer.
>>
>>I recently sent an email to the lmsensor mailing list 
>>regarding consolidating I2C Linux drivers for Motorola chips. 
>>Basically we only need two I2C drivers for all Motorola 
>>chips. I have contacted a few other authors(Michael on 8245, 
>>Adrian,Wolfgang Denx)...we all worked on the same thing and 
>>it's time to consolidate :)
>>
>>My question is about the procedures to get the Motorola I2C 
>>driver into the kernel. For most PPC related patches, we sent 
>>to the PPC maintainer directly. However it's my understanding 
>>that all I2C drivers will be sent to you and the Lmsensor 
>>team before it can be merged to the kernel source, am I 
>>correct? If yes, I will send my consolidated patch to you 
>>directly and hope you can add it into your the I2C package. If 
>>No, please let me know and I will contact the PPC maintainer instead.
>>
>>My second question is that do I need submit 2.6 patch at the 
>>same time?
>>
>>My last question is about the Lmsensor package, I wrote an 
>>algo driver, an adaptor driver(both should be in i2c package, 
>>e.g i2c.2.8.1), and used lmsensor package to test this 
>>driver(i.e. eeprom tests, I modified it a little bit). I will 
>>only submit these two drivers and will share the utilities in 
>>lmsensor package, is it acceptable or I have to write 
>>something specifically for the lmsensor package?
>>
>>Thanks a lot,
>>
>>Xianghua
>>
>>
>>
