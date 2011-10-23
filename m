From: Krys Allen <allen.krys@gmail.com>
Date: Sun, 23 Oct 2011 21:02:48 +0000
Subject: [lm-sensors] New fintek f718xx driver now available, please test
Message-Id: <CAN0S9cUDs03R9fW=VaFpXOVUvB3pfTN1WYx7_2rGVe9egZmxdg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6330055422728905924=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4D77DAB5.6080601@redhat.com>
In-Reply-To: <4D77DAB5.6080601@redhat.com>
To: lm-sensors@vger.kernel.org

--===============6330055422728905924==
Content-Type: multipart/alternative; boundary=bcaec51dd5cfecc76d04affda0e5

--bcaec51dd5cfecc76d04affda0e5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I get a few errors when trying to make on ubuntu 10.04, any ideas?


root@mediaserver:/home/krys# make
make -C /lib/modules/2.6.32-33-generic/build M=3D/home/krys modules
make[1]: Entering directory `/usr/src/linux-headers-2.6.32-33-generic'
  CC [M]  /home/krys/f71882fg.o
/home/krys/f71882fg.c: In function =E2superio_enter=E2:
/home/krys/f71882fg.c:997: error: implicit declaration of function
=E2request_muxed_region=E2
/home/krys/f71882fg.c: In function =E2f71882fg_find=E2:
/home/krys/f71882fg.c:2425: error: implicit declaration of function
=E2pr_warn=E2
make[2]: *** [/home/krys/f71882fg.o] Error 1
make[1]: *** [_module_/home/krys] Error 2
make[1]: Leaving directory `/usr/src/linux-headers-2.6.32-33-generic'
make: *** [all] Error 2

--bcaec51dd5cfecc76d04affda0e5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>I get a few errors when trying to make on ubuntu 10.04, any ideas?</di=
v><div><br></div><div><br></div><div>root@mediaserver:/home/krys# make</div=
><div>make -C /lib/modules/2.6.32-33-generic/build M=3D/home/krys modules</=
div>
<div>make[1]: Entering directory `/usr/src/linux-headers-2.6.32-33-generic&=
#39;</div><div>=A0 CC [M] =A0/home/krys/f71882fg.o</div><div>/home/krys/f71=
882fg.c: In function =E2superio_enter=E2:</div><div>/home/krys/f71882fg.c:9=
97: error: implicit declaration of function =E2request_muxed_region=E2</div=
>
<div>/home/krys/f71882fg.c: In function =E2f71882fg_find=E2:</div><div>/hom=
e/krys/f71882fg.c:2425: error: implicit declaration of function =E2pr_warn=
=E2</div><div>make[2]: *** [/home/krys/f71882fg.o] Error 1</div><div>make[1=
]: *** [_module_/home/krys] Error 2</div>
<div>make[1]: Leaving directory `/usr/src/linux-headers-2.6.32-33-generic&#=
39;</div><div>make: *** [all] Error 2</div>

--bcaec51dd5cfecc76d04affda0e5--


--===============6330055422728905924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6330055422728905924==--
