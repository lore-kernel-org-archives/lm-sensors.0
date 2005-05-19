From: debry@cereve.enpc.fr (Edouard Debry)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: error when compiling lm_sensors
Message-Id: <20040204115112.GA4079@cereve.enpc.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

hello,

I had some pb to install lm_sensors_2.8.3 package, I did not know=20
who to talk to about this pb, so I first apologize if this mail=20
disturbs you

I currently run a 2.4.22 kernel ( slackware 9.1 ) and I tried to
install lm_sensors_2.8.3 package

first I patched the kernel with the advised patches on your downlaod
page :

>Users whose systems require additional i2c-related kernel modules (bttv,
>i2c-matrox, rivatv, zoran...) will require additional patches for the
>Linux 2.4.21 and 2.4.22 kernels. These patches fix compatibility
>differences between i2c-2.8.0 and the Linux 2.4 kernels. A complete
>installation guide is available here (and mirrored here).

the patch is called : unified patch for Linux 2.4.22 (i2c-2.8.2)
then I recompiled my kernel, with all i2c software in modules
it did well

then I downloaded : lm_sensors-2.8.3.tar.gz (FTP)
untared it and simply typed 'make' (as root) in the created lm-sensors=20
directory, the compilation seemed to go well until I get a compilation
error with one chip module wt**.c , sorry I did not remember the exact
error message bu it told that there was one undefined variable

my config is a MSI K7N2delta-l ( chip nforce2 ) and a cpu : AMD duron

do you know this problem ? may be there was an option to pass with
'make' command that I would have forgotten, may be when reading what
I have done you will obviously notice that I have forgotten one step

looking forward to hearing you
edouard

--=20
*-----------------------------------------------------------------*
|                          Edouard DEBRY                          |
| Ph-D student at E.N.P.C - C.E.R.E.A   http://www.enpc.fr/cerea/ |
|                                                                 |
| 21 Rue Nobel, Cit=E9 Descartes        TEL  : 33 1 64 15 21 52     |
| 77455 CHAMPS SUR MARNE              MAIL : debry@cerea.enpc.fr  |
|                                                                 |
| Thesis subject: MODELING OF AN ATMOSPHERIC AEROSOL DISTRIBUTION |
*-----------------------------------------------------------------*
