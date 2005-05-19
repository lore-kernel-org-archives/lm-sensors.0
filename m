From: nroeder@inf.ed.ac.uk (Nils Roeder)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: userspace  dev-interface linux-2.6.7
Message-Id: <4278D339.3000601@inf.ed.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <42775670.5070709@inf.ed.ac.uk>
In-Reply-To: <42775670.5070709@inf.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
[snip]

 >
 > There are two i2c-dev.h files, one for kernel-space and one for
 > user-space. If you are writing a user-space tool which will access
 > /dev/i2c-*, you need the user-space version of i2c-dev.h, which is
 > distributed with lm_sensors for historical reasons, although I believe
 > the kernel-headers package has a copy as well. This version will work
 > regardless of the version of the kernel you are using.
 >
 > Hope that helps,
 > --
 > Jean Delvare
 >
that helps indeed, thanks very much.
why is this not mentioned in
linux-2.6.x/Documentation/i2c/dev-interface ?

while it is mentioned in
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/developers/applications

thanks again,
   nils
