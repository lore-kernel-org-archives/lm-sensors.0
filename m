From: elenstev@mesatop.com (Steven Cole)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Message-Id: <426583D5.2020308@mesatop.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com> <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Greg KH <gregkh@suse.de>, Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

Linus Torvalds wrote:
> 
> On Tue, 19 Apr 2005, Greg KH wrote:
> 
>>Nice, it looks like the merge of this tree, and my usb tree worked just
>>fine.
> 
> 
> Yup, it all seems to work out.

[many files patched]
patching file mm/mmap.c
patching file net/bridge/br_sysfs_if.c
patching file scripts/ver_linux
----------------------^^^^^^^^^
Hey, that's my patch!  Last...and least.
But perhaps a progress bar right about here might be
a good thing for the terminally impatient.

real    3m54.909s
user    0m14.835s
sys     0m10.587s

4 minutes might be long enough to cause some folks to lose hope.

Steven
