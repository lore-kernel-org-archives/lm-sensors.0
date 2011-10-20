From: Bijju Kranthi Veduruparthi <pheonixashes11@gmail.com>
Date: Thu, 20 Oct 2011 06:02:37 +0000
Subject: [lm-sensors] Query regarding temperature readings
Message-Id: <CAELdg1D0dCEg0e7wv6u=BmxCCy=4=uvyv3fG7PgzUSFoZAj5GQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5277065811329581585=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5277065811329581585==
Content-Type: multipart/alternative; boundary=00151761c840331c2f04afb489db

--00151761c840331c2f04afb489db
Content-Type: text/plain; charset=ISO-8859-1

Hi Team,

My problem with lm_sensors while reading temperature is as follows:

When I execute sensors command directly at the terminal, the temperature is
output to the terminal correctly.

But when I execute sensors from a c program using the system() function, the
temperature output to the terminal is more than the actual temperature.
Through a C program the output temperature is always atleast *8 to 10 degree
centigrade higher*.

Why does this problem arise? I am reading the temperature in an incorrect
way through C program?
Is there a better way to obtain temperature through C code?

--

--00151761c840331c2f04afb489db
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Team,<br><br>My problem with lm_sensors while reading temperature is as =
follows:<br><br>When I execute sensors command directly at the terminal, th=
e temperature is output to the terminal correctly.<br><br>But when I execut=
e sensors from a c program using the system() function, the temperature out=
put to the terminal is more than the actual temperature.<br>
Through a C program the output temperature is always atleast <b>8 to 10 deg=
ree centigrade higher</b>.<br><br>Why does this problem arise? I am reading=
 the temperature in an incorrect way through C program?<br>Is there a bette=
r way to obtain temperature through C code?<br clear=3D"all">
<br>-- <br><img src=3D"https://lh5.googleusercontent.com/-opxNuMogf0M/Te-Or=
eEIXjI/AAAAAAAAAg0/ze5DShlKly0/s912/FooterRightSignature.jpg"><br><br>

--00151761c840331c2f04afb489db--


--===============5277065811329581585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5277065811329581585==--

