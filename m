From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: (from cvs) sensors binary compile probs on rh8
Message-Id: <3E01CFC4.2090909@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DF93866.7070502@netroedge.com>
In-Reply-To: <3DF93866.7070502@netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The other day I put some makefile magic into lib/Module.mk which assumed /usr/lib and /lib were last. I'll rework it.

Jean Delvare wrote:
>>my man page for ld.so clearly says that /usr/lib and /lib are last.
>>You can also see this from the output of 'ldconfig -v'.
>>
>>Is yours different?
> 
> 
> arrakis:~> /sbin/ldconfig -Nv | grep ^/ | sed -e 's/:$//'
> /lib
> /usr/lib
> /opt/xpdf-1/lib
> /usr/local/lib
> /usr/X11R6/lib
> /usr/i386-slackware-linux/lib
> /opt/gnome/lib
> /usr/openwin/lib
> /opt/kde/lib
> 
> So I have /lib and /usr/lib first. Here follows my /etc/ld.so.conf for
> reference:
> 
> /opt/xpdf-1/lib
> /usr/local/lib
> /usr/X11R6/lib
> /usr/i386-slackware-linux/lib
> /opt/gnome/lib
> /usr/openwin/lib
> /opt/kde/lib
> 
> I guess the order depends on the system and we can't assume anything.
> Some shell/perl magic could let us know if more than one library is
> present and which one will be used. This is something I can do if you
> tell me where to do it and what it should do.
> 
