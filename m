From: ymu@winbond.com (Yuan Mu)
Date: Mon, 19 Jun 2006 06:37:38 +0000
Subject: [lm-sensors] ASUS K8V-X SE should be supported?
Message-Id: <44964632.6040807@winbond.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <448F748D.5000703@dogsbody.org>
In-Reply-To: <448F748D.5000703@dogsbody.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dan,

> There wasn't much point before as I couldn't install the source (no 
> /usr/src/linux).  However thanks to your help I have gotten much further!  it 
> still errors though.... :-(
> 
> make -C /usr/src/linux M=/tmp/lm_sensors26/old modules
> make[1]: Entering directory `/usr/src/redhat/BUILD/kernel-2.6.9/linux-2.6.9'
>    CC [M]  /tmp/lm_sensors26/old/w83627ehf.o
> In file included from /tmp/lm_sensors26/old/w83627ehf.c:44:
> /tmp/lm_sensors26/old/wbplatform.h:47: error: conflicting types for 'gfp_t'
> include/linux/gfp.h:134: error: previous declaration of 'gfp_t' was here
> /tmp/lm_sensors26/old/wbplatform.h:49: error: conflicting types for 'kzalloc'
> include/linux/slab.h:101: error: previous declaration of 'kzalloc' was here
> /tmp/lm_sensors26/old/wbplatform.h:49: error: conflicting types for 'kzalloc'
> include/linux/slab.h:101: error: previous declaration of 'kzalloc' was here
> make[2]: *** [/tmp/lm_sensors26/old/w83627ehf.o] Error 1
> make[1]: *** [_module_/tmp/lm_sensors26/old] Error 2
> make[1]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.6.9/linux-2.6.9'
> make: *** [all] Error 2

I modify something for you according to the error message, pls use the new attachment :)
I'm really sorry i don't have CentOs and i can not make sure it can work :(
Hope it can compile now.


-- 
Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors26_2.tar.gz
Type: application/gzip
Size: 12861 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060619/2b3f9bd3/attachment-0001.bin 
