From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: pwmconfig: bug in temporary file creation
Message-Id: <41FBB15B.3000409@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050124140712.GA17184@bode.aurel32.net>
In-Reply-To: <20050124140712.GA17184@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

actually I don't have mktemp either.
But the redhat man page for it is dated 1996 so I may be a little behind the times...
so I'm OK with the patch if everybody else has mktemp


Jean Delvare wrote:
> Hi Aurelien,
> 
> 
>>They differs by the fact tempfile uses tempnam(), whereas mktemp uses
>>mkstemp(). I don't know exactly the difference, but after reading the
>>manpage, it seems that tempnam() only return a valid filename, whereas
>>mkstemp() create a file with 0600 permissions, and return its name.
>>
>>So, it's seems that mkstemp() is more secure, as it is possible to
>>create a file between the call to tempnam() and actual creation of the
>>file. However, it's only my interpretation, I am not sure about that.
> 
> 
> This page seems to confirm this:
> http://www.fr.linuxfromscratch.org/view/lfs-cvs/chapter06/lfs-utils.html
> 
> "mktemp creates temporary files in a secure manner. It is used in
> scripts.
> 
> tempfile creates temporary files in a less secure manner than mktemp. It
> is installed for backwards-compatibility."
> 
> They don't give details though.
> 
> So let's go with mktemp. Mark, can you confirm that you have mktemp on
> your system(s)?
> 
> Thanks,
> --
> Jean Delvare
> 
> 
