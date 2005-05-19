From: khali@linux-fr.org (Khali)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: lm_sensors on ThinkPads
Message-Id: <1033204841.3d957469a4254@imp.free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020927134750.B20006@Stimpy.netroedge.com>
In-Reply-To: <20020927134750.B20006@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(BTW: I don't seem to have received the last two messages I sent to the list; 
is there something wrong?)

> dmi: read: Success
This sucks. Dmidecode failed and I found out why (pretty lame bug indeed). 
Patch attached.

Pam, do you have the time and knowledge to patch the dmidecode source that 
comes with lm_sensors-2.6.5 (in prog/detect IIRC), reinstall it and rerun 
sensors-detect? Could you also send us the output of dmesg and the output of 
dmidecode itself, would be perfect :)

I also attached a simple perl script. Please run it as root (I swear it is 
safe) and send me the output. It is an alternative method for IBM detection I 
am working on. If it works, we can get rid of dmidecode really soon.

> Obviously I hit ctrl-c at that point.
There were no risk of breaking anything... Well, in theory ;)

Thanks A LOT for testing, be sure we appreciate :)
Khali.
-------------- next part --------------
--- dmidecode.c	Fri Aug  9 23:26:31 2002
+++ dmidecode.c	Sat Sep 28 10:52:43 2002
@@ -644,7 +644,14 @@
 	struct dmi_header *dm;
 	u8 *data;
 	int i=0;
+	int r=0, r2=0;
 		
+	if(len=0)
+	{
+		fputs("dmi: no data\n", stderr);
+		return;
+	}
+	
 	if(buf=NULL)
 	{
 		perror("dmi: malloc");
@@ -655,7 +662,9 @@
 		perror("dmi: lseek");
 		return;
 	}
-	if(read(fd, buf, len)!=len)
+	while(r2!=len && (r=read(fd, buf+r2, len-r2))!=0)
+		r2+=r;
+	if(r=0)
 	{
 		perror("dmi: read");
 		return;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ibm.pl
Type: application/x-perl
Size: 1647 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020928/87c060d1/ibm.bin
