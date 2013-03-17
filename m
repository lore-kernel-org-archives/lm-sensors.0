From: Ross Moore <ross@rossmoore.net>
Date: Sun, 17 Mar 2013 05:43:59 +0000
Subject: [lm-sensors] IT8771E
Message-Id: <CAJDbZnQ-rGoUL+5F=e8cWD9Q8JQd+RXZ9ec=J8PC+8SE9P+=Cg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5875072426376920597=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5875072426376920597==
Content-Type: multipart/alternative; boundary=e89a8fb1fd74e1f9aa04d8185be1

--e89a8fb1fd74e1f9aa04d8185be1
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I see the IT87 driver has been updated to handle the IT8771E found on some
ASUS boards. I downloaded the latest it87.c, compiled it and loaded the
module.

My fans are now detected, and seem to report correctly - hurrah! However,
the pwm controls for those fans seem way out of wack, and appear to be on
the same chip.

Can I assist a developer in debugging the problem? My ASUS motherboard is
at your disposal...

Thanks,
Ross

--e89a8fb1fd74e1f9aa04d8185be1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi,<br><br></div>I see the IT87 driver=
 has been updated to handle the IT8771E found on some ASUS boards. I downlo=
aded the latest it87.c, compiled it and loaded the module.<br><br></div>My =
fans are now detected, and seem to report correctly - hurrah! However, the =
pwm controls for those fans seem way out of wack, and appear to be on the s=
ame chip.<br>
<br></div>Can I assist a developer in debugging the problem? My ASUS mother=
board is at your disposal...<br><br></div>Thanks,<br>Ross<br></div>

--e89a8fb1fd74e1f9aa04d8185be1--


--===============5875072426376920597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5875072426376920597==--
