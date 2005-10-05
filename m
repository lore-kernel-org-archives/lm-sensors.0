From: hcb@chaoticmind.net (Helge Bahmann)
Date: Wed, 05 Oct 2005 13:32:29 +0000
Subject: [lm-sensors] Myson MTP008 driver ported to 2.6 kernel
Message-Id: <Pine.LNX.4.44.0510051324220.17071-100000@lothlorien.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051004125511.GI7154@kira.glasswings.com.au>
In-Reply-To: <20051004125511.GI7154@kira.glasswings.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> On Tue, Oct 04, 2005 at 09:36:43PM +0200, Jean Delvare wrote:
> > There have been quite a few changes since then. Could you please
> > provide a patch against 2.6.14-rc2-mm2 or at least 2.6.14-rc3?
>
> Unfortunately the only server I have with this chip is a production
> server with paying customers, so I don't feel comfortable rebooting into
> a release candidate kernel.  I can probably get it to compile, though.
> I don't know when I'll have time to do this.

Do you have a version that makes use of dynamic sysfs callbacks? If not, I
will convert it myself, but if yes please send it to me so I don't waste
the afternoon

In any case I can test -rc and -mm kernels on my machine

Best regards
-- 
Helge Bahmann <hcb@chaoticmind.net>                     /| \__
The past: Smart users in front of dumb terminals       /_|____\
                                                     _/\ |   __)
$ ./configure                                        \\ \|__/__|
checking whether build environment is sane... yes     \\/___/ |
checking for AIX... no (we already did this)            |

