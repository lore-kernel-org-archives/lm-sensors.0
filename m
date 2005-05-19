From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: RFC: vid scaling does not belong in kernel?
Message-Id: <14b451tlic7clc0rgn5aquvd4iqa7mre55@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

vid and vrm are two of the strangest things I met in lmsensors.

Here we have user space telling kernel how to scale a value the 
kernel does nothing with.  If I produce a set of patches to remove 
vid scaling from the drivers: adm1025.c, adm1026.c, asb100.c, 
it87.c, lm85.c, lm87.c, pc87360.c, w83627hf.c and w83781d.c we 
save nine write accessors and can remove the vrm stuff to user-
space where it belongs, with the other scaling, simplifying the 
read accessors by removing the scaling requirement.

vid sense pins don't do anything, thus the vid sense state should 
be reported truthfully to user-space, it may do something with the 
value.  

Please somebody tell me what I've missed here?

Cheers,
Grant.
