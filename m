From: debry@cereve.enpc.fr (Edouard Debry)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: lecture fan ?
Message-Id: <20040209160821.GA409@cereve.enpc.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

bonjour,

je viens d'installer lm_sensors 2.8.2, sur un noyau 2.4.22 ( patch=E9
comme conseill=E9 sur votre site ), ca marche, les temperatures ont l'air
corrects, seule la lecture des RPM des fans me donne une inqui=E9tude :

pour l'un d'eux ( fan2 ) j'obtiens 0 ou une valeur completement
fausse ( ce sont souvent les 4 derniers chiffres du min ),=20

j'ai suivi le conseil du FAQ, et j'ai regl=E9 le fan2_div
mais m=EAme en le r=E9glant =E0 8 voire 16, la valeur min indiqu=E9 par
'sensors' est incroyablement grande ( ~ 10000 RPM ) et je n'arrive
pas a la faire descendre plus bas

sur le premier fan ( fan1 ) j'obtiens une valeur correcte en ajustant=20
egalement le fan1_div, mais le min reste invariablement fixe a -1 RPM !!

lorsque je regarde les valeurs du bios, celui-ci ne me donne des valeurs
differentes de 0 que si la valeur en RPM est >=1500, mais a part ca les
valeurs du bios ont l'air correctes

donc je ne sais pas trop comment regler ce pb=20
je n'ai pas vu d'autre conseils dans votre FAQ, aussi me tourne vers
vous

cordialement
edouard

PS : ma CM est une MSI-K7N2 delta-l,=20
j'utilise les pilotes i2c-nforce2 i2c-isa eeprom w83627hf ( ou ..fh )
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
