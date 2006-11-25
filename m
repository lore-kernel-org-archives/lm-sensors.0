From: r.marek@assembler.cz (Rudolf Marek)
Date: Sat, 25 Nov 2006 11:54:29 +0000
Subject: [lm-sensors] CPU temperature(s) of Conroe
Message-Id: <45682EF5.8040908@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20061123T125301-366@post.gmane.org>
In-Reply-To: <loom.20061123T125301-366@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> I have downloaded this patch. I understand that this is a C program. But 
> I don't know where to put it and what to do with it. Could you please 
> give me guidance?

Yep I can. What distribution are you using? Debian? Fedora? Suse? ..?

>> Yes but not yet in kernel. You will need latest SVN snapshot of 
>> lm-sensors (make user_install)
> 
> I downloaded the last SVN (2006/11/18), extracted, make user, make 
> user_install. So far everything worked fine. Then I ran sensors-detect. 
> It was revision 1.413 (2006/01/19) which I suspect not being the most 
> recent one. It again only found the LM78 (because of the missing patches?).
> Do I have to uninstall the previous version of lm-sensors before 
> installing the new version?

Yes you will need to uninstall the package called "lm-sensors" or libsensors3 
the make user_install stuff is "outside" your packaging system. Ie it is same as 
you would just copy some software to your disk drive. And because you want that 
newer version without installer (no package) you  need to uninstall the package 
first. In short:

Because now you have installed two in the system. One sensors detect you have in 
/usr/sbin/sensors-detect and other you have in (the new one) /usr/local/sbin

Try to issue following command:

/usr/local/sbin/sensors-detect

>> and also this set of patches:
> The same problem for me as before: I downloaded the file, recognized it 
> as a C program, but don't know how to proceed.

Well this is a bit tricky to do. First I need to know what distribution you are 
using. Compiling new kernel image is certainly not task for beginners, but we 
may try.

Regards
Rudolf

