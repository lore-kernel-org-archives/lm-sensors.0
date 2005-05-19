From: frodol@dds.nl (frodol@dds.nl)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: bug in lm_sensors init script, (fwd)
Message-Id: <200210261103.g9QB3AM01336@shire.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Konstantin Osipov wrote:
From rabid@ringrows.ru Sat Oct 26 12:55:33 2002
Received: by morannon.frodo.local (8.11.3/8.11.3) id g9QAtX612765 ; Sat, 26 Oct 2002 12:55:33 +0200
Return-Path: <rabid@ringrows.ru>
Received: from pop3.dds.nl [213.196.1.204]
	by localhost with POP3 (fetchmail-5.4.4)
	for frodo@localhost (single-drop); Sat, 26 Oct 2002 12:55:33 +0200 (CEST)
Received: (qmail-ldap/ctrl 30724 invoked from network); 26 Oct 2002 10:44:52 -0000
Received: from unknown (HELO server.office) ([212.5.177.66]) (envelope-sender <rabid@ringrows.ru>)
          by dds.nl (qmail-ldap-1.03) with SMTP
          for <frodol@dds.nl>; 26 Oct 2002 10:44:52 -0000
Received: from rabid.office (rabid.office [192.168.1.220])
	by server.office (8.12.2/8.12.2/SuSE Linux 0.6) with ESMTP id g9QAioD3001589
	for <frodol@dds.nl>; Sat, 26 Oct 2002 14:44:50 +0400
Received: by rabid.office (Postfix on SuSE Linux 8.0 (i386), from userid 1024)
	id 525F113C6; Sat, 26 Oct 2002 14:46:51 +0400 (MSD)
Date: Sat, 26 Oct 2002 14:46:51 +0400
From: Konstantin Osipov <rabid@ringrows.ru>
To: frodol@dds.nl
Subject: bug in lm_sensors init script,
Message-ID: <20021026104651.GA5628@rabid.office>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
X-Loop-Procmail: PreventLoop

Hi, you guys have a bug in sensors init script: 

rabid:~ # diff -u /root/lm_sensors-2.6.5/prog/init/lm_sensors.init /etc/init.d/lm_sensors 
--- /root/lm_sensors-2.6.5/prog/init/lm_sensors.init    Thu Aug 29 06:20:01 2002
+++ /etc/init.d/lm_sensors      Sat Oct 26 14:44:19 2002
@@ -41,7 +41,6 @@
 CONFIG=/etc/sysconfig/lm_sensors
 
 # Source function library.
-. /etc/init.d/functions
 
 RETVAL=0
 
@@ -51,7 +50,7 @@
 
         modules=`grep \^MODULE_ $CONFIG | wc -l`
         i=0
-        while [ $i -lt $modules ] ; do
+        while [ $i -le $modules ] ; do
                 module=`eval echo '$'MODULE_$i`
                /sbin/modprobe $module &>/dev/null
                i=`expr $i + 1`
@@ -113,7 +112,7 @@
        condrestart
        ;;
   *)
-       echo "Usage: sensors.init {start|stop|status|restart|reload|condrestart}"
+       echo "Usage: lm_sensors {start|stop|status|restart|reload|condrestart}"
        exit 1
 esac
 
rabid:~ # 

-- 
 cheers
                                             


-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
