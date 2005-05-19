From: frodol@dds.nl (frodol@dds.nl)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: Question to libsensors, due to a memory leak in a program. (fwd)
Message-Id: <200209181204.g8IC4d901065@shire.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Michael Zwick wrote:
From zwickmich@web.de Wed Sep 18 13:25:10 2002
Received: by morannon.frodo.local (8.11.3/8.11.3) id g8IBPAH28592 ; Wed, 18=
 Sep 2002 13:25:10 +0200
Return-Path: <zwickmich@web.de>
Received: from pop3.dds.nl [213.196.1.122]
	by localhost with POP3 (fetchmail-5.4.4)
	for frodo@localhost (single-drop); Wed, 18 Sep 2002 13:25:10 +0200 (CEST)
Received: (qmail-ldap/ctrl 6707 invoked from network); 18 Sep 2002 11:12:00=
 -0000
Received: from mailgate5.cinetic.de ([217.72.192.165]) (envelope-sender <zw=
ickmich@web.de>)
          by mx3.dds.nl (qmail-ldap-1.03) with SMTP
          for <frodol@dds.nl>; 18 Sep 2002 11:12:00 -0000
Received: from web.de (fmomail02.dlan.cinetic.de [172.20.1.46])
	by mailgate5.cinetic.de (8.11.2/8.11.2/SuSE Linux 8.11.0-0.4) with SMTP id=
 g8IBBxX11044
	for frodol@dds.nl; Wed, 18 Sep 2002 13:11:59 +0200
Date: Wed, 18 Sep 2002 13:11:59 +0200
Message-Id: <200209181111.g8IBBxX11044@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: Michael Zwick <zwickmich@web.de>
To: frodol@dds.nl
Subject: Question to libsensors, due to a memory leak in a program.
Precedence: fm-user
Content-Type: text/plain; charset=3D"iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Loop-Procmail: PreventLoop

Hello Frodo Looijaard,

I am a german student and currently writing a small graphical frontend for =
lm_sensors.
Everything works as I wish, but I encountered a small memory leak that has =
to do with the=20
"sensors_get_label"-function of libsensors.
I asked in several diskussion boards in the net, but nobody could help me.
(If I ask the wrong person, or if you don't find the time to help/answer, I=
 would be pleased if you could tell me=20
who I could ask).


One function, I wrote, uses the following commands:

   int i=3D0, nr1=3D0, nr2=3D0;
   const sensors_chip_name *    sensors_chip;
   const sensors_feature_data * sensor_data;

   sensors_chip =3D sensors_get_detected_chips( &i))
   sensor_data  =3D sensors_get_all_features( *sensors_chip, &nr1, &nr2))
   char * label;

   sensors_get_label ( *sensors_chip, sensor_data->number, &label);


The last of the seven lines is called periodically ( eg. all 3 seconds).
This causes a leak of 4 bytes about every 10 seconds (more or less).
Four byte ist not much, but unacceptable.
I am sure that the sensors_get_label-command is "guilty", because if I comm=
ent this line ( using //) I can run=20
my program for hours without "loosing" this four bytes periodically.

So I added the following line as adviced in your sensors.h (quote: "*result=
 is newly allocated (free it=20
yourself)").

   free( label);

But this did not change anything. The memory leak did not vanish.


I hope this is enough information so that you (or someone else) can help me=
.=20
How can I get rid of this memory leak?


Yours sincerely,

Michael Zwick

___________________________________________________________________________=
___
Die clevere Geldreserve: der DiBa-Privatkredit. Funktioniert wie ein Dispo,=
=20
ist aber viel g=FCnstiger! Alle Infos: http://diba.web.de/?mc=3D021104



--=20
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~fr=
odol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually follow=
ed
  by the installation of Linux or some other Unix-like operating system.
