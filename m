From: Linux User <linuxuser17@yahoo.com>
Date: Fri, 17 Apr 2009 18:11:38 +0000
Subject: [lm-sensors] "suid root" bug in isadump/isaset
Message-Id: <250565.40871.qm@web44705.mail.sp1.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1401990719338767825=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============1401990719338767825==
Content-Type: multipart/alternative; boundary="0-1467348296-1239991898=:40871"


--0-1467348296-1239991898=:40871
Content-Type: text/plain; charset=us-ascii

Dear Lm- Sensors Developers,

both isadump and isaset contain the check:

  if (getuid()) {
    fprintf(stderr, "Error: Can only be run as root "
            "(or make it suid root)\n");
    exit(1);
  }

The text of the error message suggests that these programs could be installed "suid root". If  this is the case,
the check should use "geteuid()" instead of "getuid()".

Kind regards,
Linux User



      
--0-1467348296-1239991898=:40871
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman,new york,times,serif;font-size:12pt"><div>Dear Lm- Sensors Developers,<br><br>both isadump and isaset contain the check:<br><br>&nbsp; if (getuid()) {<br>&nbsp;&nbsp;&nbsp; fprintf(stderr, "Error: Can only be run as root "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "(or make it suid root)\n");<br>&nbsp;&nbsp;&nbsp; exit(1);<br>&nbsp; }<br><br>The text of the error message suggests that these programs could be installed "suid root". If&nbsp; this is the case,<br>the check should use "geteuid()" instead of "getuid()".<br><br>Kind regards,<br>Linux User<br></div></div><br>



      </body></html>
--0-1467348296-1239991898=:40871--



--===============1401990719338767825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1401990719338767825==--

