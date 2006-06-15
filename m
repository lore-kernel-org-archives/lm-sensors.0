From: dan@dogsbody.org (Dogsbody)
Date: Thu, 15 Jun 2006 16:01:23 +0000
Subject: [lm-sensors] ASUS K8V-X SE should be supported?
Message-Id: <44918453.9030604@dogsbody.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <448F748D.5000703@dogsbody.org>
In-Reply-To: <448F748D.5000703@dogsbody.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Maybe it should be redhat ? they sold EL to you ;)

No they didn't, I'm running CentOS ;)


> Ok, i try to make 627ehf work on my board this morning, and the 
> attachment is the results.
> 
> 1. You need to install EL kernel source first(if not installed)
> 2. unzip the attachment.
> 3. "cd lm_sensors26/old"
> 4. "make install"(i hope you have load the bus driver correctly)

Thank you very much for this unfortunately I have fallen at the first hurdle :-\
I thought I had managed to install the kernel source [1] but I can't get your 
makefile to run properly.  Compiling stuff I am happy with but I have never gone 
near the kernel before so I am not sure what I am doing there I'm afraid.


> I must said i hope it can help you, but without WARRANTY.It's in a hurry.
> And hope you can help test the 627ehf driver which Rudolf and David 
> working on :)

I saw the posts about the driver which is great :-)  I will help where I can but 
I don't want to be a burden.

Thanks again

Dan

[1]
wget http://mirror.centos.org/centos/4/updates/SRPMS/kernel-2.6.9-34.0.1.EL.src.rpm
rpm -iv kernel-2.6.9-34.0.1.EL.src.rpm


