From: ymu@winbond.com (Yuan Mu)
Date: Fri, 16 Jun 2006 01:57:37 +0000
Subject: [lm-sensors] ASUS K8V-X SE should be supported?
Message-Id: <44921011.8000204@winbond.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <448F748D.5000703@dogsbody.org>
In-Reply-To: <448F748D.5000703@dogsbody.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dogsbody wrote:
>> Maybe it should be redhat ? they sold EL to you ;)
> 
> No they didn't, I'm running CentOS ;)
> 
> 
>> Ok, i try to make 627ehf work on my board this morning, and the 
>> attachment is the results.
>>
>> 1. You need to install EL kernel source first(if not installed)
>> 2. unzip the attachment.
>> 3. "cd lm_sensors26/old"
>> 4. "make install"(i hope you have load the bus driver correctly)
> 
> Thank you very much for this unfortunately I have fallen at the first hurdle :-\
> I thought I had managed to install the kernel source [1] but I can't get your 
> makefile to run properly.  Compiling stuff I am happy with but I have never gone 
> near the kernel before so I am not sure what I am doing there I'm afraid.
> 

Next time please do "make 2>&1 | tee make.out", give me the make.out :)
> 
>> I must said i hope it can help you, but without WARRANTY.It's in a hurry.
>> And hope you can help test the 627ehf driver which Rudolf and David 
>> working on :)
> 
> I saw the posts about the driver which is great :-)  I will help where I can but 
> I don't want to be a burden.
> 
> Thanks again
> 
> Dan
> 
> [1]
> wget http://mirror.centos.org/centos/4/updates/SRPMS/kernel-2.6.9-34.0.1.EL.src.rpm
> rpm -iv kernel-2.6.9-34.0.1.EL.src.rpm
> 
hmm, a step to install RedhatEL source code, for your reference.
1. rpm -ivh kernel-2.6.9-22.EL.src.rpm
2. rpmbuild -bp --target=noarch /usr/src/redhat/SPECS/kernel-2.6.spec
3. cd /usr/src
4. ln -s redhat/BUILD/kernel-2.6.9/linux-2.6.9  /linux
5. cd /usr/src/linux
6. make mrproper
7. cp ./configs/kernel-2.6.9-x86_64-smp.config ./config
8. vi Makefile   added=> EXTRAVERSION =-22.ELsmp
9. make menuconfig => only save & exit
10. make all
11. make modules_install
12. make install
13. reboot system


-- 
Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

