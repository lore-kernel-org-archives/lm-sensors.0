From: ymu@Winbond.com.tw (Yuan Mu)
Date: Mon, 15 May 2006 02:22:55 +0000
Subject: [lm-sensors] Newbie help
Message-Id: <4467E5FF.4050507@winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY113-W7FF2DFDEDE7A866B1CE20F0AD0@phx.gbl>
In-Reply-To: <BAY113-W7FF2DFDEDE7A866B1CE20F0AD0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Paul Wagner wrote:
> Yes I hit enter at all prompts when installing
> 
> but it did not move the lm sensors file
> 
>  
> 
>  ~]# locate lm_sensors
> /etc/sysconfig/lm_sensors
> 
> 
>  ~]# service lm_sensors start
> lm_sensors: unrecognized service
> 
> 
>  ~]# sensors
> Can't access procfs/sysfs file
> Unable to find i2c bus information;
> For 2.6 kernels, make sure you have mounted sysfs and libsensors
> was compiled with sysfs support!
> For older kernels, make sure you have done 'modprobe i2c-proc'!
> 
There's a good FAQ
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section-4_002e20

I have a FC5 and what i do to set up lm_sensors is:

1.Install *libsysfs* to avoid compile error when "make user"
2.Install lm_sensors use "make clean && make user && make user_install"
3.run sensors-detect, press enter for all question :)
4."service lm_sensors start"
5."sensors"

And it works.

Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

